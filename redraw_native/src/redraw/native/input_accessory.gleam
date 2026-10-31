import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe
import redraw/native/style.{type Style}
import redraw/native/stylesheet.{type StyleSheet}

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn background_color(value: String) {
  attribute("backgroundColor", value)
}

pub fn native_id(value: String) {
  attribute("nativeID", value)
}

pub fn style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(style) -> attribute("style", style)
  }
}

pub fn styles(styles: List(Style)) {
  let value = stylesheet.compile(styles)
  attribute("style", value)
}

pub fn none() {
  attribute("none_", Nil)
}
