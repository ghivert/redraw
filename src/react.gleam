import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}
import react/internals/coerce.{coerce}

// Component creation

/// Default Node in React. Use `component`-family functions to create components.
pub type Component

/// Create a React component, with a `name`, and a `render` function. `render`
/// will accept props, and a list of children.
pub fn component(
  name name: String,
  render render: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component {
  render
  |> set_function_name(name)
  |> add_children_proxy
}

/// Create a React component, with a `name`, and a `render` function. This
/// component does not accept children.
pub fn component_(name name: String, render render: fn(props) -> Component) {
  render
  |> set_function_name(name)
  |> add_proxy
}

/// Create a React component, with a `name` and a `render` function. This
/// component does not accept children nor props.
pub fn component__(name name: String, render render: fn() -> Component) {
  render
  |> set_function_name(name)
  |> add_empty_proxy
}

pub fn forward_ref(
  name name: String,
  render render: fn(props, Ref(ref), List(Component)) -> Component,
) {
  render
  |> set_function_name(name)
  |> add_children_forward_ref
}

pub fn forward_ref_(
  name name: String,
  render render: fn(props, Ref(ref)) -> Component,
) {
  render
  |> set_function_name(name)
  |> add_forward_ref
}

@external(javascript, "react", "memo")
pub fn memo(
  component: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component

@external(javascript, "react", "memo")
pub fn memo_(component: fn(props) -> Component) -> fn(props) -> Component

// Components

@external(javascript, "./react.ffi.mjs", "strictMode")
pub fn strict_mode(children: List(Component)) -> Component

@external(javascript, "./react.ffi.mjs", "fragment")
pub fn fragment(children: List(Component)) -> Component

@external(javascript, "./react.ffi.mjs", "strictMode")
pub fn profiler(children: List(Component)) -> Component

pub type Suspense {
  Suspense(fallback: Component)
}

@external(javascript, "./react.ffi.mjs", "fragment")
pub fn suspense(props: Suspense, children: List(Component)) -> Component

// Hooks

/// Provide a function, and memoize it.
/// dependencies should be a tuple.
@external(javascript, "react", "useCallback")
pub fn use_callback(fun: function, dependencies: dependencies) -> a

@external(javascript, "react", "useDebugValue")
pub fn use_debug_value(value: a) -> Nil

@external(javascript, "react", "useDebugValue")
pub fn use_debug_value_(value: a, formatter: fn(a) -> String) -> Nil

@external(javascript, "react", "useDeferredValue")
pub fn use_deferred_value(value: a) -> a

@external(javascript, "react", "useEffect")
pub fn use_effect(value: fn() -> Nil, dependencies: a) -> Nil

@external(javascript, "react", "useLayoutEffect")
pub fn use_layout_effect(value: fn() -> Nil, dependencies: a) -> Nil

@external(javascript, "react", "useId")
pub fn use_id() -> String

@external(javascript, "react", "useMemo")
pub fn use_memo(calculate_value: fn() -> a, dependencies: b) -> a

@external(javascript, "react", "useReducer")
pub fn use_reducer(
  reducer: fn(state, action) -> state,
  initial_state: state,
) -> #(state, fn(action) -> Nil)

@external(javascript, "react", "useReducer")
pub fn use_reducer_(
  reducer: fn(state, action) -> state,
  initializer: initializer,
  init: fn(initializer) -> state,
) -> #(state, fn(action) -> Nil)

@external(javascript, "react", "useState")
pub fn use_state(initial_value: a) -> #(a, fn(a) -> Nil)

@external(javascript, "react", "useState")
pub fn use_state_(initial_value: a) -> #(a, fn(fn(a) -> a) -> Nil)

@external(javascript, "react", "useState")
pub fn use_lazy_state(initial_value: fn() -> a) -> #(a, fn(a) -> Nil)

@external(javascript, "react", "useState")
pub fn use_lazy_state_(initial_value: fn() -> a) -> #(a, fn(fn(a) -> a) -> Nil)

@external(javascript, "react", "useTransition")
pub fn use_transition() -> #(Bool, fn() -> Nil)

// Refs

/// A Ref is a mutable data stored in React, persisted across renders.
/// They allow to keep track of a DOM node, a component data, or to store a
/// mutable variable in the component, outside of every component lifecycle.
pub type Ref(a)

/// Set the current value of a ref, overriding its existing content.
@external(javascript, "./react.ffi.mjs", "setCurrent")
pub fn set_current(of ref: Ref(a), with value: a) -> Nil

/// Get the current value of a ref.
@external(javascript, "./react.ffi.mjs", "getCurrent")
pub fn get_current(from ref: Ref(a)) -> a

/// Most used ref you'll want to create. They're automatically created to `None`,
/// and can be passed to `attribute.ref` or `use_imperative_handle`.
/// You probably don't want the ref value to be anything than `Option(a)`, unless
/// you have really strong reasons.
pub fn use_ref() {
  use_ref_(option.None)
}

/// Use `use_ref` if you're trying to acquire a reference to a child or to a
/// component. Use `use_ref_` when you want to keep track of a data, like if
/// you're doing some side-effects, in conjuction with `get_current` and
/// `set_current`.
@external(javascript, "react", "useRef")
pub fn use_ref_(initial_value: a) -> Ref(a)

/// Use `use_imperative_handle` when you want to customize the data stored in
/// a ref. It's mostly used in conjuction with `forward_ref`.
pub fn use_imperative_handle(ref, handler, dependencies) {
  use_imperative_handle_(ref, fn() { option.Some(handler()) }, dependencies)
}

/// Use `use_imperative_handle` by default, unless you really know what you're
/// doing.
@external(javascript, "react", "useImperativeHandle")
pub fn use_imperative_handle_(
  ref: Ref(a),
  handler: fn() -> a,
  dependencies: b,
) -> Nil

// Contexts

pub type Context(a)

@external(javascript, "react", "useContext")
pub fn use_context(context: Context(a)) -> a

@external(javascript, "react", "createContext")
pub fn create_context(default_value default_value: Option(a)) -> Context(a)

@external(javascript, "./react.ffi.mjs", "contextProvider")
pub fn provider(
  context context: Context(a),
  value value: a,
  children children: List(Component),
) -> Component

// API

@external(javascript, "react", "act")
pub fn act(act_fn: fn() -> Promise(Nil)) -> Promise(Nil)

@external(javascript, "react", "startTransition")
pub fn start_transition(scope scope: fn() -> Nil) -> Nil

// Helpers

pub fn keyed(
  element: fn(List(Component)) -> Component,
  content: List(#(String, Component)),
) {
  content
  |> coerce
  |> element
}

// FFI

@external(javascript, "./react.ffi.mjs", "jsx")
@internal
pub fn jsx(value: a, props: props, children: b) -> Component

@external(javascript, "./react.ffi.mjs", "setFunctionName")
fn set_function_name(a: a, name: String) -> a

@external(javascript, "./react.ffi.mjs", "addProxy")
fn add_proxy(a: fn(props) -> Component) -> fn(props) -> Component

@external(javascript, "./react.ffi.mjs", "addEmptyProxy")
fn add_empty_proxy(a: fn() -> Component) -> fn() -> Component

@external(javascript, "./react.ffi.mjs", "addChildrenForwardRef")
fn add_children_forward_ref(
  a: fn(props, Ref(ref), List(Component)) -> Component,
) -> fn(props, Ref(ref), List(Component)) -> Component

@external(javascript, "./react.ffi.mjs", "addForwardRef")
fn add_forward_ref(
  a: fn(props, Ref(ref)) -> Component,
) -> fn(props, Ref(ref)) -> Component

@external(javascript, "./react.ffi.mjs", "addChildrenProxy")
fn add_children_proxy(
  a: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component
