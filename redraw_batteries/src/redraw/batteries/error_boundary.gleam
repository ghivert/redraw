//// By default, if your application throws an error during rendering, React
//// will remove its UI from the screen. To prevent this, you can wrap a part
//// of your UI into an Error Boundary. An Error Boundary is a special component
//// that lets you display some fallback UI instead of the part that crashed—for
//// example, an error message.
////
//// ```gleam
//// error_boundary.children(my_render())
//// |> error_boundary.fallback(my_fallback())
//// |> error_boundary.on_error(send_to_error_logger)
//// |> error_boundary.render
//// ```
////
//// [React Reference](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary)

/// ```
import gleam/dynamic.{type Dynamic}
import gleam/option.{type Option}
import redraw.{type Element}
import redraw/internal/unsafe

/// Error objects are thrown when runtime errors occur. The Error object can
/// also be used as a base object for user-defined exceptions. You should almost
/// never encounter them in Gleam, but when interacting with foreign code, some
/// errors could be missed, and throw. In that case, the error boundary will be
/// able to catch them.
///
/// [MDN Reference](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Error)
pub type Error {
  Error(
    /// Represents the name for the type of error. For `Error.prototype.name`,
    /// the initial value is `"Error"`. Subclasses like
    /// [`TypeError`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/TypeError) and
    /// [`SyntaxError`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/SyntaxError)
    /// provide their own name properties.
    name: String,
    /// Error message. For user-created
    /// [`Error`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Error)
    /// objects, this is the string provided as the constructor's first argument.
    message: String,
    /// Error cause indicating the reason why the current error is thrown —
    /// usually another caught error. For user-created
    /// [`Error`](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Error)
    /// objects, this is the value provided as the `cause` property of the
    /// constructor's second argument.
    cause: Option(Dynamic),
    /// A non-standard property for a stack trace.
    stack: Option(String),
  )
}

/// Additional informations coming from React.
pub type ErrorInfo {
  ErrorInfo(
    /// Captures which component contained the exception, and its ancestors.
    component_stack: Option(String),
    /// Captures the current owner stack in development as string if available.
    owner_stack: Option(String),
  )
}

pub type Props {
  Props(
    /// Children wrapped by the error boundary. If the children throws an error,
    /// then `fallback` will be displayed, or nothing if `fallback` has not been
    /// provided.
    children: Element,
    /// Fallback element displayed if `children` throws an error. If not provided,
    /// the error boundary will simply display nothing.
    fallback: Element,
    /// Error catcher, to detect errors and get them to your error logger, or
    /// whatever else you want to do. If your error logger expect native `Error`
    /// and `ErrorInfo`, use `on_raw_error` instead.
    on_error: fn(Error, ErrorInfo) -> Nil,
    /// Error catcher, to detect errors and get them to your error logger.
    /// `on_raw_error` provides native `Error` and `ErrorInfo` in case you need
    /// them for any integration needs.
    on_raw_error: fn(Dynamic, Dynamic) -> Nil,
  )
}

/// Render the error boundary. The error boundary will not be visible, but will
/// instead display its children, or the fallback on error.
///
/// ```gleam
/// error_boundary.children(my_render())
/// |> error_boundary.fallback(my_fallback())
/// |> error_boundary.on_error(send_to_error_logger)
/// |> error_boundary.render
/// ```
@external(javascript, "./boundary.redraw.mjs", "errorBoundary")
pub fn render(props: Props) -> Element

/// Children to display when the error boundary did not catch any errors.
///
/// ```gleam
/// error_boundary.children(my_render())
/// |> error_boundary.render
/// ```
pub fn children(children: Element) -> Props {
  let fallback = unsafe.coerce(Nil)
  let on_error = fn(_, _) { Nil }
  let on_raw_error = fn(_, _) { Nil }
  Props(children:, fallback:, on_error:, on_raw_error:)
}

/// Fallback to display when the error boundary did catch an error. Not setting
/// `fallback` will simply not display anything on error catching.
///
/// ```gleam
/// error_boundary.children(my_render())
/// |> error_boundary.fallback(my_fallback())
/// |> error_boundary.render
/// ```
pub fn fallback(props: Props, fallback: Element) -> Props {
  Props(..props, fallback:)
}

/// Handler running after an error has been caught. Use it to message an error
/// logger, or change behaviour in the application. If you need the raw native
/// `Error` and `ErrorInfo` (for integration needs for example) use `on_raw_error`.
///
/// ```gleam
/// error_boundary.children(my_render())
/// |> error_boundary.on_error(fn (error, info) {
///   send_to_error_logger(
///     error.name,
///     error.message,
///     info.component_stack,
///   )
/// })
/// |> error_boundary.render
/// ```
pub fn on_error(props: Props, on_error: fn(Error, ErrorInfo) -> Nil) -> Props {
  Props(..props, on_error:)
}

/// Handler running after an error has been caught. Use it to message an error
/// logger, or change behaviour in the application. Use it if you need to access
/// the raw native `Error` and `ErrorInfo`.
///
/// ```gleam
/// error_boundary.children(my_render())
/// |> error_boundary.on_raw_error(datadog_send)
/// |> error_boundary.render
/// ```
pub fn on_raw_error(
  props: Props,
  on_raw_error: fn(Dynamic, Dynamic) -> Nil,
) -> Props {
  Props(..props, on_raw_error:)
}
