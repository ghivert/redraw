import React from "react"
import runtime from "react/jsx-runtime"
import { List } from "./gleam.mjs"
import { DevelopmentOnly, OwnerStackUnavailable } from "./redraw.mjs"
import * as $props from "./props.ffi.mjs"

export const memoize$ = Symbol("Redraw:Memo:Use")
export const children$ = Symbol("Redraw:Children")

/**
 * The conversion is a bit hard to follow, so here's the road:
 * 1. Write a Redraw Component: i.e. a Gleam function wrapped in redraw.component.
 * 2. The Gleam function has the shape fn (props, children) -> Component.
 * 3. The output when executing that function will be something like `jsx(Compoment, props)`.
 * 4. Because props are simple JS objects, they can't be sent as-is to React.
 *    They're converted first.
 * 5. After they have been converted, to be read in the component, they should
 *    be reconverted once again, from JS to Gleam.
 *
 * Component is called
 * -> calls underlying components function
 * -> function convert props and calls `jsx(Component, props)`
 * -> underlying component is called by runtime
 * -> wrapper convert props to Gleam
 * -> Component is called
 *
 * To properly write React component with Redraw, they're should be 2 wrappers:
 * one that will convert props when called from another component (let's call it
 * a constructor), and one that will convert props. The structure is then as
 * follows (pseudo-code in Gleam):
 *
 * fn create_component(render: fn (props, children) -> Component) {
 *   // Component here should be considered as "global", otherwise bad things happen.
 *   let component = fn (props, children) { render(props.to_gleam(props), children )}
 *   fn (props, children) {
 *     let props = props.from_gleam(props)
 *     jsx(component, props, children)
 *   }
 * }
 */

/** Keep display name on Wrapper, to correctly display Components
 * in React devtools. */
function propagateDisplayName(Component, Wrapper) {
  if (Component.displayName) Wrapper.displayName = Component.displayName
  return Wrapper
}

/** Adds a wrapper that converts props from React props to Gleam props.
 *
 * In Gleam, a `component` will have shape
 * `fn (props) -> Component`. `wrapComponent` turns it
 * into `fn (props) -> jsx(Component)`. It will then be transformed once again
 * to `fn (props) -> jsx(Component)` by extracting the children
 * from the props. */
export function wrapComponent(Component) {
  return propagateDisplayName(Component, (props) => {
    const newProps = $props.propsToGleamProps(props)
    return Component(newProps)
  })
}

export function wrapCall(Component) {
  const PropsConverted = Component().render
  const Memoized = React.memo(PropsConverted, $props.areEqual)
  return function (props_) {
    const props = $props.gleamPropsToProps(props_)
    const isMemo = Component.memoize === memoize$
    const Comp = isMemo ? Memoized : PropsConverted
    return jsx(Comp, props)
  }
}

export function memoize(render) {
  if (!render) return render
  render.memoize = memoize$
  return render
}

export function contextProvider(context, value, children) {
  const props = { value }
  const shouldConvertChildren = true
  return jsx(context, props, children, shouldConvertChildren)
}

/**  Generate JSX using the JSX factory.
 * `runtime.jsx` is for dynamic components,
 * while `runtime.jsxs` is for static components. */
export function jsx(value, props, children, shouldConvertChildren = false) {
  if (value === "none_") return null
  if (value === "text_") return children
  let isStatic = true

  // `jsx` assumes `props` are an object, with iterable properties.
  // Redraw makes sure props are always objects, because they're automatically
  // converted when the component executes.
  props = Object.assign({}, props)

  // Props will only be converted for HTML elements. For anything else than
  // HTML elements, simply forward the children.
  if (shouldConvertChildren) {
    if (children instanceof List) {
      children = children.toArray()
      if (children.length === 0) {
        children = undefined
      }
    }
    // Handle keyed elements like lustre does.
    // This allow to have a similar interface between Lustre and Redraw.
    // If children[0] is an array, it means it's a tuple #(key, element).
    // Because at the end, React will paint to the DOM, keys make sense only
    // for children that will be painted to the DOM, and as such, with props
    // converted.
    if (children?.[0] && Array.isArray(children[0])) {
      isStatic = false
      children = children.map((c) => {
        const [key, node] = c
        if ("key" in node) return React.cloneElement(node, { key })
        return node
      })
    }
  }

  // Append the children in the props. They potentially have been converted, or
  // are propagated as-is. JavaScript makes no differences if `children` are
  // undefined or not.
  if (children !== undefined) {
    // When converting children, it means we're in an `Element`.
    // To satisfy the React API, children should be put in `children` property.
    if (shouldConvertChildren) props.children = children
    // When not converting children, it means we're in a `Component`.
    // As such, children should be reconverted after conversion.
    else props[children$] = children
  }

  if (isStatic && Array.isArray(props.children)) {
    return runtime.jsxs(value, props)
  } else {
    return runtime.jsx(value, props)
  }
}

/** Set the display name function. Essential to display the correct name in
 * the devtools. */
export function setDisplayName(component, name) {
  component.displayName = name
  return component
}

export function strictMode(children) {
  const shouldConvertChildren = true
  return jsx(React.StrictMode, {}, children, shouldConvertChildren)
}

export function fragment(children) {
  const shouldConvertChildren = true
  return jsx(React.Fragment, {}, children, shouldConvertChildren)
}

export function profiler(children) {
  const shouldConvertChildren = true
  return jsx(React.Profiler, {}, children, shouldConvertChildren)
}

export function suspense(props, children) {
  const shouldConvertChildren = true
  return jsx(React.Suspense, props, children, shouldConvertChildren)
}

export function captureOwnerStack() {
  if ("captureOwnerStack" in React) {
    const result = React.captureOwnerStack()
    if (result) return new Ok(result)
    const error = new OwnerStackUnavailable()
    return new Error(error)
  }
  const error = new DevelopmentOnly()
  return new Error(error)
}
