import gleam/function
import gleam/int
import gleam/io
import react
import react/client
import react/element

pub type Root

pub type Node(props)

pub type Children

pub fn main() {
  let root = root()
  client.create_root("root")
  |> client.render(root([]))
  // |> render(children())
}

fn use_damuf() {
  use <- function.flip(react.use_effect)(#())
  io.debug("mumuf")
  Nil
}

fn use_hello_effect(content: String) {
  use <- function.flip(react.use_effect)(#())
  io.debug("hello " <> content)
  Nil
}

pub fn app() {
  use_damuf()
  element.div([], [element.a([], [element.img([])]), element.text("Meh?")])
}

pub fn root() {
  let inside = mk_inside()
  use _props <- react.component_("Root")
  let #(state, _set_state) = react.use_state_(0)
  // use_timeout(fn() {
  // use state <- set_state()
  // state + 1
  // })
  use_hello_effect("root")
  react.strict_mode([
    app(),
    inside(InsideProps(state), [element.text("in root")]),
  ])
}

pub type InsideProps {
  InsideProps(count: Int)
}

pub fn mk_inside() {
  let inside_help = mk_inside_help()
  use props: InsideProps, children <- react.component("Insider")
  use_damuf()
  react.use_debug_value("muf")
  let #(state, set_state) = react.use_state(1)
  element.div([], [
    react.fragment(children),
    element.text(int.to_string(state)),
    inside_help(props),
    element.div([], [element.text("inside " <> int.to_string(props.count))]),
  ])
}

pub fn mk_inside_help() {
  use props: InsideProps <- react.component_("InsiderHelp")
  react.use_debug_value("mumuf")
  use_damuf()
  element.div([], [element.text("inside " <> int.to_string(props.count))])
}
