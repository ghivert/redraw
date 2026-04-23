//// Composing a basic feature in React and Redraw. All the time, Redraw
//// requires to compose components in order to get a better, wider interface.
//// To do this, Redraw provides a function `redraw.compose`, which extracts
//// the component from a `ReactComponent`, and provides it as a function for
//// the user to use. `redraw/compose` provides multiple helpers to simplify
//// the usage of `ReactComponent` and improve ergonomics over the default
//// `redraw.compose`.

import redraw.{type Element, type ReactComponent}

/// Static components are everywhere. Static components are defined as static
/// when they don't refresh according to their props. They can refresh due to
/// some hooks, but otherwise they will never refresh at all. In Redraw, this is
/// illustrated when expected props are `Nil`. In that case, the component's
/// props will never change, and they provide no value.
///
/// With classic `redraw.compose`, we are forced to explicitely provide `Nil`
/// to the component.
///
/// ```gleam
/// fn my_component() {
///   use other <- redraw.compose(other())
///   use _ <- redraw.component_("MyComponent")
///   // Here we have to explicitely pass `Nil`.
///   other(Nil)
/// }
/// ```
///
/// `compose.static` provides better ergonomics, and avoid passing those `Nil`
/// props, and will inject `Nil` automtically. This simplifies usage, especially
/// when some other functions expects arguments looking like `fn () -> a`.
///
/// ```gleam
/// fn my_component() {
///   use other <- compose.static(other())
///   use _ <- redraw.component_("MyComponent")
///   // Here `Nil` is omitted.
///   other()
/// }
/// ```
pub fn static(
  component: ReactComponent(Nil),
  next: fn(fn() -> Element) -> ReactComponent(a),
) -> ReactComponent(a) {
  use component <- redraw.compose(component)
  next(fn() { component(Nil) })
}

/// Allow to compose and use other components within a component. `compose` is
/// the only way to use components with other components. `compose` should be
/// called during the bootstrap phase of `redraw`, and let you access the
/// underlying component.
///
/// ```gleam
/// fn component() {
///   use other_component <- compose.compose(other_component())
///   h.div([], [
///     other_component(),
///     h.div([], []),
///   ])
/// }
/// ```
///
/// > Re-export of the classic `redraw.compose` for commodity and being able to
/// > use `redraw/compose` for all compositions.
pub const compose = redraw.compose

/// Some components expects children, some components expects children as
/// `render` props, and some components only expects props. To manage children
/// or render props, with classic `redraw.compose`, it is expected to pass it
/// as a prop field, or as a tuple member.
///
/// ```gleam
/// fn my_component() {
///   use other <- redraw.compose(other_children())
///   use _ <- redraw.component_("MyComponent")
///   // Here we need to pass children in the props.
///   other(#(props, [
///     html.div([], []),
///     html.div([], []),
///   ]))
/// }
/// ```
///
/// It is such a common pattern, that `compose.children` helps to write such
/// components. When using `compose.children`, the `ReactComponent` props should
/// have kind `#(props, children)`, but the resulting function will have kind
/// `fn (props, children) -> Element` (instead of
/// `fn (#(props, children)) -> Element` that would be provided by
/// `redraw.compose`). This improves ergonomics, for example by passing a list
/// as last element, or even to use with `use` in the case of a render prop.
///
/// ```gleam
/// // With children.
/// fn my_component() {
///   use other <- compose.children(other_children())
///   use _ <- redraw.component_("MyComponent")
///   // Here we can use `other` as any function expecting two arguments.
///   other(props, [
///     html.div([], []),
///     html.div([], []),
///   ])
/// }
/// ```
///
/// ```gleam
/// // With render.
/// fn my_component() {
///   use other <- compose.children(other_render())
///   use _ <- redraw.component_("MyComponent")
///   // Here we can use `other` as any function expecting a callback
///   // as last argument, `render` prop being a function.
///   use content <- other(props)
///   [
///     html.div([], []),
///     html.div([], []),
///   ]
/// }
/// ```
pub fn children(
  component: ReactComponent(#(props, value)),
  next: fn(fn(props, value) -> Element) -> ReactComponent(a),
) -> ReactComponent(a) {
  use component <- redraw.compose(component)
  next(fn(props, render) { component(#(props, render)) })
}
