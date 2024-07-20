import gleam/int
import gleam/io
import gleam/list
import react
import react/attribute as a
import react/event as e
import react/html
import react_dom/client

pub type Root

pub type Node(props)

pub type Children

pub fn main() {
  let root = root()
  client.create_root("root")
  |> client.render(react.strict_mode([root()]))
}

pub fn root() {
  let app = app()
  use <- react.component__("Root")
  app()
}

pub type CounterProps {

  // #(List(Int), fn(fn(Int) -> Int) -> Nil)
  CounterProps(count: Int, set_count: fn(fn(Int) -> Int) -> Nil)
}

fn counter() {
  use props: CounterProps <- react.component_("Counter")
  react.use_effect(
    fn() {
      // io.debug("props")
      io.debug("in use_effect " <> int.to_string(props.count))
      // io.debug(props)
      Nil
    },
    #(props.count),
  )
  html.button(
    [e.on_click(fn(_) { props.set_count(fn(count) { count + 1 }) })],
    list.map([props.count], fn(count) {
      html.text("count is " <> int.to_string(count))
    }),
  )
}

fn nav_links() {
  html.div([], [
    html.a([a.href("https://vitejs.dev"), a.target("_blank")], [
      html.img([a.src("/vite.svg"), a.class("logo"), a.alt("Vite logo")]),
    ]),
    html.a([a.href("https://gleam.run"), a.target("_blank")], [
      html.img([a.src("/lucy.svg"), a.class("logo lucy"), a.alt("Gleam logo")]),
    ]),
    html.a([a.href("https://react.dev"), a.target("_blank")], [
      html.img([a.src("/react.svg"), a.class("logo react"), a.alt("React logo")]),
    ]),
  ])
}

pub fn app() {
  let counter = counter()
  use <- react.component__("App")
  let #(count, set_count) = react.use_state_(0)
  react.fragment([
    nav_links(),
    html.h1([], [html.text("Vite + Gleam + React")]),
    html.div([a.class("card")], [
      counter(CounterProps(int.min(count, 30), set_count)),
      counter(CounterProps(0, set_count)),
      html.p([], [
        html.text("Edit "),
        html.code([], [html.text("src/main.gleam")]),
        html.text(" and save to test HMR"),
      ]),
    ]),
    html.p([a.class("read-the-docs")], [
      html.text("Click on the Vite and React logos to learn more"),
    ]),
  ])
}
