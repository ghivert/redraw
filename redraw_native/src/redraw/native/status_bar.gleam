import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub type Style {
  Auto
  Inverted
  Light
  Dark
}

/// Sets the color of the status bar text. Default value is `"auto"` which
/// picks the appropriate value according to the active color scheme, eg:
/// if your app is dark mode, the style will be `"light"`.
/// @default 'auto'
pub fn style(style: Style) {
  let style = case style {
    Auto -> "auto"
    Dark -> "dark"
    Inverted -> "inverted"
    Light -> "light"
  }
  attribute("style", style)
}

/// If the transition between status bar property changes should be
/// animated. Supported for `backgroundColor`, `barStyle` and `hidden`.
pub fn animated(value: Bool) {
  attribute("animated", value)
}

/// If the status bar is hidden.
pub fn hidden(value: Bool) {
  attribute("hidden", value)
}

pub type Animation {
  None
  Fade
  Slide
}

/// The transition effect when showing and hiding the status bar using
/// the hidden prop.
/// @default 'fade'
/// @platform ios
pub fn hide_transition_animation(value: Animation) {
  let value = case value {
    Fade -> "fade"
    None -> "none"
    Slide -> "slide"
  }
  attribute("hideTransitionAnimation", value)
}

/// If the network activity indicator should be visible.
/// @platform ios
pub fn network_activity_indicator_visible(value: Bool) {
  attribute("networkActivityIndicatorVisible", value)
}

/// The background color of the status bar.
/// @platform android
pub fn background_color(value: String) {
  attribute("backgroundColor", value)
}

/// If the status bar is translucent. When translucent is set to `true`,
/// the app will draw under the status bar. This is the default behaviour in
/// projects created with Expo tools because it is consistent with iOS.
/// @platform android
pub fn translucent(value: Bool) {
  attribute("translucent", value)
}
