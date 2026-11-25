import redraw as react
import redraw/dom/html

pub type Props {
  Props(label: String, on_click: fn() -> Nil)
}

/// A callback in the props is fine: it is not part of the identity.
pub fn button() {
  use props: Props <- react.component_("Button")
  html.button([], [html.text(props.label)])
}

/// A component as argument is identified by its name.
pub fn list_view(item: react.ReactComponent(Int)) {
  use item <- react.compose(item)
  use Nil <- react.component_("ListView")
  html.div([], [item(1), item(2)])
}

/// A helper receiving a component is not replayed: its parameters are not
/// part of any identity.
pub fn memo(component: react.ReactComponent(p), decorate: fn(Int) -> Int) {
  let _ = decorate
  react.memoize_(component)
}
