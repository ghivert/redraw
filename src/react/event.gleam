import gleam/dynamic
import react/internals/attribute.{Attribute}

pub fn on_click(handler: fn() -> Nil) {
  Attribute("onClick", dynamic.from(handler))
}
