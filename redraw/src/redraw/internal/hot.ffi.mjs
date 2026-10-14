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
// by the Vite transform) and the display name. When a module is hot updated,
// the Vite transform calls `rerun` with the module factories: they create new
// wrappers, registered under the same ids, and `refresh` asks React to swap
// them in place, keeping the state of mounted components.

import React from "react"

const contexts = new Map()

function runtime() {
  if (typeof globalThis === "undefined") return null
  return globalThis.__REDRAW_REFRESH__ ?? null
}

/** Called by the Vite transform around every render function passed to
 * `component_`. Attaches the module id and the hooks signature to the render
 * function, so that `register` can use them later. */
export function tag(module, signature, customHooks, render) {
  if (typeof render === "function")
    render.__redrawHot = { module, signature, customHooks }
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
  refresh.register(type, module + name + suffix)
  return type
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
 * then asks React to refresh. */
export function rerun(factories) {
  if (!runtime()) return
  for (const factory of factories) {
    try {
      factory()
    } catch (error) {
      console.error("[redraw] Could not re-run a component factory", error)
    }
  }
  refresh()
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
