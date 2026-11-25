import redraw as react
import redraw/dom/html

pub fn primary() {
  use Nil <- react.component_("Button")
  html.text("primary")
}

pub fn secondary() {
  use Nil <- react.component_("Button")
  html.text("secondary")
}

pub fn unique() {
  use Nil <- react.component_("Unique")
  html.text("unique")
}
