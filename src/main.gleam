import gleam/dynamic
import gleam/int
import gleam/io
import gleam/list

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

@external(javascript, "./main.ffi.mjs", "fragment")
fn fragment(children: List(Component)) -> Component

pub fn main() {
  let root = root()
  create_root("root")
  |> render(strict_mode([root([])]))
  // |> render(children())
}

@external(javascript, "./main.ffi.mjs", "strictMode")
pub fn strict_mode(children: List(Component)) -> Component

@external(javascript, "./main.ffi.mjs", "addProxy")
fn add_proxy(
  a: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component

pub fn component(
  name: String,
  component: fn(props, List(Component)) -> Component,
) -> fn(props, List(Component)) -> Component {
  let component =
    component
    |> add_proxy
    |> set_function_name(name)
  fn(props, children) { jsx(component, props, children) }
}

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

pub fn component_(
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
fn use_hello_effect(deps: List(a), content: String) -> Nil

pub fn root() {
  let inside = mk_inside()
  use props <- component_("Root")
  let #(state, set_state) = use_state_(0)
  use_hello_effect([], "root")
  use_timeout(fn() { set_state(fn(state) { state + 1 }) })
  fragment([app(), inside(InsideProps(state))])
}

pub type InsideProps {
  InsideProps(count: Int)
}

pub fn mk_inside() {
  let inside = mk_inside_help()
  use props: InsideProps <- component_("Insider")
  use_hello_effect([], "inside")
  keyed(div([], _), [
    #("inside", inside(props, [div([], [text("From Children!")])])),
    #("text", div([], [text("inside " <> int.to_string(props.count))])),
  ])
}

pub fn mk_inside_help() {
  use props: InsideProps, children <- component("InsiderHelp")
  use_hello_effect([], "inside_help")
  div([], [text("inside " <> int.to_string(props.count)), fragment(children)])
}
