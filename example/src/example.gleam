import gleam/int
import gleam/list
import redraw/dom/attribute as a
import redraw/dom/client
import redraw/dom/events
import redraw/dom/html
import safer/redraw

pub fn main() {
  let assert Ok(node) = client.create_root("root")
  use root <- redraw.render(node, root())
  redraw.strict_mode([root(Nil)])
}

pub fn root() {
  use app <- redraw.compose(app())
  use _ <- redraw.component("Root")
  app(Nil)
}

pub type CounterProps {
  CounterProps(count: Int, set_count: fn(fn(Int) -> Int) -> Nil)
}

fn counter() {
  use props: CounterProps <- redraw.component("Counter")
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

fn app() {
  use counter <- redraw.compose(counter() |> redraw.memoize)
  use _ <- redraw.component("App")
  use #(count, set_count) <- use_counter()
  redraw.fragment([
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

fn use_counter(return) {
  use #(count, set_count) <- redraw.use_state_(0)
  return(#(count, set_count))
}
