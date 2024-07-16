import gleam/dynamic
import gleam/int
import gleam/io

pub type Root

pub type Node(props)

pub type Children

pub type Component

@external(javascript, "./main.ffi.mjs", "createRoot")
fn create_root(root: String) -> Root

@external(javascript, "./main.ffi.mjs", "render")
fn render(root: Root, children: Component) -> Nil

@external(javascript, "./main.ffi.mjs", "jsx")
fn jsx(value: a, props: b, children: c) -> Component

pub fn main() {
  let root = root()
  create_root("root")
  |> render(root([]))
  // |> render(children())
}

@external(javascript, "./main.ffi.mjs", "strictMode")
pub fn strict_mode(children: List(Component)) -> Component

pub type Props {
  Props
}

pub fn app() {
  div([], [a([], [img([])]), text("Meh?")])
}

pub fn div(attrs, children: List(Component)) -> Component {
  jsx("div", Nil, children)
}

pub fn keyed(
  f: fn(List(Component)) -> Component,
  content: List(#(String, Component)),
) {
  f(dynamic.unsafe_coerce(dynamic.from(content)))
}

pub fn a(attrs, children: List(Component)) -> Component {
  jsx("a", Nil, children)
}

pub fn img(attrs) -> Component {
  jsx("img", Nil, [])
}

pub fn text(content) -> Component {
  jsx("text_", Nil, content)
}

@external(javascript, "./main.ffi.mjs", "setFunctionName")
fn set_function_name(a: a, name: String) -> a

pub fn component(
  name: String,
  val: fn(props) -> Component,
) -> fn(props) -> Component {
  set_function_name(val, name)
  fn(props) { jsx(val, props, []) }
}

@external(javascript, "react", "useState")
fn use_state(default: a) -> #(a, fn(a) -> Nil)

@external(javascript, "react", "useState")
fn use_state_(default: a) -> #(a, fn(fn(a) -> a) -> Nil)

@external(javascript, "./main.ffi.mjs", "useTimeout")
fn use_timeout(default: fn() -> Nil) -> Nil

@external(javascript, "./main.ffi.mjs", "useHelloEffect")
fn use_hello_effect(deps: List(a)) -> Nil

pub fn root() {
  let inside = mk_inside()
  use props <- component("Root")
  let #(state, set_state) = use_state_(0)
  use_timeout(fn() {
    use state <- set_state()
    state + 1
  })
  use_hello_effect([])
  strict_mode([app(), inside(InsideProps(state))])
}

pub type InsideProps {
  InsideProps(count: Int)
}

pub fn mk_inside() {
  let inside = mk_inside_help()
  use props: InsideProps <- component("Insider")
  keyed(div([], _), [
    #("inside", inside(props)),
    #("text", div([], [text("inside " <> int.to_string(props.count))])),
  ])
}

pub fn mk_inside_help() {
  use props: InsideProps <- component("InsiderHelp")
  div([], [text("inside " <> int.to_string(props.count))])
}
