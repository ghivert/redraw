import React from "react"
import runtime from "react/jsx-runtime"
import * as gleam from "./gleam.mjs"
import { propsToGleamProps, gleamPropsToProps } from "./props.ffi.mjs"

/** Keep display name on Wrapper, to correctly display Components
 * in React devtools. */
function withDisplayName(Component, Wrapper) {
  if (Component.displayName) Wrapper.displayName = Component.displayName
  return Wrapper
}

function withComputedProps(Component, originalProps) {
  return withDisplayName(Component, (props, ...rest) => {
    const newProps = propsToGleamProps(props, originalProps)
    return Component(newProps, ...rest)
  })
}

/** Wrap the Component in a `forwardRef`, and inject the `ref` from the function
 * arguments to the props. In Gleam, when called, a `forwardRef` component will
 * have shape`fn (props, ref) -> Component`. `addForwardRef` turns it into
 * `fn (props) -> jsx(Component)`.*/
export function addForwardRef(Component) {
  const originalProps = { current: {} }
  const added = React.forwardRef(withComputedProps(Component, originalProps))
  return withDisplayName(Component, (props_, ref) => {
    const props = gleamPropsToProps(props_, originalProps, ref)
    if (props) return jsx(added, props)
    const render = withDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/** Wrap the Component in a `forwardRef`, and inject the `ref` from the function
 * arguments to the props. In Gleam, a `forwardRef` component will have shape
 * `fn (props, ref, children) -> Component`. `addChildrenForwardRef` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props, ref, children) -> jsx(Component)` by extracting the children
 * from the props. */
export function addChildrenForwardRef(Component) {
  const originalProps = { current: {} }
  const added = React.forwardRef(
    withRefChildren(withComputedProps(Component, originalProps)),
  )
  return withDisplayName(Component, (props_, ref, children) => {
    const props = gleamPropsToProps(props_, originalProps, ref)
    if (props) return jsx(added, props, children)
    const render = withDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/** Extract the Component's children from the props to feed it to the function
 * directly. */
export function withChildren(Component) {
  return withDisplayName(Component, (props) => {
    const children = gleam.List.fromArray(props.children)
    return Component(props, children)
  })
}

/** Extract the Forwarded Ref Component's children from the props to feed it to
 * the function directly. */
export function withRefChildren(Component) {
  return withDisplayName(Component, (props, ref) => {
    const children = gleam.List.fromArray(props.children)
    return Component(props, ref, children)
  })
}

/** In Gleam, a `component` will have shape
 * `fn (props, children) -> Component`. `addChildrenProxy` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props, children) -> jsx(Component)` by extracting the children
 * from the props. */
export function addChildrenProxy(Component) {
  const originalProps = { current: {} }
  const childrenAdded = withChildren(
    withComputedProps(Component),
    originalProps,
  )
  return withDisplayName(Component, (props_, children) => {
    const props = gleamPropsToProps(props_, originalProps)
    if (props) return jsx(childrenAdded, props, children)
    const render = withDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/** In Gleam, a `component__` will have shape
 * `fn () -> Component`. `addEmptyProxy` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn () -> jsx(Component)` by extracting the children
 * from the props. */
export function addEmptyProxy(Component) {
  return withDisplayName(Component, () => {
    return jsx(Component, {})
  })
}

/** In Gleam, a `component_` will have shape
 * `fn (props) -> Component`. `addEmptyProxy` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props) -> jsx(Component)` by extracting the children
 * from the props. */
export function addProxy(Component) {
  const originalProps = { current: {} }
  const added = withComputedProps(Component, originalProps)
  return withDisplayName(Component, (props_) => {
    const props = gleamPropsToProps(props_, originalProps)
    if (props) return jsx(added, props)
    const render = withDisplayName(Component, () => null)
    return jsx(render, {})
  })
}

/**  Generate JSX using the JSX factory.
 * `jsx` is for dynamic components, while `jsxs` is for static components. */
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
