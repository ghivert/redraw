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

pub fn refreshing(value: Bool) {
  attribute("refreshing", value)
}

pub fn colors(value: List(String)) {
  let value = attributes.to_array(value)
  attribute("colors", value)
}

pub fn enabled(value: Bool) {
  attribute("enabled", value)
}

pub fn on_refresh(value: fn() -> Nil) {
  attribute("onRefresh", value)
}

pub fn progress_background_color(value: String) {
  attribute("progressBackgroundColor", value)
}

pub fn progress_view_offset(value: Int) {
  attribute("progressViewOffset", value)
}

pub fn size(value: String) {
  attribute("size", value)
}

pub fn tint_color(value: String) {
  attribute("tintColor", value)
}

pub fn title(value: String) {
  attribute("title", value)
}

pub fn title_color(value: String) {
  attribute("titleColor", value)
}

pub fn none() {
  attribute("none_", Nil)
}
