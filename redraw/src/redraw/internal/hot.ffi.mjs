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

import React from "react"
import * as $gleam from "../../gleam.mjs"

const contexts = new Map()
const invocations = new Map()
const types = new Map()

function runtime() {
  if (typeof globalThis === "undefined") return null
  return globalThis.__REDRAW_REFRESH__ ?? null
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
  refresh.register(type, module + name + args + suffix)
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
 *   instances are recognized as well. */
export function type(key, Class) {
  if (!runtime()) return Class
  const previous = types.get(key)
  if (previous && previous !== Class) {
    Object.setPrototypeOf(previous.prototype, Class.prototype)
    // Without an own `constructor`, the lookup walks the chain up to the
    // newest class, whatever the number of generations in between.
    delete previous.prototype.constructor
    Object.defineProperty(previous, Symbol.hasInstance, {
      configurable: true,
      value: (value) => value instanceof Class,
    })
  }
  types.set(key, Class)
  return Class
}

/** Called by the Vite transform in place of `create_context_`. Contexts are
 * created inside factories too, so re-running a factory would create a new
 * context identity: providers would move to the new one while consumers keep
 * the old one. Contexts are kept by call site instead. */
export function context(key, defaultValue) {
  if (!runtime()) return React.createContext(defaultValue)
  let context = contexts.get(key)
  if (!context) {
    context = React.createContext(defaultValue)
    contexts.set(key, context)
  }
  return context
}

/** Called by the Vite transform when a module is re-evaluated after a hot
 * update. Re-runs the module factories to register the new render functions,
 * then asks React to refresh. `factories` are the zero-argument factories,
 * `parameterized` maps a factory key to the new function, replayed with the
 * arguments recorded by `invoked`. */
export function rerun(factories, parameterized = {}) {
  if (!runtime()) return
  for (const factory of factories) attempt(factory)
  for (const [key, factory] of Object.entries(parameterized)) {
    const calls = invocations.get(key)
    if (!calls) continue
    for (const args of calls.values()) attempt(factory, args)
  }
  refresh()
}

function attempt(factory, args = []) {
  try {
    factory(...args)
  } catch (error) {
    console.error("[redraw] Could not re-run a component factory", error)
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

function setSignature(refresh, type, signature, customHooks) {
  const sign = refresh.createSignatureFunctionForTransform()
  sign(type, signature, false, customHooks)
}

/** Structural, deterministic serialization of Gleam values, used to tell
 * apart the components built by a parameterized factory. Gleam values are
 * never cyclic. Functions are serialized by their name, which covers Redraw
 * components passed as arguments, but not anonymous functions: two
 * instantiations differing only by anonymous functions share an identity. */
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
    case "function":
      return "fn:" + (value.displayName ?? value.name ?? "")
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
