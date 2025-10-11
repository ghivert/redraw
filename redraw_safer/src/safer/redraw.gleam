import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option, None}
import redraw
import redraw/ref

/// React has two notions built-in: elements and components. It is sometimes
/// referred as `JSX` in other React bindings. \
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
/// > `redraw/dom/html`, while creating copmonents can be done with
/// > [`component`](#component).
pub type Element =
  redraw.Element

pub opaque type Component(a) {
  Component(render: fn(a) -> Element)
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
///   redraw.component("MyComponent", fn (props: MyComponentProps) {
///     // Define some hooks.
///     use #(state, set_state) <- redraw.use_state(0)
///     // Return an `Element`. Keep in mind an empty element can
///     // be defined with `memoized` with `Nil` as props.
///     html.div([], [
///       html.text("In my component"),
///       my_other_component(MyOtherComponentProps),
///     ])
///   })
///   |> redraw.memoize
/// }
/// ```
pub fn memoize(component: Component(a)) -> Component(a) {
  let Component(render:) = component
  let render = redraw.memoize(render)
  Component(render:)
}

/// Strict Mode should be enabled during development. \
/// [Documentation](https://react.dev/reference/react/StrictMode)
pub const strict_mode: fn(List(Element)) -> Element = redraw.strict_mode

/// Fragment allow to group children, without creating a node in the DOM. \
/// [Documentation](https://react.dev/reference/react/Fragment)
pub const fragment: fn(List(Element)) -> Element = redraw.fragment

/// Profile allows to measure code performance for a component tree. \
/// [Documentation](https://react.dev/reference/react/Profiler)
pub const profiler: fn(List(Element)) -> Element = redraw.profiler

/// Create a Redraw component, with a `name`, and a `render` function. A
/// `render` function is simply a function accepting props, and returning
/// an `Element`.
///
/// ```gleam
/// pub fn my_component() {
///   // Create your other Redraw components with composition.
///   use my_other_component <- redraw.compose(my_other_component())
///   // Define your component.
///   use props: MyComponentProps <- redraw.component("MyComponent")
///   // Define some hooks. Hooks can only be used in Components body.
///   use #(state, set_state) <- redraw.use_state(0)
///   // Return an `Element`. Keep in mind an empty element can be defined
///   // with `component` with `Nil` as props.
///   html.div([], [
///     html.text("In my component"),
///     my_other_component(MyOtherComponentProps),
///   ])
/// }
/// ```
pub fn component(
  name: String,
  component: fn(props) -> Element,
) -> Component(props) {
  redraw.component_(name, component)
  |> Component
}

pub fn compose(
  component: Component(a),
  next: fn(fn(a) -> Element) -> Component(b),
) -> Component(b) {
  next(component.render)
}

/// Suspense allow to display a fallback content while waiting for children to
/// finish loading. \
/// [Documentation](https://react.dev/reference/react/Suspense)
pub fn suspense(fallback: Element, children: List(Element)) -> Element {
  let props = redraw.Suspense(fallback:)
  redraw.suspense(props, children)
}

/// Let you cache a function definition between re-renders.
/// `dependencies` should be a tuple. \
/// [Documentation](https://react.dev/reference/react/useCallback)
pub fn use_callback(
  fun: function,
  dependencies: dependencies,
  return: fn() -> Element,
) -> Element {
  redraw.use_callback(fun, dependencies)
  return()
}

/// Let you add a label to a custom Hook in React DevTools. \
/// [Documentation](https://react.dev/reference/react/useDebugValue)
pub fn use_debug_value(value: a, return: fn() -> Element) -> Element {
  redraw.use_debug_value(value)
  return()
}

/// Let you add a label to a custom Hook in React DevTools, but allow to format
/// it before. \
/// [Documentation](https://react.dev/reference/react/useDebugValue)
pub fn use_debug_value_(
  value: a,
  formatter: fn(a) -> String,
  return: fn() -> Element,
) -> Element {
  redraw.use_debug_value_(value, formatter)
  return()
}

/// Let you defer updating a part of the UI. \
/// [Documentation](https://react.dev/reference/react/useDeferredValue)
pub fn use_deferred_value(value: a, return: fn(a) -> Element) -> Element {
  redraw.use_deferred_value(value)
  |> return
}

/// Let you synchronize a component with an external system. \
/// [Documentation](https://react.dev/reference/react/useEffect)
pub fn use_effect(
  dependencies: a,
  value: fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_effect(value, dependencies)
  return()
}

/// Let you synchronize a component with an external system. Allow to return
/// a cleanup function. \
/// [Documentation](https://react.dev/reference/react/useEffect)
pub fn use_effect_(
  dependencies: a,
  value: fn() -> fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_effect_(value, dependencies)
  return()
}

/// Generate unique IDs that can be passed to accessibility attributes. \
/// [Documentation](https://react.dev/reference/react/useId)
pub fn use_id(return: fn(String) -> Element) -> Element {
  redraw.use_id()
  |> return
}

/// Allow inserting elements into the DOM before any layout Effects fire.
///
/// > `use_insertion_effect` is for CSS-in-JS library authors. Unless you are
/// > working on a CSS-in-JS library and need a place to inject the styles, you
/// > probably want `use_effect` or `use_layout_effect` instead.
///
/// [Documentation](https://react.dev/reference/react/useInsertionEffect)
pub fn use_insertion_effect(
  deps: deps,
  handler: fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_insertion_effect(handler, deps)
  return()
}

/// Allow inserting elements into the DOM before any layout Effects fire and
/// allow to return a cleanup function.
///
/// > `use_insertion_effect` is for CSS-in-JS library authors. Unless you are
/// > working on a CSS-in-JS library and need a place to inject the styles, you
/// > probably want `use_effect` or `use_layout_effect` instead.
///
/// [Documentation](https://react.dev/reference/react/useInsertionEffect)
pub fn use_insertion_effect_(
  deps: deps,
  handler: fn() -> fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_insertion_effect_(handler, deps)
  return()
}

/// Version of useEffect that fires before the browser repaints the screen. \
/// [Documentation](https://react.dev/reference/react/useLayoutEffect)
pub fn use_layout_effect(
  dependencies: a,
  value: fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_layout_effect(value, dependencies)
  return()
}

/// Version of useEffect that fires before the browser repaints the screen and
/// allow to return a cleanup function. \
/// [Documentation](https://react.dev/reference/react/useLayoutEffect)
pub fn use_layout_effect_(
  dependencies: a,
  value: fn() -> fn() -> Nil,
  return: fn() -> Element,
) -> Element {
  redraw.use_layout_effect_(value, dependencies)
  return()
}

/// Let you cache the result of a calculation between re-renders. \
/// [Documentation](https://react.dev/reference/react/useMemo)
pub fn use_memo(
  dependencies: b,
  calculate_value: fn() -> a,
  return: fn(a) -> Element,
) -> Element {
  redraw.use_memo(calculate_value, dependencies)
  |> return
}

/// Let you add a [reducer](https://react.dev/learn/extracting-state-logic-into-a-reducer) to your component. \
/// [Documentation](https://react.dev/reference/react/useReducer)
pub fn use_reducer(
  reducer: fn(state, action) -> state,
  initial_state: state,
  return: fn(#(state, fn(action) -> Nil)) -> Element,
) -> Element {
  redraw.use_reducer(reducer, initial_state)
  |> return
}

/// Let you add a [reducer](https://react.dev/learn/extracting-state-logic-into-a-reducer) to your component.
/// Allow to initialize the store in a custom way. \
/// [Documentation](https://react.dev/reference/react/useReducer)
pub fn use_reducer_(
  reducer: fn(state, action) -> state,
  initializer: initializer,
  init: fn(initializer) -> state,
  return: fn(#(state, fn(action) -> Nil)) -> Element,
) -> Element {
  redraw.use_reducer_(reducer, initializer, init)
  |> return
}

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component. \
/// [Documentation](https://react.dev/reference/react/useState)
pub fn use_state(
  initial_value: a,
  return: fn(#(a, fn(a) -> Nil)) -> Element,
) -> Element {
  redraw.use_state(initial_value)
  |> return
}

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Give an `updater` function instead of a state setter. \
/// [Documentation](https://react.dev/reference/react/useState)
pub fn use_state_(
  initial_value: a,
  return: fn(#(a, fn(fn(a) -> a) -> Nil)) -> Element,
) -> Element {
  redraw.use_state_(initial_value)
  |> return
}

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Allow to create the initial value in a lazy way. \
/// [Documentation](https://react.dev/reference/react/useState)
pub fn use_lazy_state(
  initial_value: fn() -> a,
  return: fn(#(a, fn(a) -> Nil)) -> Element,
) -> Element {
  redraw.use_lazy_state(initial_value)
  |> return
}

/// Let you add a [state variable](https://react.dev/learn/state-a-components-memory) to your component.
/// Allow to create the initial value in a lazy way.
/// Give an `updater` function instead of a state setter. \
/// [Documentation](https://react.dev/reference/react/useState)
pub fn use_lazy_state_(
  initial_value: fn() -> a,
  return: fn(#(a, fn(fn(a) -> a) -> Nil)) -> Element,
) -> Element {
  redraw.use_lazy_state_(initial_value)
  |> return
}

/// Let you update the state without blocking the UI. \
/// [Documentation](https://react.dev/reference/react/useTransition)
pub fn use_transition(return: fn(#(Bool, fn() -> Nil)) -> Element) -> Element {
  redraw.use_transition()
  |> return
}

/// Async variant of [`use_transition`](#use_transition). \
/// [Documentation](https://react.dev/reference/react/useTransition)
pub fn use_async_transition(
  return: fn(#(Bool, fn() -> Promise(Nil))) -> Element,
) -> Element {
  redraw.use_async_transition()
  |> return
}

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
pub fn use_optimistic(
  state: state,
  return: fn(#(state, fn(state) -> Nil)) -> Element,
) -> Element {
  redraw.use_optimistic(state)
  |> return
}

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
pub fn use_optimistic_(
  state: state,
  return: fn(#(state, fn(fn(state) -> state) -> Nil)) -> Element,
) -> Element {
  redraw.use_optimistic_(state)
  |> return
}

/// Let you optimistically update the UI. \
/// [Documentation](https://react.dev/reference/react/useOptimistic)
pub fn use_optimistic_action(
  state: state,
  update: fn(state, action) -> state,
  return: fn(#(state, fn(action) -> Nil)) -> Element,
) -> Element {
  redraw.use_optimistic_action(state, update)
  |> return
}

/// Allow you to update state based on the result of a form action. \
/// [Documentation](https://react.dev/reference/react/useActionState)
pub fn use_action_state(
  action: fn(state, payload) -> Nil,
  initial_state: state,
  return: fn(#(state, fn(payload) -> nil, Bool)) -> Element,
) -> Element {
  redraw.use_action_state(action, initial_state)
  |> return
}

/// Let you subscribe to an external store. \
/// [Documentation](https://react.dev/reference/react/useSyncExternalStore)
pub fn use_sync_external_store(
  subscribe: fn(fn() -> Nil) -> fn() -> Nil,
  get_snapshot: fn() -> snapshot,
  return: fn(snapshot) -> Element,
) -> Element {
  redraw.use_sync_external_store(subscribe, get_snapshot)
  |> return
}

/// Wait for a Promise and returns its content. Uses `use` under-the-hood.
/// When the Promise is loading, it fallbacks to the nearest
/// `Suspense` boundary. \
/// [Documentation](https://react.dev/reference/react/use)
pub fn use_promise(
  promise: Promise(state),
  return: fn(state) -> Element,
) -> Element {
  redraw.use_promise(promise)
  |> return
}

/// Let you reference a value that’s not needed for rendering.
/// Most used ref you'll want to create. They're automatically created to `None`,
/// and can be passed to `ref` prop or `use_imperative_handle`.
/// You probably don't want the ref value to be anything than `Option(a)`, unless
/// you have really strong reasons. \
/// [Documentation](https://react.dev/reference/react/useRef)
pub fn use_ref(return: fn(ref.Ref(Option(a))) -> Element) -> Element {
  use_ref_(None, return)
}

/// Let you reference a value that’s not needed for rendering.
/// Use `use_ref` if you're trying to acquire a reference to a child or to a
/// component. Use `use_ref_` when you want to keep track of a data, like if
/// you're doing some side-effects, in conjuction with `get_current` and
/// `set_current`. \
/// [Documentation](https://react.dev/reference/react/useRef)
pub fn use_ref_(initial_value: a, return: fn(ref.Ref(a)) -> Element) -> Element {
  redraw.use_ref_(initial_value)
  |> return
}

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// Use `use_imperative_handle` when you want to customize the data stored in
/// a ref. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
pub fn use_imperative_handle(
  ref: ref.Ref(Option(a)),
  dependencies: b,
  handler: fn() -> a,
  return: fn(Nil) -> Element,
) -> Element {
  let handler = fn() { option.Some(handler()) }
  use_imperative_handle_(ref, dependencies, handler, return)
}

/// Let you customize the handle exposed as a [ref](https://react.dev/learn/manipulating-the-dom-with-refs).
/// You should probably use `use_imperative_handle` by default with
/// optional refs. \
/// [Documentation](https://react.dev/reference/react/useImperativeHandle)
pub fn use_imperative_handle_(
  ref: ref.Ref(a),
  dependencies: b,
  handler: fn() -> a,
  return: fn(Nil) -> Element,
) -> Element {
  redraw.use_imperative_handle_(ref, handler, dependencies)
  |> return
}

// Contexts
/// Pass data without props drilling. \
/// [Documentation](https://react.dev/learn/passing-data-deeply-with-context)
pub type Context(a) =
  redraw.Context(a)

/// Let you read and subscribe to [context](https://react.dev/learn/passing-data-deeply-with-context)
/// from your component.
///
/// Under-the-hood, `use_context` uses the new `use` function. This means you
/// can call `use_context` conditionnally! \
///
/// [Documentation](https://react.dev/reference/react/useContext)
pub fn use_context(context: Context(a), return: fn(a) -> Element) -> Element {
  redraw.use_context(context)
  |> return
}

/// Wrap your components into a context provider to specify the value of this
/// context for all components inside. \
/// [Documentation](https://react.dev/reference/react/createContext#provider)
pub const provider: fn(Context(a), a, List(Element)) -> Element = redraw.provider

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
/// fn app(ctx: Context(a)) {
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
pub const create_context_: fn(a) -> Context(a) = redraw.create_context_

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
pub const keyed: fn(fn(List(Element)) -> Element, List(#(String, Element))) ->
  Element = redraw.keyed

@internal
pub fn open(component: Component(a)) -> fn(a) -> Element {
  component.render
}
