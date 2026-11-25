import redraw as react
import redraw/dom/html

pub fn button(variant) {
  let _ = variant
  use Nil <- react.component_("Button")
  html.text("button")
}

/// A plain factory has nothing to annotate.
pub fn plain() {
  use Nil <- react.component_("Plain")
  html.text("plain")
}
