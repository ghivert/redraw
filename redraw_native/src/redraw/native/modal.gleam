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

pub fn animation_type(value: String) {
  attribute("animationType", value)
}

pub fn backdrop_color(value: String) {
  attribute("backdropColor", value)
}

pub fn hardware_accelerated(value: Bool) {
  attribute("hardwareAccelerated", value)
}

pub fn navigation_bar_translucent(value: Bool) {
  attribute("navigationBarTranslucent", value)
}

pub fn on_dismiss(value: fn() -> Nil) {
  attribute("onDismiss", value)
}

pub fn on_orientation_change(value: fn() -> Nil) {
  attribute("onOrientationChange", value)
}

pub fn allow_swipe_dismissal(value: Bool) {
  attribute("allowSwipeDismissal", value)
}

pub fn on_request_close(value: fn() -> Nil) {
  attribute("onRequestClose", value)
}

pub fn on_show(value: fn() -> Nil) {
  attribute("onShow", value)
}

pub fn presentation_style(value: String) {
  attribute("presentationStyle", value)
}

pub fn status_bar_translucent(value: Bool) {
  attribute("statusBarTranslucent", value)
}

pub fn supported_orientations(value: List(String)) {
  let value = attributes.to_array(value)
  attribute("supportedOrientations", value)
}

pub fn transparent(value: Bool) {
  attribute("transparent", value)
}

pub fn visible(value: Bool) {
  attribute("visible", value)
}

pub fn none() {
  attribute("none_", Nil)
}
