import gleam/javascript/promise.{type Promise}
import gleam/option.{type Option}

// Component creation

pub type Component

pub fn component(
  name name: String,
  render render: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component {
  render
  |> set_function_name(name)
  |> add_children_proxy
}

pub fn component_(name name: String, render render: fn(props) -> Component) {
  render
  |> set_function_name(name)
  |> add_proxy
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

pub type Context(a)

@external(javascript, "react", "useContext")
pub fn use_context(context: Context(a)) -> a

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

@external(javascript, "react", "useRef")
pub fn use_ref(initial_value: a) -> Ref(a)

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

pub type Ref(a)

@external(javascript, "./react.ffi.mjs", "setCurrent")
pub fn set_current(of ref: Ref(a), with value: a) -> Nil

@external(javascript, "./react.ffi.mjs", "getCurrent")
pub fn get_current(from ref: Ref(a)) -> a

// Contexts

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

@external(javascript, "./react.ffi.mjs", "addChildrenProxy")
fn add_children_proxy(
  a: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component

@external(javascript, "./react.ffi.mjs", "coerce")
fn coerce(a: a) -> b
