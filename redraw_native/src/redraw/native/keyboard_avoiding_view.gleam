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

pub fn behavior(value: String) {
  attribute("behavior", value)
}

pub fn content_container_style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(value) -> attribute("contentContainerStyle", value)
  }
}

pub fn content_container_styles(styles: List(Style)) {
  let value = stylesheet.compile(styles)
  attribute("contentContainerStyle", value)
}

pub fn enabled(value: Bool) {
  attribute("enabled", value)
}

pub fn keyboard_vertical_offset(value: Int) {
  attribute("keyboardVerticalOffset", value)
}

pub fn none() {
  attribute("none_", Nil)
}
