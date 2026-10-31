import gleam/dynamic.{type Dynamic}
import gleam/option.{type Option, None, Some}
import redraw/internals/unsafe
import redraw/native/internal/attributes
import redraw/native/style.{type Style}
import redraw/native/stylesheet.{type StyleSheet}

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn android_disable_sound(value: Bool) {
  attribute("android_disableSound", value)
}

pub type RippleConfig {
  RippleConfig(
    color: Option(String),
    borderless: Option(Bool),
    radius: Option(Int),
    foreground: Option(Bool),
  )
}

pub fn ripple_config() {
  RippleConfig(color: None, borderless: None, radius: None, foreground: None)
}

pub fn color(config: RippleConfig, color) {
  let color = Some(color)
  RippleConfig(..config, color:)
}

pub fn borderless(config: RippleConfig, borderless) {
  let borderless = Some(borderless)
  RippleConfig(..config, borderless:)
}

pub fn radius(config: RippleConfig, radius) {
  let radius = Some(radius)
  RippleConfig(..config, radius:)
}

pub fn foreground(config: RippleConfig, foreground) {
  let foreground = Some(foreground)
  RippleConfig(..config, foreground:)
}

pub fn android_ripple(value: RippleConfig) {
  let value = attributes.ripple_config(value)
  attribute("android_ripple", value)
}

pub fn unstable_press_delay(value: Int) {
  attribute("unstable_pressDelay", value)
}

pub fn delay_long_press(value: Int) {
  attribute("delayLongPress", value)
}

pub fn disabled(value: Bool) {
  attribute("disabled", value)
}

pub fn hit_slop(value: Int) {
  attribute("hitSlop", value)
}

pub fn hit_slop_(
  bottom bottom: Int,
  left left: Int,
  top top: Int,
  right right: Int,
) {
  let value = attributes.to_rect(bottom:, left:, top:, right:)
  attribute("hitSlop", value)
}

pub fn on_hover_in(value: fn(Dynamic) -> Nil) {
  attribute("onHoverIn", value)
}

pub fn on_hover_out(value: fn(Dynamic) -> Nil) {
  attribute("onHoverOut", value)
}

pub fn on_long_press(value: fn(Dynamic) -> Nil) {
  attribute("onLongPress", value)
}

pub fn on_press(value: fn(Dynamic) -> Nil) {
  attribute("onPress", value)
}

pub fn on_press_in(value: fn(Dynamic) -> Nil) {
  attribute("onPressIn", value)
}

pub fn on_press_move(value: fn(Dynamic) -> Nil) {
  attribute("onPressMove", value)
}

pub fn on_press_out(value: fn(Dynamic) -> Nil) {
  attribute("onPressOut", value)
}

pub fn press_retention_offset(value: Int) {
  attribute("pressRetentionOffset", value)
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

pub fn test_only_pressed(value: Bool) {
  attribute("testOnly_pressed", value)
}

pub fn none() {
  attribute("none_", Nil)
}
