import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option, None, Some}
import gleam/string
import redraw/internal/unsafe
import redraw/ref

/// Main error type.
pub type Error {
  /// Error returned from `create_context_`.
  /// Context with the corresponding `name` already exists.
  @deprecated("Named contexts are not part of Redraw anymore.")
  ExistingContext(name: String)
  /// Error returned from `get_context`.
  /// Context with the corresponding `name` does not exists.
  @deprecated("Named contexts are not part of Redraw anymore.")
  UnknownContext(name: String)
  /// Error returned from `capture_owner_stack`.
  /// `capture_owner_stack` can only be used in development, and you're not
  /// in development anymore.
  DevelopmentOnly
  /// Error returned from `capture_owner_stack`.
  /// `capture_owner_stack` can sometimes return `null`, when the stack is
  /// unavailable.
  OwnerStackUnavailable
}

// Component creation

/// React has two notions built-in: elements and components. Element is
/// sometimes referred as `JSX` or `JSX.Element` in other React bindings. \
/// An `Element` can be a DOM node or the result of the execution of a
/// component. Any time you need to draw on the screen, whether it's in the
/// DOM or on your smartphone screen with React Native, you need to return an
/// `Element`.
///
/// > Be careful, a "component" in React is _a function which can create
/// > elements_. For example, `fn () -> Element` is a so-called "component".
/// > Contrarily to elements, a component can hold internal state, have a
/// > lifecycle and can run side-effects. On the opposite, elements do not hold
/// > state, and cannot have side-effects.
/// >
/// > Creating an `Element` is as simple as calling functions from
/// > `redraw/dom/html`, while creating components can be done with
/// > [`component_`](#component_).
pub type Element

/// > `In previous versions of `redraw`, `Component` was used to designate
/// > `Element`. In newer versions of `redraw`, `Component` is kept for
/// > backward-compatibility, and `ReactComponent` is used instead.
/// > `ReactComponent` will be removed in favour of `Component` when the
/// > future version of React will be live.
///
/// A `ReactComponent` represents a function, accepting inputs (i.e. `props`) and
/// returning React elements. A `ReactComponent` is the only place that can hold
/// state in a React component-tree. It has a lifecycle and can run side-effects.
///
/// Defining `ReactComponent` is achieved using `redraw.component_`, and they can
/// be used with `redraw.compose`. `redraw.compose` makes sure no components
/// can be used outside of the bootstrap phase of Redraw.
pub opaque type ReactComponent(props) {
  ReactComponent(render: fn(props) -> Element, memoize: Bool)
}

/// Create a Redraw component, with a `name`, and a `render` function. A
/// `render` function is simply a function accepting props, and returning
/// an `Element`.
///
/// ```gleam
/// pub fn my_component() {
///   // Create your other Redraw components before defining the others.
///   use my_other_component <- redraw.compose(my_other_component())
///   // Define your component.
///   use props: MyComponentProps <- redraw.component_("MyComponent")
///   // Define some hooks.
///   let #(state, set_state) = redraw.use_state(0)
///   // Return an `Element`. Keep in mind an empty element can be defined
///   // with `component_` with `Nil` as props.
///   html.div([], [
///     html.text("In my component"),
///     my_other_component(MyOtherComponentProps),
///   ])
/// }
/// ```
pub fn component_(
  name name: String,
  render render: fn(props) -> Element,
) -> ReactComponent(props) {
  render
  |> set_display_name(name)
  |> wrap_react_component
  |> ReactComponent(render: _, memoize: False)
}

/// Allow to compose and use other components within a component. `compose` is
/// the only way to use components with other components. `compose` should be
/// called during the bootstrap phase of `redraw`, and let you access the
/// underlying component.
///
/// ```gleam
/// fn component() {
///   use other_component <- redraw.compose(other_component())
///   h.div([], [
///     other_component(),
///     h.div([], []),
///   ])
/// }
/// ```
pub fn compose(
  component: ReactComponent(props),
  return: fn(fn(props) -> Element) -> ReactComponent(p),
) -> ReactComponent(p) {
  let render = wrap_call(component)
  return(render)
}

/// Accepts a Component, and wrapp it in `React.memo`. `React.memo` ensures
/// that a component will never repaint when props are identical between two
/// renders. Redraw applies an algorithm suited to Gleam, to avoid you the
/// hard task of comparing props, while providing a correct comparison
/// algorithm.
///
/// > While such optimisation could be done for every component,
/// > being able to select if a component should be memoized or not can help
/// > finding and solving bugs.
/// > [Take a look at the React documentation to get a better idea if you
/// > need memoization or not](https://react.dev/reference/react/memo#should-you-add-memo-everywhere).
///
/// ```gleam
/// pub fn my_component() {
///   // Create your other Redraw components before defining the others.
///   use my_other_component <- redraw.compose(my_other_component())
///   // Define your component.
///   redraw.component_("MyComponent", fn (props: MyComponentProps) {
///     // Define some hooks.
///     let #(state, set_state) = redraw.use_state(0)
///     // Return an `Element`. Keep in mind an empty element can
///     // be defined with `memoized` with `Nil` as props.
///     html.div([], [
///       html.text("In my component"),
///       my_other_component(MyOtherComponentProps),
///     ])
///   })
///   |> redraw.memoize_
/// }
/// ```
pub fn memoize_(component: ReactComponent(props)) -> ReactComponent(props) {
  ReactComponent(..component, memoize: True)
}

// Components

/// Strict Mode should be enabled during development. \
/// [Documentation](https://react.dev/reference/react/StrictMode)
@external(javascript, "./redraw.ffi.mjs", "strictMode")
pub fn strict_mode(children: List(Element)) -> Element

/// Fragment allow to group children, without creating a node in the DOM. \
/// [Documentation](https://react.dev/reference/react/Fragment)
@external(javascript, "./redraw.ffi.mjs", "fragment")
pub fn fragment(children: List(Element)) -> Element

/// Profile allows to measure code performance for a component tree. \
/// [Documentation](https://react.dev/reference/react/Profiler)
@external(javascript, "./redraw.ffi.mjs", "strictMode")
pub fn profiler(children: List(Element)) -> Element

pub type Suspense {
  Suspense(fallback: Element)
}

/// Suspense allow to display a fallback content while waiting for children to
/// finish loading. \
/// [Documentation](https://react.dev/reference/react/Suspense)
@external(javascript, "./redraw.ffi.mjs", "suspense")
pub fn suspense(props: Suspense, children: List(Element)) -> Element

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

/// Generate unique IDs that can be passed to accessibility attributes. \
/// [Documentation](https://react.dev/reference/react/useId)
@external(javascript, "react", "useId")
pub fn use_id() -> String

/// Allow inserting elements into the DOM before any layout Effects fire.
///
/// > `use_insertion_effect` is for CSS-in-JS library authors. Unless you are
/// > working on a CSS-in-JS library and need a place to inject the styles, you
/// > probably want `use_effect` or `use_layout_effect` instead.
///
/// [Documentation](https://react.dev/reference/react/useInsertionEffect)
@external(javascript, "react", "useInsertionEffect")
pub fn use_insertion_effect(handler: fn() -> Nil, deps: deps) -> Nil

/// Allow inserting elements into the DOM before any layout Effects fire and
/// allow to return a cleanup function.
///
/// > `use_insertion_effect` is for CSS-in-JS library authors. Unless you are
/// > working on a CSS-in-JS library and need a place to inject the styles, you
/// > probably want `use_effect` or `use_layout_effect` instead.
///
/// [Documentation](https://react.dev/reference/react/useInsertionEffect)
@external(javascript, "react", "useInsertionEffect")
pub fn use_insertion_effect_(handler: fn() -> fn() -> Nil, deps: deps) -> Nil

/// Version of useEffect that fires before the browser repaints the screen. \
/// [Documentation](https://react.dev/reference/react/useLayoutEffect)
@external(javascript, "react", "useLayoutEffect")
pub fn use_layout_effect(value: fn() -> Nil, dependencies: a) -> Nil

/// Version of useEffect that fires before the browser repaints the screen and
/// allow to return a cleanup function. \
/// [Documentation](https://react.dev/reference/react/useLayoutEffect)
@external(javascript, "react", "useLayoutEffect")
pub fn use_layout_effect_(value: fn() -> fn() -> Nil, dependencies: a) -> Nil

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

/// Async variant of [`use_transition`](#use_transition). \
/// [Documentation](https://react.dev/reference/react/useTransition)
@external(javascript, "react", "useTransition")
pub fn use_async_transition() -> #(Bool, fn() -> Promise(Nil))

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
@external(javascript, "react", "useOptimistic")
pub fn use_optimistic(state: state) -> #(state, fn(state) -> Nil)

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
@external(javascript, "react", "useOptimistic")
pub fn use_optimistic_(state: state) -> #(state, fn(fn(state) -> state) -> Nil)

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
@external(javascript, "react", "useOptimistic")
pub fn use_optimistic_action(
  state: state,
  update: fn(state, action) -> state,
) -> #(state, fn(action) -> Nil)

/// Allow you to update state based on the result of a form action. \
/// [Documentation](https://react.dev/reference/react/useActionState)
@external(javascript, "react", "useActionState")
pub fn use_action_state(
  action: fn(state, payload) -> Nil,
  initial_state: state,
) -> #(state, fn(payload) -> nil, Bool)

/// Let you subscribe to an external store. \
/// [Documentation](https://react.dev/reference/react/useSyncExternalStore)
@external(javascript, "react", "useSyncExternalStore")
pub fn use_sync_external_store(
  subscribe: fn(fn() -> Nil) -> fn() -> Nil,
  get_snapshot: fn() -> snapshot,
) -> snapshot

/// Wait for a Promise and returns its content. Uses `use` under-the-hood.
/// When the Promise is loading, it fallbacks to the nearest
/// `Suspense` boundary. \
/// [Documentation](https://react.dev/reference/react/use)
@external(javascript, "react", "use")
pub fn use_promise(promise: Promise(state)) -> state

/// Let you reference a value that’s not needed for rendering.
/// Most used ref you'll want to create. They're automatically created to `None`,
/// and can be passed to `ref` prop or `use_imperative_handle`.
/// `Ref` are most of the time used to reference DOM node, in order to run
/// side-effects. In this case, you probably don't want the ref value to be
/// anything than `Option(a)`, unless you need to persist a value across renders
/// which is not part of the DOM. In that case, use `use_ref_`. \
/// [Documentation](https://react.dev/reference/react/useRef)
pub fn use_ref() -> ref.Ref(Option(a)) {
  use_ref_(None)
}

/// Let you reference a value that’s not needed for rendering.
/// Use `use_ref` if you're trying to acquire a reference to a child or to a
/// component. Use `use_ref_` when you want to keep track of a data, like if
/// you're doing some side-effects, in conjuction with `ref.current` and
/// `ref.assign`. \
/// [Documentation](https://react.dev/reference/react/useRef)
@external(javascript, "react", "useRef")
pub fn use_ref_(initial_value: a) -> ref.Ref(a)

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// Use `use_imperative_handle` when you want to customize the data stored in
/// a ref. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
pub fn use_imperative_handle(
  ref: ref.Ref(Option(a)),
  handler: fn() -> a,
  dependencies: b,
) -> Nil {
  use <- use_imperative_handle_(ref, _, dependencies)
  Some(handler())
}

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// You should probably use `use_imperative_handle` by default with
/// optional refs. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
@external(javascript, "react", "useImperativeHandle")
pub fn use_imperative_handle_(
  ref: ref.Ref(a),
  handler: fn() -> a,
  dependencies: b,
) -> Nil

// Contexts
/// Pass data without props drilling. \
/// [Documentation](https://react.dev/learn/passing-data-deeply-with-context)
pub type Context(a)

/// Let you read and subscribe to [context](https://react.dev/learn/passing-data-deeply-with-context)
/// from your component.
///
/// Under-the-hood, `use_context` uses the new `use` function. This means you
/// can call `use_context` conditionnally! \
///
/// [Documentation](https://react.dev/reference/react/useContext)
@external(javascript, "react", "use")
pub fn use_context(context: Context(a)) -> a

/// Wrap your components into a context provider to specify the value of this
/// context for all components inside. \
/// [Documentation](https://react.dev/reference/react/createContext#provider)
@external(javascript, "./context.ffi.mjs", "contextProvider")
pub fn provider(
  context context: Context(a),
  value value: a,
  children children: List(Element),
) -> Element

/// Create a [context](https://react.dev/learn/passing-data-deeply-with-context)
/// that components can provide or read.
/// Because Gleam cannot execute code outside of `main` function, creating a
/// context should do some side-effect at startup.
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
///   return (
///     <MyContext.Provider>
///       {props.children}
///     </MyContext.Provider>
///   )
/// }
///
/// // Create your own hook, to simplify usage of your context.
/// export function useMyContext() {
///   return react.useContext(MyContext)
/// }
/// ```
///
/// In Redraw, creating your application goes through a bootstrap phase, where
/// every component gets created. Your context should be passed at that moment.
/// Find an example with React DOM.
///
/// ```gleam
/// import redraw
/// import redraw/dom/client
///
/// type MyContext {
///   MyContext(
///     name: String,
///   )
/// }
/// pub fn main() {
///   let assert Ok(root) = client.create_root("#app")
///   let context = redraw.create_context_(MyContext(name: "Louis"))
///   let app = app(context)
///   client.render(root, {
///     redraw.strict_mode([
///       redraw.provider(context, value, [
///         app(AppProps(name: "Lucy")),
///       ])
///     ])
///   })
/// }
///
/// type AppProps {
///   AppProps(
///     name: String,
///   )
/// }
///
/// fn app(ctx: Context(a)) -> redraw.Component(AppProps) {
///   use props: AppProps <- redraw.element("App")
///   let context = redraw.use_context(ctx)
///   html.div([], [
///     html.text("Hello " <> props.name <> "!")
///     html.text("Hello " <> context.name <> "!")
///   ])
/// }
/// ```
///
/// [Documentation](https://react.dev/reference/react/createContext)
@external(javascript, "react", "createContext")
pub fn create_context_(default_value: a) -> Context(a)

// API

/// Test helper to apply pending React updates before making assertions. \
/// [Documentation](https://react.dev/reference/react/act)
@external(javascript, "react", "act")
pub fn act(act_fn: fn() -> Promise(Nil)) -> Promise(Nil)

/// Reads the current Owner Stack in development and returns it as a string
/// if available.
///
/// Owner Stacks are available in
/// - Component render
/// - Effects (e.g. `use_effect`)
/// - React’s event handlers (e.g. `button([a.on_click(fn (_) {...})])`)
/// - React error handlers (React Root options onCaughtError, onRecoverableError, and onUncaughtError)
///
/// If no Owner Stack is available, null is returned (see Troubleshooting: The Owner Stack is null).
///
/// > Owner Stacks are only available in development. captureOwnerStack will
/// > always return null outside of development.
///
/// [Documentation](https://react.dev/reference/react/act)
@external(javascript, "./redraw.ffi.mjs", "captureOwnerStack")
pub fn capture_owner_stack() -> Result(String, Error)

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
  element: fn(List(Element)) -> Element,
  content: List(#(String, Element)),
) -> Element {
  let content = unsafe.coerce(content)
  element(content)
}

// FFI
// Those functions are used internally by Redraw, to setup things correctly.
// They should not be accessible from the outside world.
//

/// `type_` should be either an HTML tag, or a valid React Component.
/// `props` should be an object.
/// `children` can be anything.
/// `convert_children` indicates whether the props should be converted as an array,
/// or not. If `convert_children` is `True`, then the list of children will be
/// turned to arrays. Use it only for apex children.
@external(javascript, "./redraw.ffi.mjs", "jsx")
@internal
pub fn jsx(
  type_ type_: value,
  props props: props,
  children children: components,
  convert_children convert_children: Bool,
) -> Element

@external(javascript, "./redraw.ffi.mjs", "setDisplayName")
fn set_display_name(a: a, name: String) -> a

@external(javascript, "./redraw.ffi.mjs", "wrapComponent")
fn wrap_element(a: fn(props) -> Element) -> fn(props) -> Element

@external(javascript, "./redraw.ffi.mjs", "wrapCall")
fn wrap_call(a: ReactComponent(props)) -> fn(props) -> Element

// DEPRECATIONS, WILL BE REMOVED IN REDRAW 20

/// Create a Redraw component, with a `name`, and a `render` function.
/// `render` will accept props, and a list of children.
@deprecated("Components in Redraw have changed. Use `component_` instead.")
pub fn component(
  name name: String,
  render render: fn(props, children) -> Element,
) -> fn(props, children) -> Element {
  render
  |> set_display_name(name)
  |> wrap_component
}

@deprecated("Components in Redraw have changed. Use `memoize_` instead, in conjunction with `component_`.")
@external(javascript, "./redraw.ffi.mjs", "memoize")
pub fn memoize(render: fn(props) -> Element) -> fn(props) -> Element

@external(javascript, "./redraw.ffi.mjs", "wrapComponent")
fn wrap_component(
  a: fn(props, children) -> Element,
) -> fn(props, children) -> Element

@external(javascript, "./redraw.ffi.mjs", "wrapReactComponent")
fn wrap_react_component(a: fn(props) -> Element) -> fn(props) -> Element

@deprecated("Components in Redraw have changed. Use `component_` instead.")
pub fn element(
  name name: String,
  render render: fn(c) -> Element,
) -> fn(c) -> Element {
  render
  |> set_display_name(name)
  |> wrap_element
}

/// Create a Redraw standalone component, with a `name` and a `render` function.
/// Keep in mind this component does not accept children nor props.
@deprecated("Components in Redraw have changed. Use `component_` instead.")
pub fn standalone(
  name name: String,
  render render: fn() -> Element,
) -> fn() -> Element {
  render
  |> set_display_name(name)
  |> wrap_standalone
}

@external(javascript, "./redraw.ffi.mjs", "wrapStandalone")
fn wrap_standalone(a: fn() -> Element) -> fn() -> Element

@external(javascript, "./external.ffi.mjs", "convertProps")
fn convert_children(gleam_props: gleam_props) -> props

/// Convert a React component to a React-redraw component with children. Give it a
/// name, and send directly the FFI. Don't worry about the snake_case over
/// camelCase, redraw take care of it for you.
///
/// Because `children` can accept anything, it's up to you to define the type of
/// the children. If you send a `List`, it will be automatically converted to a
/// JavaScript array.
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
/// pub fn my_component() -> fn(MyComponentProps, List(Element)) -> redraw.Component {
///   redraw.to_component("MyComponent", do_my_component)
/// }
/// ```
@deprecated("Converting React components to Redraw components are most of the time done by hand and cannot automatised.")
pub fn to_component(
  name name: String,
  component render: fn(props) -> Element,
) -> fn(props, children) -> Element {
  use props, children <- set_display_name(_, name)
  let props = convert_children(props)
  jsx(type_: render, props:, children:, convert_children: True)
}

/// Convert a React Component to a Redraw Element. Give it a
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
///   redraw.to_element("MyComponent", do_my_component)
/// }
/// ```
@deprecated("Converting React components to Redraw components are most of the time done by hand and cannot automatised.")
pub fn to_element(
  name name: String,
  component render: fn(props) -> Element,
) -> fn(props) -> Element {
  use props <- set_display_name(_, name)
  let props = convert_children(props)
  jsx(type_: render, props:, children: Nil, convert_children: False)
}

/// Memoizes a Redraw component with children. \
/// [Documentation](https://react.dev/reference/react/memo)
@deprecated("Memoization should be done with `memoize_`.")
@external(javascript, "react", "memo")
pub fn memo(
  component: fn(props, List(Element)) -> Element,
) -> fn(props, List(Element)) -> Element

/// Memoizes a Redraw component without children. \
/// [Documentation](https://react.dev/reference/react/memo)
@deprecated("Memoization should be done with `memoize_`.")
@external(javascript, "react", "memo")
pub fn memo_(component: fn(props) -> Element) -> fn(props) -> Element

// Refs
@deprecated("Use `ref.Ref(a)` instead.")
pub type Ref(a) =
  ref.Ref(a)

/// Set the current value of a ref, overriding its existing content.
@deprecated("Refs now have their dedicated module. Use `ref.assign` instead.")
pub fn set_current(of ref: ref.Ref(a), with value: a) -> Nil {
  ref.assign(of: ref, with: value)
}

/// Get the current value of a ref.
@deprecated("Refs now have their dedicated module. Use `ref.current` instead.")
pub fn get_current(from ref: ref.Ref(a)) -> a {
  ref.current(from: ref)
}

/// Components are deprecated, as they don't represent a component in React.
/// React defines components as function that generates elements, while Redraw
/// was defining components as the result of component running. \
/// Currently, thinking with `Component` can be harmful, to understand the
/// difference between plain elements and components. \
/// Use [`Element`](#Element) type instead.
///
/// > As a matter of backward compatibility, `Component` is now aliased to
/// > `Element`, and will be removed in further versions.
@deprecated("`Component` type has been removed from Redraw. Use `Element` instead.")
pub type Component =
  Element

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
@deprecated("Named contexts are not part of Redraw anymore.")
@external(javascript, "./context.ffi.mjs", "getContext")
pub fn get_context(name: String) -> Result(Context(a), Error)

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
@deprecated("Named contexts are not part of Redraw anymore.")
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
@deprecated("Named contexts are not part of Redraw anymore. Use `create_context_` instead.")
@external(javascript, "./context.ffi.mjs", "createContext")
pub fn create_context(
  name: String,
  default_value: a,
) -> Result(Context(a), Error)
