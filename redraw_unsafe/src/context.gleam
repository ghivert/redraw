import gleam/string
import redraw.{type Context}

pub type Error {
  /// Error returned from `create_context_`.
  /// Context with the corresponding `name` already exists.
  ExistingContext(name: String)
  /// Error returned from `get_context`.
  /// Context with the corresponding `name` does not exists.
  UnknownContext(name: String)
}

/// To simplify and mimic that usage, Redraw wraps Context creation with some
/// caching, to emulate a similar behaviour.
///
/// ```gleam
/// import redraw
///
/// const context_name = "MyContextName"
///
/// pub fn my_provider(children) {
///   let assert Ok(context) = redraw.create_context(context_name, default_value)
///   redraw.provider(context, value, children)
/// }
///
/// pub fn use_my_context() {
///   let assert Ok(context) = redraw.get_context(context_name)
///   redraw.use_context(context)
/// }
/// ```
///
/// Be careful, `create_context` fails if the Context is already defined.
/// Choose a full qualified name, hard to overlap with inattention. If
/// you want to get a Context in an idempotent way, take a look at [`context()`](#context).
///
/// Get a context. Because of FFI, `get_context` breaks the type-checker. It
/// should be considered as unsafe code. As a library author, never exposes
/// your context and expect users will call `get_context` themselves, but rather
/// exposes a `use_my_context()` function, handling the type-checking for the
/// user.
///
/// ```gleam
/// import redraw
///
/// pub type MyContext {
///   MyContext(value: Int)
/// }
///
/// /// `use_context` returns `Context(a)`, should it can be safely returned as
/// /// `Context(MyContext)`.
/// pub fn use_my_context() -> redraw.Context(MyContext) {
///   let context = case redraw.get_context("MyContextName") {
///     // Context has been found in the context cache, use it as desired.
///     Ok(context) -> context
///     // Context has not been found. It means the user did not initialised it.
///     Error(_) -> panic as "Unitialised context."
///   }
///   redraw.use_context(context)
/// }
/// ```
///
@external(javascript, "./context.ffi.mjs", "getContext")
pub fn get_context(name: String) -> Result(Context(a), redraw.Error)

/// `context` emulates classic Context usage in React. Instead of calling
/// `create_context` and `get_context`, it's possible to simply call `context`,
/// which will get or create the context directly, and allows to write code as
/// if Context is globally available. `context` also tries to preserve
/// type-checking at most. `context.default_value` is lazily evaluated, meaning
/// no additional computations will ever be run.
///
/// ```gleam
/// import redraw
///
/// const context_name = "MyContextName"
///
/// pub type MyContext {
///   MyContext(count: Int, set_count: fn (Int) -> Nil)
/// }
///
/// fn default_value() {
///   let count = 0
///   les set_count = fn (_) { Nil }
///   MyContext(count:)
/// }
///
/// pub fn provider() {
///   use _, children <- redraw.component()
///   let context = redraw.context(context_name, default_value)
///   let #(count, set_count) = redraw.use_state(0)
///   redraw.provider(context, MyContext(count:, set_count:), children)
/// }
///
/// pub fn use_my_context() {
///   let context = redraw.context(context_name, default_value)
///   redraw.use_context(context)
/// }
/// ```
///
/// `context` should never fail, but it can be wrong if you use an already used
/// name.
@deprecated("Named contexts are not part of Redraw anymore. Use `redraw_unsafe` if you want to use an unsafe API.")
pub fn context(name: String, default_value: fn() -> a) -> Context(a) {
  case get_context(name) {
    Ok(context) -> context
    Error(get) -> {
      case create_context(name, default_value()) {
        Ok(context) -> context
        Error(create) -> {
          let head = "[Redraw Internal Error] Unable to find or create context."
          let get = "  get_context: " <> string.inspect(get)
          let create = "  create_context: " <> string.inspect(create)
          let body =
            string.join(_, with: " ")([
              "context should never panic.",
              "Please, open an issue on https://github.com/ghivert/redraw,",
              "and join the error details.\n",
            ])
          let details = "Error details:"
          let msg = string.join([head, body, details, get, create], "\n")
          panic as msg
        }
      }
    }
  }
}

/// Create a [context](https://react.dev/learn/passing-data-deeply-with-context)
/// that components can provide or read.
/// Each context is referenced by its name, a little bit like actors in OTP
/// (if you're familiar with Erlang). Because Gleam cannot execute code outside of
/// `main` function, creating a context should do some side-effect at startup.
///
/// In traditional React code, Context usage is usually written like this.
///
/// ```javascript
/// import * as react from 'react'
///
/// // Create your Context in a side-effectful way.
/// const MyContext = react.createContext(defaultValue)
///
/// // Create your own provider, wrapping your context.
/// export function MyProvider(props) {
///   return <MyContext.Provider>{props.children}</MyContext.Provider>
/// }
///
/// // Create your own hook, to simplify usage of your context.
/// export function useMyContext() {
///   return react.useContext(MyContext)
/// }
/// ```
///
/// To simplify and mimic that usage, Redraw wraps Context creation with some
/// caching, to emulate a similar behaviour.
///
/// ```gleam
/// import redraw
///
/// const context_name = "MyContextName"
///
/// pub fn my_provider(children) {
///   let assert Ok(context) = redraw.create_context(context_name, default_value)
///   redraw.provider(context, value, children)
/// }
///
/// pub fn use_my_context() {
///   let assert Ok(context) = redraw.get_context(context_name)
///   redraw.use_context(context)
/// }
/// ```
///
/// Be careful, `create_context` fails if the Context is already defined.
/// Choose a full qualified name, hard to overlap with inattention. If
/// you want to get a Context in an idempotent way, take a look at [`context()`](#context).
///
/// [Documentation](https://react.dev/reference/react/createContext)
@external(javascript, "./context.ffi.mjs", "createContext")
pub fn create_context(
  name: String,
  default_value: a,
) -> Result(Context(a), Error)
