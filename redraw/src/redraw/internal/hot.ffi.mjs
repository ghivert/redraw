// Development-only bridge between Redraw and React Fast Refresh.
//
// Everything in this module is a no-op unless a React Refresh runtime has been
// installed on `globalThis.__REDRAW_REFRESH__`. `vite-plugin-redraw` does it
// in development, using the runtime shipped by `@vitejs/plugin-react`. In
// production, no runtime is installed, and no transform is applied, so the
// functions below are never reached, except `register`, which returns
// immediately.
//
// How it works: Gleam cannot run code at module level, so Redraw components
// are only created when their factory (`fn counter() { ... }`) is called in
// the `compose` chain. Fast Refresh identifies components by a stable id and
// swaps "families" of types. `register` gives every wrapper created by
// `component_` and `compose` such an id, derived from the module path (tagged
// by the Vite transform), the display name, and the arguments of the factory
// when it has some. When a module is hot updated, the Vite transform calls
// `rerun` with the module factories: they create new wrappers, registered
// under the same ids, and `refresh` asks React to swap them in place, keeping
// the state of mounted components.
//
// Some edits cannot be applied to a running application: a removed variant
// still held in a state, a record whose fields changed, a component that was
// renamed or removed, a change in `main`, which runs once. Those are detected
// when the updated module re-evaluates, and the page is reloaded, with the
// reason printed in the console.

import React from "react"
import * as $gleam from "../../gleam.mjs"

const contexts = new Map()
const invocations = new Map()
const classes = new Map()
const moduleTypes = new Map()
const moduleIds = new Map()
const bootstraps = new Map()
const moduleExports = new Map()
let reloading = false

/** Functions of the React Refresh runtime this module relies on. The
 * runtime shipped by `@vitejs/plugin-react` is not a public API: when a
 * version stops exporting one of them, Fast Refresh is disabled with a
 * warning, instead of failing at the first hot update. */
const REQUIRED = [
  "register",
  "createSignatureFunctionForTransform",
  "validateRefreshBoundaryAndEnqueueUpdate",
]
let checked = null

function runtime() {
  if (typeof globalThis === "undefined") return null
  const refresh = globalThis.__REDRAW_REFRESH__
  if (!refresh) return null
  if (checked !== refresh) {
    checked = refresh
    const missing = REQUIRED.filter((name) => typeof refresh[name] !== "function")
    if (missing.length > 0) {
      console.warn(
        `[redraw] The React Refresh runtime does not export ${missing.join(", ")}: Fast Refresh is disabled. This version of @vitejs/plugin-react is not supported by redraw.`,
      )
      globalThis.__REDRAW_REFRESH__ = null
      return null
    }
  }
  return refresh
}

/** Called by the Vite transform around every render function passed to
 * `component_`. Attaches the module id, the hooks signature and the factory
 * arguments to the render function, so that `register` can use them later. */
export function tag(module, signature, customHooks, render, args) {
  if (typeof render === "function")
    render.__redrawHot = { module, signature, customHooks, args }
  return render
}

/** Called by the Vite transform for every module-level custom hook (functions
 * starting with `use_`). Lets React Refresh detect hooks order changes inside
 * custom hooks. */
export function hook(fn, signature, customHooks) {
  const refresh = runtime()
  if (!refresh || typeof fn !== "function") return fn
  setSignature(refresh, fn, signature, customHooks)
  return fn
}

/** Called by `wrapReactComponent` and `wrapCall`. `type` is the React type to
 * register (a function or a `React.memo` object), `source` is the function it
 * was built from, carrying the display name and the hot metadata. */
export function register(type, source, suffix = "") {
  const refresh = runtime()
  if (!refresh) return type
  const meta = source?.__redrawHot
  const name = source?.displayName ?? source?.name
  if (!name) return type
  if (meta) {
    type.__redrawHot = meta
    if (meta.signature !== undefined)
      setSignature(refresh, type, meta.signature, meta.customHooks)
  }
  const module = meta?.module ? meta.module + " " : ""
  // Components built by a parameterized factory are distinct components for
  // every set of arguments: `button(Primary)` and `button(Secondary)` must
  // not share a Fast Refresh family, or they would both end up rendering
  // with the last registered one.
  const args = meta?.args ? " " + serialize(meta.args) : ""
  const id = module + name + args + suffix
  // Only the plain id is tracked for the missing components check: the
  // memoized wrapper is registered by `compose`, in the module of the parent,
  // and is not re-registered by the re-run of this module. React does not
  // need it to be: the inner fiber is resolved through its own family.
  if (meta?.module && !suffix) remember(moduleIds, meta.module, id)
  refresh.register(type, id)
  return type
}

/** Called by the Vite transform at the start of every parameterized factory.
 * Remembers the arguments of each call, so that the factory can be replayed
 * after a hot update of its module. Calls are deduplicated by the serialized
 * arguments, so the registry stays bounded. */
export function invoked(key, args) {
  if (!runtime()) return
  let calls = invocations.get(key)
  if (!calls) {
    calls = new Map()
    invocations.set(key, calls)
  }
  calls.set(serialize(args), args)
}

/** Called by the Vite transform after every custom type class declaration.
 * Every Gleam value is an instance of a class, and the compiled code matches
 * them with `instanceof`. After a hot update, the module defines new classes,
 * while values built by modules that were not updated, or kept in hooks
 * state, are instances of the previous ones. Both generations are reconciled:
 *
 * - Previous instances become instances of the new class, by chaining the
 *   previous prototype to the new one. Their `constructor` resolves to the
 *   new class too, so that the prelude `isEqual` and `withFields` see a
 *   single class.
 * - Code that was not updated keeps matching with the previous class: its
 *   `Symbol.hasInstance` is redirected to the new class, so that new
 *   instances are recognized as well.
 *
 * Previous instances keep their fields though. When the constructor arity
 * changes, fields were added or removed, and the page is reloaded. */
export function type(key, Class) {
  if (!runtime()) return Class
  const previous = classes.get(key)
  if (previous && previous !== Class) {
    if (previous.length !== Class.length) {
      reload(`the fields of ${key} changed`)
    }
    Object.setPrototypeOf(previous.prototype, Class.prototype)
    // Without an own `constructor`, the lookup walks the chain up to the
    // newest class, whatever the number of generations in between.
    delete previous.prototype.constructor
    Object.defineProperty(previous, Symbol.hasInstance, {
      configurable: true,
      value: (value) => value instanceof Class,
    })
  }
  classes.set(key, Class)
  return Class
}

/** Called by the Vite transform at the end of every module, with the names
 * of the classes it declares. A class that disappeared is a removed or
 * renamed variant: values of that variant may still be held in a state, and
 * no new class can take them over, so the page is reloaded. */
export function types(module, names) {
  if (!runtime()) return
  const previous = moduleTypes.get(module)
  moduleTypes.set(module, new Set(names))
  if (!previous) return
  for (const name of previous) {
    if (!names.includes(name)) {
      reload(`${name} was removed from ${module}`)
      return
    }
  }
}

/** Called by the Vite transform at the end of a module defining `main`, with
 * a hash of its code. `main` runs once, so a change in it cannot be applied
 * without reloading the page. */
export function bootstrap(module, hash) {
  if (!runtime()) return
  const previous = bootstraps.get(module)
  bootstraps.set(module, hash)
  if (previous !== undefined && previous !== hash) {
    reload(`main changed in ${module}`)
  }
}

/** Called by the Vite transform at the end of a module with factories, with
 * a hash of the module and a hash of every export that is not a factory.
 * Importers hold those exports through ESM bindings to the previous instance
 * of the module. The trailer invalidates the module, so that the update
 * propagates to the importers, when this returns `true`:
 *
 * - The module was edited, and one of those exports changed.
 * - The module was not edited, so it was re-executed because a dependency
 *   changed, and it has such exports: through them, importers still reach
 *   the previous dependency. */
export function exports(module, moduleHash, hashes) {
  if (!runtime()) return false
  const previous = moduleExports.get(module)
  moduleExports.set(module, { moduleHash, hashes })
  if (!previous) return false
  const names = new Set([...Object.keys(previous.hashes), ...Object.keys(hashes)])
  if (previous.moduleHash === moduleHash) return names.size > 0
  for (const name of names) {
    if (previous.hashes[name] !== hashes[name]) return true
  }
  return false
}

/** Called by the Vite transform in place of `create_context_`. Contexts are
 * created inside factories too, so re-running a factory would create a new
 * context identity: providers would move to the new one while consumers keep
 * the old one. Contexts are kept by call site instead. The default value of
 * a context cannot be changed after its creation: when it changes, the page
 * is reloaded. */
export function context(key, defaultValue) {
  if (!runtime()) return React.createContext(defaultValue)
  const serialized = serialize(defaultValue)
  let entry = contexts.get(key)
  if (!entry) {
    entry = { context: React.createContext(defaultValue), serialized }
    contexts.set(key, entry)
  } else if (entry.serialized !== serialized) {
    reload(`the default value of a context changed in ${key}`)
  }
  return entry.context
}

/** Called by the Vite transform when a module is re-evaluated after a hot
 * update. Re-runs the module factories to register the new render functions,
 * then asks React to refresh. `factories` are the zero-argument factories,
 * `parameterized` maps a factory key to the new function, replayed with the
 * arguments recorded by `invoked`.
 *
 * Every component of the module registered before the update must be
 * registered again by the re-run: otherwise, its mounted instances would
 * keep the previous code. That happens when a component is removed, renamed,
 * or moved to another module, and the page is reloaded.
 *
 * When a factory throws, the new code is broken: as React Refresh does, the
 * error is reported, the application keeps the previous code, and the next
 * save tries again. */
export function rerun(module, factories, parameterized = {}) {
  if (!runtime()) return
  const previous = moduleIds.get(module) ?? new Set()
  moduleIds.set(module, new Set())
  let failed = false
  for (const factory of factories) failed = !attempt(factory) || failed
  for (const [key, factory] of Object.entries(parameterized)) {
    const calls = invocations.get(key)
    if (!calls) continue
    for (const args of calls.values()) failed = !attempt(factory, args) || failed
  }
  const current = moduleIds.get(module)
  if (failed) {
    moduleIds.set(module, new Set([...previous, ...current]))
    return
  }
  for (const id of previous) {
    if (!current.has(id)) {
      reload(`the component "${id}" was removed or renamed`)
      return
    }
  }
  refresh()
}

function attempt(factory, args = []) {
  try {
    factory(...args)
    return true
  } catch (error) {
    console.error(
      "[redraw] A component factory threw while re-running after a hot update. The application keeps the previous code until the next successful save.",
      error,
    )
    return false
  }
}

/** Enqueue a React Refresh. The runtime shipped by `@vitejs/plugin-react`
 * does not export `performReactRefresh`, but enqueues one when a module whose
 * exports are all components is validated. A marker export satisfies that
 * check. */
export function refresh() {
  const refresh = runtime()
  if (!refresh) return
  const exports = { Redraw: function Redraw() {} }
  refresh.validateRefreshBoundaryAndEnqueueUpdate("redraw:hot", exports, exports)
}

/** Reloads the page once, with the reason printed in the console. */
function reload(reason) {
  if (reloading) return
  reloading = true
  console.warn(
    `[redraw] ${reason}: this change cannot be applied with Fast Refresh, reloading the page.`,
  )
  globalThis.location?.reload()
}

function remember(registry, key, value) {
  let values = registry.get(key)
  if (!values) {
    values = new Set()
    registry.set(key, values)
  }
  values.add(value)
}

function setSignature(refresh, type, signature, customHooks) {
  const sign = refresh.createSignatureFunctionForTransform()
  sign(type, signature, false, customHooks)
}

/** Structural, deterministic serialization of Gleam values, used to tell
 * apart the components built by a parameterized factory. Gleam values are
 * never cyclic. Named functions are serialized by their name, which covers
 * Redraw components passed as arguments. Anonymous functions are serialized
 * by a hash of their source code: it is stable across factory re-runs, which
 * recreate every closure, and differs between closures with different code.
 * Two closures with the same code capturing different values still share an
 * identity. */
const MAX_LENGTH = 200

function serialize(value) {
  const output = serializeValue(value, 0)
  if (output.length <= MAX_LENGTH) return output
  return "#" + hash(output)
}

function serializeValue(value, depth) {
  if (depth > 8) return "…"
  // Gleam `Nil` compiles to `undefined`.
  if (value === undefined) return "Nil"
  if (value === null) return "null"
  switch (typeof value) {
    case "string":
      return JSON.stringify(value)
    case "number":
    case "boolean":
    case "bigint":
      return String(value)
    case "symbol":
      return value.toString()
    case "function": {
      const name = value.displayName ?? value.name
      if (name) return "fn:" + name
      return "fn#" + hash(String(value))
    }
    case "object": {
      const next = depth + 1
      const items = (values) =>
        values.map((item) => serializeValue(item, next)).join(",")
      if (value instanceof $gleam.List) return "[" + items(value.toArray()) + "]"
      // Tuples compile to arrays.
      if (Array.isArray(value)) return "#(" + items(value) + ")"
      if (value instanceof $gleam.BitArray)
        return "<<" + items([...$gleam.BitArray$BitArray$data(value)]) + ">>"
      if (value instanceof $gleam.UtfCodepoint) return "cp:" + value.value
      const name = value.constructor?.name ?? "Object"
      const fields = Object.keys(value).map(
        (key) => key + ":" + serializeValue(value[key], next),
      )
      return name + "(" + fields.join(",") + ")"
    }
    default:
      return String(value)
  }
}

function hash(input) {
  let h = 5381
  for (let i = 0; i < input.length; i++) h = ((h << 5) + h + input.charCodeAt(i)) | 0
  return (h >>> 0).toString(36)
}
