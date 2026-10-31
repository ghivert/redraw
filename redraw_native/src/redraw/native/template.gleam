import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn none() {
  attribute("none_", Nil)
}
