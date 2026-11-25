import redraw as react
import redraw/dom/html

pub type Config {
  Config(label: String, on_click: fn() -> Nil)
}

/// A callback varying per instance: two closures share an identity.
pub fn item(on_toggle: fn(Bool) -> Nil) {
  use Nil <- react.component_("Item")
  html.button([], [html.text("toggle")])
}

/// The same, hidden in a record field.
pub fn widget(config: Config) {
  use Nil <- react.component_("Widget")
  html.text(config.label)
}

/// A function in a tuple.
pub fn pair(handlers: #(String, fn(Int) -> Int)) {
  use Nil <- react.component_("Pair")
  html.text(handlers.0)
}
