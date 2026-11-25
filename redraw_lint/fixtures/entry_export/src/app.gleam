import redraw as react
import redraw/dom/client
import redraw/dom/html

pub const title = "App"

pub fn main() {
  let assert Ok(node) = client.create_root("root")
  use root <- client.render_(node, root())
  root(Nil)
}

pub fn root() {
  use Nil <- react.component_("Root")
  html.text(greeting())
}

pub fn greeting() -> String {
  "hello"
}

fn private_helper() -> String {
  "private"
}

pub fn memo(component: react.ReactComponent(p)) {
  let _ = private_helper()
  react.memoize_(component)
}
