import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe
import redraw/native/internal/attributes

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn disabled(value: Bool) {
  attribute("disabled", value)
}

pub fn ios_background_color(value: String) {
  attribute("ios_backgroundColor", value)
}

pub fn on_change(value: fn(Dynamic) -> Nil) {
  attribute("onChange", value)
}

pub fn on_value_change(value: fn(Bool) -> Nil) {
  attribute("onValueChange", value)
}

pub fn thumb_color(value: String) {
  attribute("thumbColor", value)
}

pub fn track_color(false false: String, true true: String) {
  let value = attributes.to_track_color(false, true)
  attribute("trackColor", value)
}

pub fn value(value: Bool) {
  attribute("value", value)
}

pub fn none() {
  attribute("none_", Nil)
}
