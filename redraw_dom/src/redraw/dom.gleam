import redraw.{type Component}

/// Let you render some children into a different part of the DOM.
/// Contrarily to JavaScript, `create_portal` returns a `Result` to avoid runtime
/// error. Indeed, when the provided root does not exist in your HTML, `create_portal`
/// fails. You should never assume `create_portal` will work out-of-the-box when
/// you're building a library. Otherwise, you could assert the resulting
/// value in your application.
///
/// ```gleam
/// import redraw
/// import redraw/dom/client
/// import redraw/dom/html
///
/// pub fn main() {
///   let assert Ok(root) = client.create_root("app")
///   client.render(app)
/// }
///
/// fn app() {
///   let modal = modal()
///   use <- redraw.component__("App")
///   let assert Ok(modal) = client.create_portal(modal, "modal")
///   html.div([], [html.text("Hello World!"), modal])
/// }
///
/// fn modal() {
///   use <- redraw.component__("Modal")
///   html.div([], [html.text("Inside the modal!")])
/// }
/// ```
///
/// [Documentation](https://react.dev/reference/react-dom/createPortal)
@external(javascript, "../dom.ffi.mjs", "createPortal")
pub fn create_portal(
  children: Component,
  root: String,
) -> Result(Component, Nil)

/// Call `flushSync` to force React to flush any pending work and update the DOM
/// synchronously. \
///
/// ```gleam
/// import redraw
/// import redraw/dom
/// import redraw/dom/events
///
/// type Action {
///   Increment
///   Decrement
/// }
///
/// fn counter() {
///   use <- redraw.component__()
///   let #(state, set_state) = redraw.set_state(0)
///   let on_click = fn(type_: Action) {
///     events.on_click(fn (event) {
///       // Calling flush_sync forces the DOM to refresh.
///       dom.flush_sync(fn () {
///         set_state(case type_ {
///           Increment -> state + 1
///           Decrement -> state - 1
///         })
///       })
///     })
///   }
///   html.div([], [
///     html.div([], [html.text("-")]),
///     html.div([], [html.text(int.to_string(state))]),
///     html.div([], [html.text("+")]),
///   ])
/// }
/// ```
///
/// Most of the time, flushSync can be avoided. Use flushSync as last resort.
///
/// [Documentation](https://react.dev/reference/react-dom/flushSync)
@external(javascript, "react-dom/client", "flushSync")
pub fn flush_sync(callback: fn() -> Nil) -> Nil
