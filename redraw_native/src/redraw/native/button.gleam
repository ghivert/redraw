import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn on_press(value: fn(Dynamic) -> Nil) {
  attribute("onPress", value)
}

pub fn title(value: String) {
  attribute("title", value)
}

pub fn accessibility_label(value: String) {
  attribute("accessibilityLabel", value)
}

pub fn accessibility_language(value: String) {
  attribute("accessibilityLanguage", value)
}

// pub fn accessibility_actions(value) {
//   attribute("accessibilityActions", value)
// }

// pub fn on_accessibility_action(value) {
//   attribute("onAccessibilityAction", value)
// }

pub fn color(value: String) {
  attribute("color", value)
}

pub fn disabled(value: Bool) {
  attribute("disabled", value)
}

pub fn has_tv_preferred_focus(value: Bool) {
  attribute("hasTVPreferredFocus", value)
}

pub fn next_focus_down(value: Int) {
  attribute("nextFocusDown", value)
}

pub fn next_focus_forward(value: Int) {
  attribute("nextFocusForward", value)
}

pub fn next_focus_left(value: Int) {
  attribute("nextFocusLeft", value)
}

pub fn next_focus_right(value: Int) {
  attribute("nextFocusRight", value)
}

pub fn next_focus_up(value: Int) {
  attribute("nextFocusUp", value)
}

pub fn test_id(value: String) {
  attribute("testID", value)
}

pub fn touch_sound_disabled(value: Bool) {
  attribute("touchSoundDisabled", value)
}
