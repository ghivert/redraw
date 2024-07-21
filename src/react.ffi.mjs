import React from "react"
import ReactDOM from "react-dom/client"
import runtime from "react/jsx-runtime"
import * as gleam from "./gleam.mjs"

/**  Keep display name on Wrapper, to correctly display Components
 * in React devtools. */
function withDisplayName(Component, Wrapper) {
  if (Component.displayName) Wrapper.displayName = Component.displayName
  return Wrapper
}

function withComputedProps(Component, originalProps) {
  return withDisplayName(Component, (props, ...rest) => {
    if (!originalProps.current) return Component(props, ...rest)
    const [Prototype, firstProps] = originalProps.current[props.__propsType]
    // if (originalProps.toArray) {
    //   const newProps = []
    //   for (const prop of Object.values(props)) {
    //     newProps.push(prop)
    //   }
    //   return Component(gleam.List.fromArray(newProps), ...rest)
    // }
    const values = Object.keys(firstProps).map((key) => props[key])
    const newProps = new Prototype.constructor(...values)
    return Component(newProps, ...rest)
  })
}

function convertProps(props) {
  if (props.toArray) return props.toArray()
  return props
}

export function createRoot(value) {
  const node = document.getElementById(value)
  return ReactDOM.createRoot(node)
}

export function hydrateRoot(value, content) {
  const node = document.getElementById(value)
  return ReactDOM.hydrateRoot(node, content)
}

export function createPortal(children, root) {
  const node = document.getElementById(root)
  return ReactDOM.createPortal(children, node)
}

export function render(root, children) {
  return root.render(children)
}

/** Wrap the Component in a `forwardRef`, and inject the `ref` from the function
 * arguments to the props. In Gleam, when called, a `forwardRef` component will
 * have shape`fn (props, ref) -> Component`. `addForwardRef` turns it into
 * `fn (props) -> jsx(Component)`.*/
export function addForwardRef(Component) {
  const originalProps = { current: {} }
  const added = React.forwardRef(withComputedProps(Component, originalProps))
  return withDisplayName(Component, (props_, ref) => {
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name, ref }
    return jsx(added, props)
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
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name, ref }
    return jsx(added, props, children)
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
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name }
    return jsx(childrenAdded, props, children)
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
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name }
    return jsx(added, props)
  })
}

/**  Generate JSX using the JSX factory.
 * `jsx` is for dynamic components, while `jsxs` is for static components. */
export function jsx(value, props_, children_) {
  if (value === "text_") return children_
  let children = children_?.toArray?.()
  let isStatic = true

  // Handle keyed elements like lustre does.
  // This allow to have a similar interface between lustre and greact.
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

export function contextProvider(context, value, children) {
  return jsx(context.Provider, { value }, children)
}

export function setCurrent(ref, value) {
  ref.current = value
}

export function getCurrent(ref) {
  return ref.current
}

export function toProps(attributes) {
  const props = {}
  for (const item of attributes) {
    props[item.key] = item.content
  }
  return props
}

/** Used to camelize CSS property names. */
function camelize(key) {
  return key.replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
}

/** Turns a `List(#(String, String))` into an object `{ [key: string]: string }`
 * to conform with the React `style` API. */
export function convertStyle(styles) {
  const styles_ = {}
  for (const style of styles) {
    styles_[camelize(style[0])] = style[1]
  }
  return styles_
}

export function innerHTML(html) {
  return { __html: html }
}
