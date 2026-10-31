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

pub type Insets {
  Insets(top: Int, bottom: Int, left: Int, right: Int)
}

/// This defines how far a touch event can start away from the view.
/// Typical interface guidelines recommend touch targets that are at least
/// 30 - 40 points/density-independent pixels. If a Touchable view has
/// a height of 20 the touchable height can be extended to 40 with
/// hitSlop={{top: 10, bottom: 10, left: 0, right: 0}}
/// NOTE The touch area never extends past the parent view bounds and
/// the Z-index of sibling views always takes precedence if a touch
/// hits two overlapping views.
pub fn hit_slop(insets: Insets) {
  attribute("hitSlop", insets)
}

/// This defines how far a touch event can start away from the view.
/// Typical interface guidelines recommend touch targets that are at least
/// 30 - 40 points/density-independent pixels. If a Touchable view has
/// a height of 20 the touchable height can be extended to 40 with
/// hitSlop={{top: 10, bottom: 10, left: 0, right: 0}}
/// NOTE The touch area never extends past the parent view bounds and
/// the Z-index of sibling views always takes precedence if a touch
/// hits two overlapping views.
pub fn hit_slop_(value: Int) {
  attribute("hitSlop", value)
}

/// Used to reference react managed views from native code.
pub fn id(value: String) {
  attribute("id", value)
}

/// Whether this view needs to rendered offscreen and composited with an alpha in order to preserve 100% correct colors and blending behavior.
/// The default (false) falls back to drawing the component and its children
/// with an alpha applied to the paint used to draw each element instead of rendering the full component offscreen and compositing it back with an alpha value.
/// This default may be noticeable and undesired in the case where the View you are setting an opacity on
/// has multiple overlapping elements (e.g. multiple overlapping Views, or text and a background).
///
/// Rendering offscreen to preserve correct alpha behavior is extremely expensive
/// and hard to debug for non-native developers, which is why it is not turned on by default.
/// If you do need to enable this property for an animation,
/// consider combining it with renderToHardwareTextureAndroid if the view contents are static (i.e. it doesn't need to be redrawn each frame).
/// If that property is enabled, this View will be rendered off-screen once,
/// saved in a hardware texture, and then composited onto the screen with an alpha each frame without having to switch rendering targets on the GPU.
pub fn needs_offscreen_alpha_compositing(value: Bool) {
  attribute("needsOffscreenAlphaCompositing", value)
}

/// Invoked on mount and layout changes with
///
/// {nativeEvent: { layout: {x, y, width, height}}}.
pub fn on_layout(on: fn(Dynamic) -> Nil) {
  attribute("onLayout", on)
}

pub type PointerEvents {
  BoxNone
  None
  BoxOnly
  Auto
}

fn convert_pointer_events(events: PointerEvents) {
  case events {
    Auto -> "auto"
    BoxNone -> "box-none"
    BoxOnly -> "box-only"
    None -> "none"
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

/// This is a special performance property exposed by RCTView and is useful for scrolling content when there are many subviews,
/// most of which are offscreen. For this property to be effective, it must be applied to a view that contains many subviews that extend outside its bound.
/// The subviews must also have overflow: hidden, as should the containing view (or one of its superviews).
pub fn remove_clipped_subviews(value: Bool) {
  attribute("removeClippedSubviews", value)
}

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

/// Views that are only used to layout their children or otherwise don't draw anything
/// may be automatically removed from the native hierarchy as an optimization.
/// Set this property to false to disable this optimization and ensure that this View exists in the native view hierarchy.
pub fn collapsable(value: Bool) {
  attribute("collapsable", value)
}

/// Setting to false prevents direct children of the view from being removed
/// from the native view hierarchy, similar to the effect of setting
/// `collapsable={false}` on each child.
pub fn collapsable_children(value: Bool) {
  attribute("collapsableChildren", value)
}

/// Whether this view should render itself (and all of its children) into a single hardware texture on the GPU.
///
/// On Android, this is useful for animations and interactions that only modify opacity, rotation, translation, and/or scale:
/// in those cases, the view doesn't have to be redrawn and display lists don't need to be re-executed. The texture can just be
/// re-used and re-composited with different parameters. The downside is that this can use up limited video memory, so this prop should be set back to false at the end of the interaction/animation.
pub fn render_to_hardware_texture_android(value: Bool) {
  attribute("renderToHardwareTextureAndroid", value)
}

/// Whether this `View` should be focusable with a non-touch input device, eg. receive focus with a hardware keyboard.
pub fn focusable(value: Bool) {
  attribute("focusable", value)
}

pub type TabIndex {
  Focusable
  NotFocusable
}

/// Indicates whether this `View` should be focusable with a non-touch input device, eg. receive focus with a hardware keyboard.
/// See https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/tabindex
/// for more details.
///
/// Supports the following values:
/// -  0 (View is focusable)
/// - -1 (View is not focusable)
pub fn tab_index(value: TabIndex) {
  let value = case value {
    Focusable -> 0
    NotFocusable -> -1
  }
  attribute("tabIndex", value)
}

/// Whether this view should be rendered as a bitmap before compositing.
///
/// On iOS, this is useful for animations and interactions that do not modify this component's dimensions nor its children;
/// for example, when translating the position of a static view, rasterization allows the renderer to reuse a cached bitmap of a static view
/// and quickly composite it during each frame.
///
/// Rasterization incurs an off-screen drawing pass and the bitmap consumes memory.
/// Test and measure when using this property.
pub fn should_rasterize_ios(value: Bool) {
  attribute("shouldRasterizeIOS", value)
}

/// *(Apple TV only)* When set to true, this view will be focusable
/// and navigable using the Apple TV remote.
///
/// @platform ios
pub fn is_tv_selectable(value: Bool) {
  attribute("isTVSelectable", value)
}

/// *(Apple TV only)* May be set to true to force the Apple TV focus engine to move focus to this view.
///
/// @platform ios
pub fn has_tv_preferred_focus(value: Bool) {
  attribute("hasTVPreferredFocus", value)
}

/// *(Apple TV only)* May be used to change the appearance of the Apple TV parallax effect when this view goes in or out of focus.  Defaults to 2.0.
///
/// @platform ios
pub fn tv_parallax_shift_distance_x(value: Float) {
  attribute("tvParallaxShiftDistanceX", value)
}

/// *(Apple TV only)* May be used to change the appearance of the Apple TV parallax effect when this view goes in or out of focus.  Defaults to 2.0.
///
/// @platform ios
pub fn tv_parallax_shift_distance_y(value: Float) {
  attribute("tvParallaxShiftDistanceY", value)
}

/// *(Apple TV only)* May be used to change the appearance of the Apple TV parallax effect when this view goes in or out of focus.  Defaults to 0.05.
///
/// @platform ios
pub fn tv_parallax_tilt_angle(value: Float) {
  attribute("tvParallaxTiltAngle", value)
}

/// *(Apple TV only)* May be used to change the appearance of the Apple TV parallax effect when this view goes in or out of focus.  Defaults to 1.0.
///
/// @platform ios
pub fn tv_parallax_magnification(value: Float) {
  attribute("tvParallaxMagnification", value)
}

pub fn none() {
  attribute("none_", Nil)
}
// Styles

// backfaceVisibility
// backgroundColor
// borderBottomColor
// borderBlockColor
// borderBlockEndColor
// borderBlockStartColor
// borderBottomEndRadius
// borderBottomLeftRadius
// borderBottomRightRadius
// borderBottomStartRadius
// borderStartEndRadius
// borderStartStartRadius
// borderEndEndRadius
// borderEndStartRadius
// borderBottomWidth
// borderColor
// borderCurve
// iOS
// borderEndColor
// borderLeftColor
// borderLeftWidth
// borderRadius
// borderRightColor
// borderRightWidth
// borderStartColor
// borderStyle
// borderTopColor
// borderTopEndRadius
// borderTopLeftRadius
// borderTopRightRadius
// borderTopStartRadius
// borderTopWidth
// borderWidth
// boxShadow
// cursor
// iOS
// elevation
// Android
// filter
// opacity
// outlineColor
// outlineOffset
// outlineStyle
// outlineWidth
// pointerEvents
