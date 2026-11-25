import redraw as react
import redraw/dom/html

/// The same name as in `twins`, in another module: a distinct identity.
pub fn button() {
  use Nil <- react.component_("Button")
  html.text("other")
}
