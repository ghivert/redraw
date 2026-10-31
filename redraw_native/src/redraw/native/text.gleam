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

pub type Mode {
  Head
  Middle
  Tail
  Clip
}

fn mode_to_string(mode: Mode) {
  case mode {
    Head -> "head"
    Middle -> "middle"
    Tail -> "Tail"
    Clip -> "clip"
  }
}

/// Specifies whether fonts should scale to respect Text Size accessibility settings.
/// The default is `true`.
pub fn allow_font_scaling(value: Bool) {
  attribute("allowFontScaling", value)
}

/// This can be one of the following values:
///
/// - `head` - The line is displayed so that the end fits in the container and the missing text
/// at the beginning of the line is indicated by an ellipsis glyph. e.g., "...wxyz"
/// - `middle` - The line is displayed so that the beginning and end fit in the container and the
/// missing text in the middle is indicated by an ellipsis glyph. "ab...yz"
/// - `tail` - The line is displayed so that the beginning fits in the container and the
/// missing text at the end of the line is indicated by an ellipsis glyph. e.g., "abcd..."
/// - `clip` - Lines are not drawn past the edge of the text container.
///
/// The default is `tail`.
///
/// `numberOfLines` must be set in conjunction with this prop.
///
/// > `clip` is working only for iOS
pub fn ellipsize_mode(mode: Mode) {
  let mode = mode_to_string(mode)
  attribute("ellipsizeMode", mode)
}

/// Used to reference react managed views from native code.
pub fn id(id: String) {
  attribute("id", id)
}

/// Line Break mode. Works only with numberOfLines.
/// clip is working only for iOS
pub fn line_break_mode(mode: Mode) {
  let mode = mode_to_string(mode)
  attribute("lineBreakMode", mode)
}

/// Used to truncate the text with an ellipsis after computing the text
/// layout, including line wrapping, such that the total number of lines
/// does not exceed this number.
///
/// This prop is commonly used with `ellipsizeMode`.
pub fn number_of_lines(value: Int) {
  attribute("numberOfLines", value)
}

/// Invoked on mount and layout changes with
///
/// {nativeEvent: { layout: {x, y, width, height}}}.
/// pub fn on_layout(on: fn(LayoutChangeEvent) -> Nil) {
pub fn on_layout(on: fn(Dynamic) -> Nil) -> Attribute {
  attribute("onLayout", on)
}

/// Invoked on Text layout
/// pub fn on_text_layout(on: fn(NativeSyntheticEvent(TextLayoutEventData)) -> Nil) {
pub fn on_text_layout(on: fn(Dynamic) -> Nil) -> Attribute {
  attribute("onTextLayout", on)
}

/// This function is called on press.
/// Text intrinsically supports press handling with a default highlight state (which can be disabled with suppressHighlighting).
/// pub fn on_press(on: fn(GestureResponderEvent) -> Nil) {
pub fn on_press(on: fn(Dynamic) -> Nil) {
  attribute("onPress", on)
}

/// pub fn on_press_in(on: fn(GestureResponderEvent) -> Nil) {
pub fn on_press_in(on: fn(Dynamic) -> Nil) {
  attribute("onPressIn", on)
}

/// pub fn on_press_out(on: fn(GestureResponderEvent) -> Nil) {
pub fn on_press_out(on: fn(Dynamic) -> Nil) {
  attribute("onPressOut", on)
}

/// This function is called on long press.
/// e.g., `onLongPress={this.increaseSize}>`
/// pub fn on_long_press(on: fn(GestureResponderEvent) -> Nil) {
pub fn on_long_press(on: fn(Dynamic) -> Nil) {
  attribute("onLongPress", on)
}

/// @see https://reactnative.dev/docs/text#style
pub fn style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(styles) -> attribute("style", styles)
  }
}

pub fn styles(styles: List(Style)) {
  attribute("style", stylesheet.compile(styles))
}

/// Used to locate this view in end-to-end tests.
pub fn test_id(id: String) {
  attribute("testId", id)
}

/// Used to reference react managed views from native code.
pub fn native_id(id: String) {
  attribute("nativeId", id)
}

/// Specifies largest possible scale a font can reach when allowFontScaling is enabled. Possible values:
/// - null/undefined (default): inherit from the parent node or the global default (0)
/// - 0: no max, ignore parent/global default
/// - >= 1: sets the maxFontSizeMultiplier of this node to this value
pub fn max_font_size_multiplier(value: Int) {
  attribute("maxFontSizeMultiplier", value)
}

/// Specifies smallest possible scale a font can reach when adjustsFontSizeToFit is enabled. (values 0.01-1.0).
pub fn minimum_font_scale(value: Int) {
  attribute("minimumFontScale", value)
}

pub fn none() {
  attribute("none_", Nil)
}

pub type PointerEvents {
  BoxNone
  NoEvent
  BoxOnly
  Auto
}

fn convert_pointer_events(events: PointerEvents) {
  case events {
    Auto -> "auto"
    BoxNone -> "box-none"
    BoxOnly -> "box-only"
    NoEvent -> "none"
  }
}

/// In the absence of auto property, none is much like CSS's none value. box-none is as if you had applied the CSS class:
///
/// .box-none {
///   pointer-events: none;
/// }
/// .box-none /// {
///   pointer-events: all;
/// }
///
/// box-only is the equivalent of
///
/// .box-only {
///   pointer-events: all;
/// }
/// .box-only /// {
///   pointer-events: none;
/// }
///
/// But since pointerEvents does not affect layout/appearance, and we are already deviating from the spec by adding additional modes,
/// we opt to not include pointerEvents on style. On some platforms, we would need to implement it as a className anyways. Using style or not is an implementation detail of the platform.
pub fn pointer_events(events: PointerEvents) {
  let pointer_events = convert_pointer_events(events)
  attribute("pointerEvents", pointer_events)
}

/// Specifies whether font should be scaled down automatically to fit given style constraints.
pub fn adjusts_font_size_to_fit(value: Bool) {
  attribute("adjustsFontSizeToFit", value)
}

pub type DynamicTypeRamp {
  Caption2
  Caption1
  Footnote
  Subheadline
  Callout
  Body
  Headline
  Title3
  Title2
  Title1
  LargeTitle
}

/// The Dynamic Type scale ramp to apply to this element on iOS.
pub fn dynamic_type_ramp(value: DynamicTypeRamp) {
  let value = case value {
    Caption2 -> "caption2"
    Caption1 -> "caption1"
    Footnote -> "footnote"
    Subheadline -> "subheadline"
    Callout -> "callout"
    Body -> "body"
    Headline -> "headline"
    Title3 -> "title3"
    Title2 -> "title2"
    Title1 -> "title1"
    LargeTitle -> "largetitle"
  }
  attribute("dynamicTypeRamp", value)
}

/// When `true`, no visual change is made when text is pressed down. By
/// default, a gray oval highlights the text on press down.
pub fn suppress_highlighting(value: Bool) {
  attribute("suppressHighlighting", value)
}

pub type LineBreakStrategyIOS {
  NoStrategy
  Standard
  HangulWord
  PushOut
}

/// Set line break strategy on iOS.
pub fn line_break_strategy_ios(strategy: LineBreakStrategyIOS) {
  let strategy = case strategy {
    NoStrategy -> "none"
    Standard -> "standard"
    HangulWord -> "hangul-word"
    PushOut -> "push-out"
  }
  attribute("lineBreakStrategyIOS", strategy)
}

/// Specifies the disabled state of the text view for testing purposes.
pub fn disabled(value: Bool) {
  attribute("disabled", value)
}

/// Lets the user select text, to use the native copy and paste functionality.
pub fn selectable(value: Bool) {
  attribute("selectable", value)
}

/// The highlight color of the text.
pub fn selection_color(color: String) {
  attribute("selectionColor", color)
}

pub type TextBreakStrategy {
  Simple
  HighQuality
  Balanced
}

/// Set text break strategy on Android API Level 23+
/// default is `highQuality`.
pub fn text_break_strategy(strategy: TextBreakStrategy) {
  let strategy = case strategy {
    Simple -> "simple"
    HighQuality -> "highQuality"
    Balanced -> "balanced"
  }
  attribute("textBreakStrategy", strategy)
}

pub type DataDetectorType {

  PhoneNumber
  Link
  Email
  NoType
  All
}

/// Determines the types of data converted to clickable URLs in the text element.
/// By default no data types are detected.
pub fn data_detector_type(type_: DataDetectorType) {
  let type_ = case type_ {
    PhoneNumber -> "phoneNumber"
    Link -> "link"
    Email -> "email"
    NoType -> "none"
    All -> "all"
  }
  attribute("dataDetectorType", type_)
}

pub type HyphenationFrequency {
  Normal
  NoFrequency
  Full
}

/// Hyphenation strategy
pub fn android_hyphenation_frequency(frequency: HyphenationFrequency) {
  let frequency = case frequency {
    Normal -> "normal"
    NoFrequency -> "none"
    Full -> "full"
  }
  attribute("android_hyphenationFrequency", frequency)
}
