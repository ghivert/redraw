import gleam/int
import gleam/list
import redraw as react
import redraw/dom/attribute as a
import redraw/dom/client
import redraw/dom/events
import redraw/dom/html

pub type Root

pub type Node(props)

pub type Children

pub fn main() {
  let root = root()
  let assert Ok(node) = client.create_root("root")
  client.render(node, react.strict_mode([root()]))
}

pub fn root() {
  let app = app()
  use <- react.standalone("Root")
  app()
}

pub type CounterProps {
  CounterProps(count: Int, set_count: fn(fn(Int) -> Int) -> Nil)
}

fn counter() {
  use props: CounterProps <- react.element("Counter")
  html.button(
    [events.on_click(fn(_) { props.set_count(fn(count) { count + 1 }) })],
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
  use <- react.standalone("App")
  let #(count, set_count) = react.use_state_(0)
  react.fragment([
    nav_links(),
    html.h1([], [html.text("Vite + Gleam + React")]),
    html.div([a.class("card")], [
      counter(CounterProps(count, set_count)),
      html.p([], [
        html.text("Edit "),
        html.code([], [html.text("src/main.gleam")]),
        html.text(" and save to test HMR"),
      ]),
    ]),
    html.p([a.class("read-the-docs")], [
      html.text("Click on the Vite, Gleam and React logos to learn more"),
    ]),
  ])
}
