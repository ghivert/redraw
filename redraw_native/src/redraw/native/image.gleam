import gleam/dynamic.{type Dynamic}
import redraw
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

pub fn accessible(value: Bool) {
  attribute("accessible", value)
}

pub fn accessibility_label(value: String) {
  attribute("accessibilityLabel", value)
}

pub fn alt(value: String) {
  attribute("alt", value)
}

pub fn blur_radius(value: Int) {
  attribute("blurRadius", value)
}

pub fn cap_insets(value) {
  attribute("capInsets", value)
}

pub type CrossOrigin {
  Anonymous
  UseCredentials
}

pub fn cross_origin(value: CrossOrigin) {
  let value = case value {
    Anonymous -> "anonymous"
    UseCredentials -> "use-credentials"
  }
  attribute("crossOrigin", value)
}

pub fn default_source(value) {
  attribute("defaultSource", value)
}

pub fn fade_duration(value: Int) {
  attribute("fadeDuration", value)
}

pub fn height(value: Int) {
  attribute("height", value)
}

pub fn loading_indicator_source(value) {
  attribute("loadingIndicatorSource", value)
}

pub fn on_error(value: fn(Dynamic) -> Nil) {
  attribute("onError", value)
}

pub fn on_layout(value: fn(Dynamic) -> Nil) {
  attribute("onLayout", value)
}

pub fn on_load(value: fn(Dynamic) -> Nil) {
  attribute("onLoad", value)
}

pub fn on_load_end(value: fn() -> Nil) {
  attribute("onLoadEnd", value)
}

pub fn on_load_start(value: fn() -> Nil) {
  attribute("onLoadStart", value)
}

pub fn on_partial_load(value: fn() -> Nil) {
  attribute("onPartialLoad", value)
}

pub fn on_progress(value: fn(Dynamic) -> Nil) {
  attribute("onProgress", value)
}

pub fn progressive_rendering_enabled(value: Bool) {
  attribute("progressiveRenderingEnabled", value)
}

pub type ReferrerPolicy {
  NoReferrer
  NoReferrerWhenDowngrade
  Origin
  OriginWhenCrossOrigin
  SameOrigin
  StrictOrigin
  StrictOriginWhenCrossOrigin
  UnsafeUrl
}

pub fn referrer_policy(value: ReferrerPolicy) {
  let value = case value {
    NoReferrer -> "no-referrer"
    NoReferrerWhenDowngrade -> "no-referrer-when-downgrade"
    Origin -> "origin"
    OriginWhenCrossOrigin -> "origin-when-cross-origin"
    SameOrigin -> "same-origin"
    StrictOrigin -> "strict-origin"
    StrictOriginWhenCrossOrigin -> "strict-origin-when-cross-origin"
    UnsafeUrl -> "unsafe-url"
  }
  attribute("referrerPolicy", value)
}

pub type ResizeMethod {
  Auto
  Resize
  Scale
  None
}

pub fn resize_method(value: ResizeMethod) {
  let value = case value {
    Auto -> "auto"
    None -> "none"
    Resize -> "resize"
    Scale -> "scale"
  }
  attribute("resizeMethod", value)
}

pub type ResizeMode {
  Cover
  Contain
  Stretch
  Repeat
  Center
}

pub fn resize_mode(value: ResizeMode) {
  let value = case value {
    Center -> "center"
    Contain -> "contain"
    Cover -> "cover"
    Repeat -> "repeat"
    Stretch -> "stretch"
  }
  attribute("resizeMode", value)
}

pub fn resize_multiplier(value: Float) {
  attribute("resizeMultiplier", value)
}

pub type Required

pub fn require(value: Required) {
  attribute("source", value)
}

pub fn source(value) {
  attribute("source", value)
}

pub fn src(value: String) {
  attribute("src", value)
}

pub fn src_set(value: String) {
  attribute("srcSet", value)
}

pub fn style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(style) -> attribute("style", style)
  }
}

pub fn styles(styles: List(Style)) {
  let styles = stylesheet.compile(styles)
  attribute("style", styles)
}

pub fn test_id(value: String) {
  attribute("testID", value)
}

pub fn tint_color(value: String) {
  attribute("tintColor", value)
}

pub fn width(value: Int) {
  attribute("width", value)
}

/// Only to use with `image_background`.
pub fn image_style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(style) -> attribute("imageStyle", style)
  }
}

/// Only to use with `image_background`.
pub fn image_styles(styles: List(Style)) {
  let style = stylesheet.compile(styles)
  attribute("imageStyle", style)
}

/// Only to use with `image_background`.
pub fn image_ref(ref: redraw.Ref(Dynamic)) {
  attribute("imageRef", ref)
}

pub fn none() {
  attribute("none_", Nil)
}
