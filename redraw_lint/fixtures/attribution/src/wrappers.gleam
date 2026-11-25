import redraw as react
import redraw/dom/html

/// A wrapper calling `component_` for its callers.
pub fn make(name: String, render: fn(Nil) -> react.Element) {
  react.component_(name, render)
}

/// A render piped into `component_`.
pub fn piped() {
  fn(_: Nil) { html.text("piped") }
  |> react.component_("Piped", _)
}

/// `component_` captured, then called.
pub fn captured() {
  let create = react.component_("Captured", _)
  create(fn(_: Nil) { html.text("captured") })
}

/// `component_` inside an anonymous function.
pub fn lazy() {
  fn() {
    use Nil <- react.component_("Lazy")
    html.text("lazy")
  }
}
