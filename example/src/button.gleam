import gleam/int
import redraw as react
import redraw/dom/attribute as a
import redraw/dom/events
import redraw/dom/html

pub type Variant {
  Primary
  Secondary
}

pub type ButtonProps {
  ButtonProps(label: String)
}

/// A parameterized factory: the variant is fixed when the component is
/// created, and every instance keeps its own click count.
pub fn button(variant: Variant) {
  use props: ButtonProps <- react.component_("Button")
  let #(clicks, set_clicks) = react.use_state_(0)
  html.button(
    [
      a.class("button " <> name(variant)),
      events.on_click(fn(_) { set_clicks(fn(clicks) { clicks + 1 }) }),
    ],
    [
      html.text(
        props.label <> " " <> name(variant) <> ": " <> int.to_string(clicks),
      ),
    ],
  )
}

fn name(variant: Variant) -> String {
  case variant {
    Primary -> "primary"
    Secondary -> "secondary"
  }
}
