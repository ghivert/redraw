import React from "react"
import runtime from "react/jsx-runtime"
import * as gleam from "./gleam.mjs"
import { propsToGleamProps, gleamPropsToProps } from "./props.ffi.mjs"

/** Keep display name on Wrapper, to correctly display Components
 * in React devtools. */
function propagateDisplayName(Component, Wrapper) {
  if (Component.displayName) Wrapper.displayName = Component.displayName
  return Wrapper
}

/** Adds a wrapper that converts props from React props to Gleam props. */
function wrapComputeProps(Component, originalProps) {
  return propagateDisplayName(Component, (props, ...rest) => {
    const newProps = propsToGleamProps(props, originalProps)
    return Component(newProps, ...rest)
  })
}

/** Extract the Component's children from the props to feed it to the function
 * directly. */
export function wrapConvertChildren(Component) {
  return propagateDisplayName(Component, (props) => {
    const children = gleam.List.fromArray(props.children)
    return Component(props, children)
  })
}

/** In Gleam, a `component` will have shape
 * `fn (props, children) -> Component`. `wrapComponent` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props, children) -> jsx(Component)` by extracting the children
 * from the props. */
export function wrapComponent(Component) {
  const originalProps = { current: {} }
  const PropsConverted = wrapComputeProps(Component)
  const ChildrenAdded = wrapConvertChildren(PropsConverted, originalProps)
  return propagateDisplayName(Component, (props_, children) => {
    const props = gleamPropsToProps(props_, originalProps)
    if (props) return jsx(ChildrenAdded, props, children)
    const render = propagateDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/** In Gleam, a `component__` will have shape
 * `fn () -> Component`. `wrapStandalone` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn () -> jsx(Component)` by extracting the children
 * from the props. */
export function wrapStandalone(Component) {
  return propagateDisplayName(Component, () => {
    return jsx(Component, {})
  })
}

/** In Gleam, a `component_` will have shape
 * `fn (props) -> Component`. `wrapStandalone` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props) -> jsx(Component)` by extracting the children
 * from the props. */
export function wrapElement(Component) {
  const originalProps = { current: {} }
  const PropsConverted = wrapComputeProps(Component, originalProps)
  return propagateDisplayName(Component, (props_) => {
    const props = gleamPropsToProps(props_, originalProps)
    if (props) return jsx(PropsConverted, props)
    const render = propagateDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/**  Generate JSX using the JSX factory.
 * `runtime.jsx` is for dynamic components,
 * while `runtime.jsxs` is for static components. */
export function jsx(value, props_, children_) {
  if (value === "none_") return null
  if (value === "text_") return children_
  let children = children_?.toArray?.()
  let isStatic = true

  // Handle keyed elements like lustre does.
  // This allow to have a similar interface between Lustre and Redraw.
  if (Array.isArray(children?.[0])) {
    children = children.map((c) => {
      const [key, node] = c
      if ("key" in node) return React.cloneElement(node, { key })
      return node
    })
    isStatic = false
  }

  // Props creation.
  // Uses the existing props, and add children if needed.
  const props = {}
  Object.assign(props, props_)
  if (children?.length > 0) props.children = children

  if (isStatic) {
    return runtime.jsxs(value, props)
  } else {
    return runtime.jsx(value, props)
  }
}

/** Set the display name function. Essential to display the correct name in
 * the devtools. */
export function setFunctionName(component, name) {
  component.displayName = name
  return component
}

export function strictMode(children) {
  return jsx(React.StrictMode, {}, children)
}

export function fragment(children) {
  return jsx(React.Fragment, {}, children)
}

export function profiler(children) {
  return jsx(React.Profiler, {}, children)
}

export function suspense(props, children) {
  return jsx(React.Suspense, props, children)
}

export function coerce(value) {
  return value
}

export function setCurrent(ref, value) {
  ref.current = value
}

export function getCurrent(ref) {
  return ref.current
}
