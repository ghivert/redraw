import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}
import gleam/string
import redraw/error.{type Error}
import redraw/internals/coerce.{coerce}

// Component creation

/// Default Node in Redraw. Use `component`-family functions to create components.
/// Forwarded ref can be constructed using `forward_ref`-family functions, while
/// external components can be used with `to_component`-family functions.
pub type Component

/// Create a Redraw component, with a `name`, and a `render` function. `render`
/// will accept props, and a list of children.
pub fn component(
  name name: String,
  render render: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component {
  render
  |> set_function_name(name)
  |> add_children_proxy
}

/// Create a Redraw component, with a `name`, and a `render` function. This
/// component does not accept children.
pub fn component_(
  name name: String,
  render render: fn(props) -> Component,
) -> fn(props) -> Component {
  render
  |> set_function_name(name)
  |> add_proxy
}

/// Create a Redraw component, with a `name` and a `render` function. This
/// component does not accept children nor props.
pub fn component__(
  name name: String,
  render render: fn() -> Component,
) -> fn() -> Component {
  render
  |> set_function_name(name)
  |> add_empty_proxy
}

@external(javascript, "./external.ffi.mjs", "convertProps")
fn convert_props(gleam_props: gleam_props) -> props

/// Convert a React component to a React-redraw component with children. Give it a
/// name, and send directly the FFI. Don't worry about the snake_case over
/// camelCase, redraw take care of it for you.
///
/// ```gleam
/// import redraw
///
/// pub type MyComponentProps {
///   MyComponentProps(
///     first_prop: Bool,
///     second_prop: String,
///   )
/// }
///
/// @external(javascript, "my_library", "MyComponent")
/// fn do_my_component(props: MyComponentProps) -> redraw.Component
///
/// pub fn my_component() -> fn(MyComponentProps, List(Component)) -> redraw.Component {
///   redraw.to_component("MyComponent", do_my_component)
/// }
/// ```
pub fn to_component(
  name name: String,
  component render: fn(props) -> Component,
) -> fn(props, List(Component)) -> Component {
  fn(props, children) { jsx(render, convert_props(props), children) }
  |> set_function_name(name)
}

/// Convert a React Component to a redraw Component without children. Give it a
/// name, and send directly the FFI. Don't worry about the snake_case over
/// camelCase, redraw take care of it for you.
///
/// ```gleam
/// import redraw
///
/// pub type MyComponentProps {
///   MyComponentProps(
///     first_prop: Bool,
///     second_prop: String,
///   )
/// }
///
/// @external(javascript, "my_library", "MyComponent")
/// fn do_my_component(props: MyComponentProps) -> redraw.Component
///
/// pub fn my_component() -> fn(MyComponentProps) -> redraw.Component {
///   redraw.to_component_("MyComponent", do_my_component)
/// }
/// ```
pub fn to_component_(
  name name: String,
  component render: fn(props) -> Component,
) -> fn(props) -> Component {
  fn(props) { jsx(render, convert_props(props), Nil) }
  |> set_function_name(name)
}

/// Create a Redraw component with children with forwarded ref. \
/// [Documentation](https://fr.react.dev/reference/react/forwardRef)
pub fn forward_ref(
  name name: String,
  render render: fn(props, Ref(ref), List(Component)) -> Component,
) -> fn(props, Ref(ref), List(Component)) -> Component {
  render
  |> set_function_name(name)
  |> add_children_forward_ref
}

/// Create a Redraw component without children with forwarded ref. \
/// [Documentation](https://react.dev/reference/react/forwardRef)
pub fn forward_ref_(
  name name: String,
  render render: fn(props, Ref(ref)) -> Component,
) -> fn(props, Ref(ref)) -> Component {
  render
  |> set_function_name(name)
  |> add_forward_ref
}

/// Memoizes a Redraw component with children. \
/// [Documentation](https://react.dev/reference/react/memo)
@external(javascript, "react", "memo")
pub fn memo(
  component: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component

/// Memoizes a Redraw component without children. \
/// [Documentation](https://react.dev/reference/react/memo)
@external(javascript, "react", "memo")
pub fn memo_(component: fn(props) -> Component) -> fn(props) -> Component

// Components

/// Strict Mode should be enabled during development. \
/// [Documentation](https://react.dev/reference/react/StrictMode)
@external(javascript, "./redraw.ffi.mjs", "strictMode")
pub fn strict_mode(children: List(Component)) -> Component

/// Fragment allow to group children, without creating a node in the DOM. \
/// [Documentation](https://react.dev/reference/react/Fragment)
@external(javascript, "./redraw.ffi.mjs", "fragment")
pub fn fragment(children: List(Component)) -> Component

/// Profile allows to measure code performance for a component tree. \
/// [Documentation](https://react.dev/reference/react/Profiler)
@external(javascript, "./redraw.ffi.mjs", "strictMode")
pub fn profiler(children: List(Component)) -> Component

pub type Suspense {
  Suspense(fallback: Component)
}

/// Suspense allow to display a fallback content while waiting for children to
/// finish loading. \
/// [Documentation](https://fr.react.dev/reference/react/Suspense)
@external(javascript, "./redraw.ffi.mjs", "suspense")
pub fn suspense(props: Suspense, children: List(Component)) -> Component

// Hooks

/// Let you cache a function definition between re-renders.
/// `dependencies` should be a tuple. \
/// [Documentation](https://react.dev/reference/react/useCallback)
@external(javascript, "react", "useCallback")
pub fn use_callback(fun: function, dependencies: dependencies) -> function

/// Let you add a label to a custom Hook in React DevTools. \
/// [Documentation](https://react.dev/reference/react/useDebugValue)
@external(javascript, "react", "useDebugValue")
pub fn use_debug_value(value: a) -> Nil

/// Let you add a label to a custom Hook in React DevTools, but allow to format
/// it before. \
/// [Documentation](https://react.dev/reference/react/useDebugValue)
@external(javascript, "react", "useDebugValue")
pub fn use_debug_value_(value: a, formatter: fn(a) -> String) -> Nil

/// Let you defer updating a part of the UI. \
/// [Documentation](https://react.dev/reference/react/useDeferredValue)
@external(javascript, "react", "useDeferredValue")
pub fn use_deferred_value(value: a) -> a

/// Let you synchronize a component with an external system. \
/// [Documentation](https://react.dev/reference/react/useEffect)
@external(javascript, "react", "useEffect")
pub fn use_effect(value: fn() -> Nil, dependencies: a) -> Nil

/// Let you synchronize a component with an external system. Allow to return
/// a cleanup function. \
/// [Documentation](https://react.dev/reference/react/useEffect)
@external(javascript, "react", "useEffect")
pub fn use_effect_(value: fn() -> fn() -> Nil, dependencies: a) -> Nil

/// Version of useEffect that fires before the browser repaints the screen. \
/// [Documentation](https://react.dev/reference/react/useLayoutEffect)
@external(javascript, "react", "useLayoutEffect")
pub fn use_layout_effect(value: fn() -> Nil, dependencies: a) -> Nil

/// Generate unique IDs that can be passed to accessibility attributes. \
/// [Documentation](https://react.dev/reference/react/useId)
@external(javascript, "react", "useId")
pub fn use_id() -> String

/// Let you cache the result of a calculation between re-renders. \
/// [Documentation](https://react.dev/reference/react/useMemo)
@external(javascript, "react", "useMemo")
pub fn use_memo(calculate_value: fn() -> a, dependencies: b) -> a

/// Let you add a [reducer](https://react.dev/learn/extracting-state-logic-into-a-reducer) to your component. \
/// [Documentation](https://react.dev/reference/react/useReducer)
@external(javascript, "react", "useReducer")
pub fn use_reducer(
  reducer: fn(state, action) -> state,
  initial_state: state,
) -> #(state, fn(action) -> Nil)

/// Let you add a [reducer](https://react.dev/learn/extracting-state-logic-into-a-reducer) to your component.
/// Allow to initialize the store in a custom way. \
/// [Documentation](https://react.dev/reference/react/useReducer)
@external(javascript, "react", "useReducer")
pub fn use_reducer_(
  reducer: fn(state, action) -> state,
  initializer: initializer,
  init: fn(initializer) -> state,
) -> #(state, fn(action) -> Nil)

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component. \
/// [Documentation](https://react.dev/reference/react/useState)
@external(javascript, "react", "useState")
pub fn use_state(initial_value: a) -> #(a, fn(a) -> Nil)

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Give an `updater` function instead of a state setter. \
/// [Documentation](https://react.dev/reference/react/useState)
@external(javascript, "react", "useState")
pub fn use_state_(initial_value: a) -> #(a, fn(fn(a) -> a) -> Nil)

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Allow to create the initial value in a lazy way. \
/// [Documentation](https://react.dev/reference/react/useState)
@external(javascript, "react", "useState")
pub fn use_lazy_state(initial_value: fn() -> a) -> #(a, fn(a) -> Nil)

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Allow to create the initial value in a lazy way.
/// Give an `updater` function instead of a state setter. \
/// [Documentation](https://react.dev/reference/react/useState)
@external(javascript, "react", "useState")
pub fn use_lazy_state_(initial_value: fn() -> a) -> #(a, fn(fn(a) -> a) -> Nil)

/// Let you update the state without blocking the UI. \
/// [Documentation](https://react.dev/reference/react/useTransition)
@external(javascript, "react", "useTransition")
pub fn use_transition() -> #(Bool, fn() -> Nil)

// Refs

/// A Ref is a mutable data stored in React, persisted across renders.
/// They allow to keep track of a DOM node, a component data, or to store a
/// mutable variable in the component, outside of every component lifecycle. \
/// [Documentation](https://react.dev/learn/referencing-values-with-refs)
pub type Ref(a)

/// Set the current value of a ref, overriding its existing content.
@external(javascript, "./redraw.ffi.mjs", "setCurrent")
pub fn set_current(of ref: Ref(a), with value: a) -> Nil

/// Get the current value of a ref.
@external(javascript, "./redraw.ffi.mjs", "getCurrent")
pub fn get_current(from ref: Ref(a)) -> a

/// Let you reference a value that’s not needed for rendering.
/// Most used ref you'll want to create. They're automatically created to `None`,
/// and can be passed to `ref` prop or `use_imperative_handle`.
/// You probably don't want the ref value to be anything than `Option(a)`, unless
/// you have really strong reasons. \
/// [Documentation](https://react.dev/reference/react/useRef)
pub fn use_ref() -> Ref(Option(a)) {
  use_ref_(option.None)
}

/// Let you reference a value that’s not needed for rendering.
/// Use `use_ref` if you're trying to acquire a reference to a child or to a
/// component. Use `use_ref_` when you want to keep track of a data, like if
/// you're doing some side-effects, in conjuction with `get_current` and
/// `set_current`. \
/// [Documentation](https://react.dev/reference/react/useRef)
@external(javascript, "react", "useRef")
pub fn use_ref_(initial_value: a) -> Ref(a)

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// Use `use_imperative_handle` when you want to customize the data stored in
/// a ref. It's mostly used in conjuction with `forward_ref`. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
pub fn use_imperative_handle(
  ref: Ref(Option(a)),
  handler: fn() -> a,
  dependencies: b,
) -> Nil {
  use_imperative_handle_(ref, fn() { option.Some(handler()) }, dependencies)
}

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// Use `use_imperative_handle` by default, unless you really know what you're
/// doing. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
@external(javascript, "react", "useImperativeHandle")
pub fn use_imperative_handle_(
  ref: Ref(a),
  handler: fn() -> a,
  dependencies: b,
) -> Nil

// Contexts

/// Pass data without props drilling. \
/// [Documentation](https://react.dev/learn/passing-data-deeply-with-context)
pub type Context(a)

/// Let you read and subscribe to [context](https://react.dev/learn/passing-data-deeply-with-context) from your component. \
/// [Documentation](https://react.dev/reference/react/useContext)
@external(javascript, "react", "useContext")
pub fn use_context(context: Context(a)) -> a

/// Let you create a [context](https://react.dev/learn/passing-data-deeply-with-context) that components can provide or read. \
/// [Documentation](https://react.dev/reference/react/createContext)
@deprecated("Use redraw/create_context_ instead. redraw/create_context will be removed in 2.0.0. Unusable right now, due to how React handles Context.")
@external(javascript, "react", "createContext")
pub fn create_context(default_value default_value: Option(a)) -> Context(a)

/// Wrap your components into a context provider to specify the value of this context for all components inside. \
/// [Documentation](https://react.dev/reference/react/createContext#provider)
@external(javascript, "./context.ffi.mjs", "contextProvider")
pub fn provider(
  context context: Context(a),
  value value: a,
  children children: List(Component),
) -> Component

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
///   let assert Ok(context) = redraw.create_context_(context_name, default_value)
///   redraw.provider(context, value, children)
/// }
///
/// pub fn use_my_context() {
///   let assert Ok(context) = redraw.get_context(context_name)
///   redraw.use_context(context)
/// }
/// ```
///
/// Be careful, `create_context_` fails if the Context is already defined.
/// Choose a full qualified name, hard to overlap with inattention. If
/// you want to get a Context in an idempotent way, take a look at [`context()`](#context).
///
/// [Documentation](https://react.dev/reference/react/createContext)
@external(javascript, "./context.ffi.mjs", "createContext")
pub fn create_context_(
  name: String,
  default_value: a,
) -> Result(Context(a), Error)

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
@external(javascript, "./context.ffi.mjs", "getContext")
pub fn get_context(name: String) -> Result(Context(a), Error)

/// `context` emulates classic Context usage in React. Instead of calling
/// `create_context_` and `get_context`, it's possible to simply call `context`,
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
pub fn context(name: String, default_value: fn() -> a) -> Context(a) {
  case get_context(name) {
    Ok(context) -> context
    Error(get) ->
      case create_context_(name, default_value()) {
        Ok(context) -> context
        Error(create) -> {
          let get = "  get_context: " <> string.inspect(get)
          let create = "  create_context_: " <> string.inspect(create)
          let head = "[Redraw Internal Error] Unable to find or create context."
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

// API

/// Test helper to apply pending React updates before making assertions. \
/// [Documentation](https://react.dev/reference/react/act)
@external(javascript, "react", "act")
pub fn act(act_fn: fn() -> Promise(Nil)) -> Promise(Nil)

/// Let you update the state without blocking the UI. \
/// [Documentation](https://react.dev/reference/react/startTransition)
@external(javascript, "react", "startTransition")
pub fn start_transition(scope scope: fn() -> Nil) -> Nil

// Helpers

/// Redraw does not support passing key element to components in an easy way like
/// React does. To simplify this, it uses the same API than [Lustre](lustre.build)
/// to put keys on children.
/// ```gleam
/// fn my_component(props, children) {
///   redraw.keyed(my_other_component(props, _), {
///     use item <- list.map(children)
///     #("my-key", item)
///   })
/// }
/// ```
pub fn keyed(
  element: fn(List(Component)) -> Component,
  content: List(#(String, Component)),
) {
  content
  |> coerce
  |> element
}

// FFI
// Those functions are used internally by Redraw, to setup things correctly.
// They should not be accessible from the outside world.

@external(javascript, "./redraw.ffi.mjs", "jsx")
@internal
pub fn jsx(value: a, props: props, children: b) -> Component

@external(javascript, "./redraw.ffi.mjs", "setFunctionName")
fn set_function_name(a: a, name: String) -> a

@external(javascript, "./redraw.ffi.mjs", "addProxy")
fn add_proxy(a: fn(props) -> Component) -> fn(props) -> Component

@external(javascript, "./redraw.ffi.mjs", "addEmptyProxy")
fn add_empty_proxy(a: fn() -> Component) -> fn() -> Component

@external(javascript, "./redraw.ffi.mjs", "addChildrenForwardRef")
fn add_children_forward_ref(
  a: fn(props, Ref(ref), List(Component)) -> Component,
) -> fn(props, Ref(ref), List(Component)) -> Component

@external(javascript, "./redraw.ffi.mjs", "addForwardRef")
fn add_forward_ref(
  a: fn(props, Ref(ref)) -> Component,
) -> fn(props, Ref(ref)) -> Component

@external(javascript, "./redraw.ffi.mjs", "addChildrenProxy")
fn add_children_proxy(
  a: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component
