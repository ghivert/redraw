import gleam/int
import gleam/io
import gleam/option
import react
import react/attribute as a
import react/client
import react/event as e
import react/html

pub type Root

pub type Node(props)

pub type Children

pub fn main() {
  let root = root()
  client.create_root("root")
  |> client.render(root([]))
}

pub fn root() {
  let app = app()
  use _props <- react.component_("Root")
  react.strict_mode([app()])
}

@external(javascript, "./react.ffi.mjs", "nativeLog")
fn native_log(value: a) -> a

fn counter() {
  use _, ref <- react.forward_ref_("Counter")
  let #(counting, set_counting) = react.use_state_(0)
  html.button(
    [
      a.ref(ref),
      e.on_click(fn(_) {
        case react.get_current(ref) {
          option.None -> Nil
          option.Some(_) -> {
            native_log(ref)
            Nil
          }
        }
        set_counting(fn(count) { count + 1 })
      }),
    ],
    [html.text("count is " <> int.to_string(counting))],
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
  let ref = react.use_ref()
  react.fragment([
    nav_links(),
    html.h1([], [html.text("Vite + Gleam + React")]),
    html.div([a.class("card")], [
      counter(Nil, ref),
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
