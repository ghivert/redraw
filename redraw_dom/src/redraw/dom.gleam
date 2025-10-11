import gleam/fetch/form_data.{type FormData}
import gleam/option.{type Option}
import gleam/uri
import redraw.{type Component}

/// Possible errors encountered by React DOM.
pub type Error {
  InvalidRoot(root: String)
}

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
@external(javascript, "./dom.ffi.mjs", "createPortal")
pub fn create_portal(
  children: Component,
  root: String,
) -> Result(Component, Error)

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
@external(javascript, "react-dom", "flushSync")
pub fn flush_sync(callback: fn() -> Nil) -> Nil

/// Let you eagerly connect to a server that you expect to load resources from. \
/// [Documentation](https://react.dev/reference/react-dom/preconnect)
@external(javascript, "./dom.ffi.mjs", "preconnect")
pub fn preconnect(
  href: String,
  cross_origin cross_origin: Option(CrossOrigin),
) -> Nil

/// Let you eagerly look up the IP of a server that you expect to load
/// resources from. \
/// [Documentation](https://react.dev/reference/react-dom/prefetchDNS)
@external(javascript, "./dom.ffi.mjs", "prefetchDNS")
pub fn prefetch_dns(href: String) -> Nil

/// Let you eagerly fetch and evaluate a stylesheet or external script. \
/// [Documentation](https://react.dev/reference/react-dom/preinit)
@external(javascript, "./dom.ffi.mjs", "preinit")
pub fn preinit(
  uri: uri.Uri,
  as_ as_: As,
  precedence precedence: Option(String),
  cross_origin cross_origin: Option(CrossOrigin),
  integrity integrity: Option(String),
  nonce nonce: Option(String),
  fetch_priority fetch_priority: Option(String),
) -> Nil

/// Let you eagerly fetch and evaluate an ESM module. \
/// [Documentation](https://react.dev/reference/react-dom/preinitModule)
@external(javascript, "./dom.ffi.mjs", "preinitModule")
pub fn preinit_module(
  uri: uri.Uri,
  cross_origin cross_origin: Option(CrossOrigin),
  integrity integrity: Option(String),
  nonce nonce: Option(String),
) -> Nil

/// Let you eagerly fetch a resource such as a stylesheet, font, or
/// external script that you expect to use. \
/// [Documentation](https://react.dev/reference/react-dom/preload)
@external(javascript, "./dom.ffi.mjs", "preload")
pub fn preload(
  uri: uri.Uri,
  as_ as_: Resource,
  cross_origin cross_origin: Option(CrossOrigin),
  referrer_policy referrer_policy: Option(ReferrerPolicy),
  integrity integrity: Option(String),
  type_ type_: Option(String),
  nonce nonce: Option(String),
  fetch_priority fetch_priority: Option(FetchPriority),
  image_src_set image_src_set: Option(String),
  image_sizes image_sizes: Option(String),
) -> Nil

/// Let you eagerly fetch an ESM module that you expect to use. \
/// [Documentation](https://react.dev/reference/react-dom/preloadModule)
@external(javascript, "./dom.ffi.mjs", "preloadModule")
pub fn preload_module(
  uri: uri.Uri,
  cross_origin cross_origin: Option(CrossOrigin),
  integrity integrity: Option(String),
  nonce nonce: Option(String),
) -> Nil

/// Status returned by [`use_form_status`](#use_form_status). \
/// [Documentation](https://react.dev/reference/react-dom/hooks/useFormStatus)
pub type Status {
  Status(
    pending: Bool,
    data: Option(FormData),
    method: String,
    action: Option(fn(FormData) -> Nil),
  )
}

/// Give you status information of the last form submission. \
/// [Documentation](https://react.dev/reference/react-dom/hooks/useFormStatus)
@external(javascript, "./dom.ffi.mjs", "useFormStatus")
pub fn use_form_status() -> Status

/// Used in preloading functions.
pub type As {
  AsScript
  AsStyle
}

/// Used in preloading functions.
pub type CrossOrigin {
  Anonymous
  UseCredentials
}

/// Used in preloading functions.
pub type FetchPriority {
  Auto
  Low
  High
}

/// Used in preloading functions.
pub type ReferrerPolicy {
  NoReferrerWhenDowngrade
  NoReferrer
  Origin
  OriginWhenCrossOrigin
  UnsafeUrl
}

/// Used in preloading functions.
pub type Resource {
  Audio
  Document
  Embed
  Fetch
  Font
  Image
  Object
  Script
  Style
  Track
  Video
  Worker
}
