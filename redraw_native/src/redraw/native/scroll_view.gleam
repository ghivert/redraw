import gleam/dynamic.{type Dynamic}
import redraw.{type Component}
import redraw/internals/unsafe
import redraw/native/internal/attributes
import redraw/native/view

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn sticky_header_component(render: fn() -> Component) {
  attribute("StickyHeaderComponent", render)
}

pub fn always_bounce_horizontal(value: Bool) {
  attribute("alwaysBounceHorizontal", value)
}

pub fn always_bounce_vertical(value: Bool) {
  attribute("alwaysBounceVertical", value)
}

pub fn automatically_adjust_content_insets(value: Bool) {
  attribute("automaticallyAdjustContentInsets", value)
}

pub fn automatically_adjust_keyboard_insets(value: Bool) {
  attribute("automaticallyAdjustKeyboardInsets", value)
}

pub fn automatically_adjusts_scroll_indicator_insets(value: Bool) {
  attribute("automaticallyAdjustsScrollIndicatorInsets", value)
}

pub fn bounces(value: Bool) {
  attribute("bounces", value)
}

pub fn bounces_zoom(value: Bool) {
  attribute("bouncesZoom", value)
}

pub fn can_cancel_content_touches(value: Bool) {
  attribute("canCancelContentTouches", value)
}

pub fn center_content(value: Bool) {
  attribute("centerContent", value)
}

pub fn content_container_style() {
  attribute("contentContainerStyle", Nil)
}

pub fn content_inset(value: view.Insets) {
  attribute("contentInset", value)
}

pub type ContentInsetAdjustmentBehavior {
  Automatic
  ScrollableAxes
  Never
  Always
}

pub fn content_inset_adjustment_behavior(
  value: ContentInsetAdjustmentBehavior,
) -> Attribute {
  let value = case value {
    Automatic -> "automatic"
    ScrollableAxes -> "scrollableAxes"
    Never -> "never"
    Always -> "always"
  }
  attribute("contentInsetAdjustmentBehavior", value)
}

pub type Point {
  Point(x: Int, y: Int)
}

pub fn content_offset(value: Point) {
  attribute("contentOffset", value)
}

pub type DecelerationRate {
  Normal
  Fast
}

pub fn deceleration_rate(value: DecelerationRate) {
  let value = case value {
    Fast -> "fast"
    Normal -> "normal"
  }
  attribute("decelerationRate", value)
}

pub fn deceleration_rate_(value: Float) {
  attribute("decelerationRate", value)
}

pub fn directional_lock_enabled(value: Bool) {
  attribute("directionalLockEnabled", value)
}

pub fn disable_interval_momentum(value: Bool) {
  attribute("disableIntervalMomentum", value)
}

pub fn disable_scroll_view_pan_responder(value: Bool) {
  attribute("disableScrollViewPanResponder", value)
}

pub fn end_fill_color(value: String) {
  attribute("endFillColor", value)
}

pub fn fading_edge_length(value: Int) {
  attribute("fadingEdgeLength", value)
}

pub fn horizontal(value: Bool) {
  attribute("horizontal", value)
}

pub fn default_indicator() {
  attribute("indicatorStyle", "default")
}

pub fn dark_indicator() {
  attribute("indicatorStyle", "dark")
}

pub fn white_indicator() {
  attribute("indicatorStyle", "white")
}

pub fn invert_sticky_headers(value: Bool) {
  attribute("invertStickyHeaders", value)
}

pub type KeyboardDismissMode {
  None
  OnDrag
  Interactive
}

pub fn keyboard_dismiss_mode(value: KeyboardDismissMode) {
  let value = case value {
    Interactive -> "interactive"
    None -> "none"
    OnDrag -> "on-drag"
  }
  attribute("keyboardDismissMode", value)
}

pub type KeyboardShouldPersistTaps {
  NeverPersist
  AlwaysPersist
  Handled
}

pub fn keyboard_should_persist_taps(value: KeyboardShouldPersistTaps) {
  let value = case value {
    AlwaysPersist -> "always"
    Handled -> "handled"
    NeverPersist -> "never"
  }
  attribute("keyboardShouldPersistTaps", value)
}

pub fn maintain_visible_content_position(
  min_index_for_visible min_index_for_visible: Int,
  autoscroll_to_top_threshold autoscroll_to_top_threshold: Int,
) {
  let value =
    attributes.to_maintain_visible_content_position(
      min_index_for_visible,
      autoscroll_to_top_threshold,
    )
  attribute("maintainVisibleContentPosition", value)
}

pub fn maximum_zoom_scale(value: Float) {
  attribute("maximumZoomScale", value)
}

pub fn minimum_zoom_scale(value: Float) {
  attribute("minimumZoomScale", value)
}

pub fn nested_scroll_enabled(value: Bool) {
  attribute("nestedScrollEnabled", value)
}

pub fn on_content_size_change(value: fn(Int, Int) -> Nil) {
  attribute("onContentSizeChange", value)
}

pub fn on_momentum_scroll_begin(value: fn() -> Nil) {
  attribute("onMomentumScrollBegin", value)
}

pub fn on_momentum_scroll_end(value: fn() -> Nil) {
  attribute("onMomentumScrollEnd", value)
}

pub fn on_scroll(value: fn(Dynamic) -> Nil) {
  attribute("onScroll", value)
}

pub fn on_scroll_begin_drag(value: fn() -> Nil) {
  attribute("onScrollBeginDrag", value)
}

pub fn on_scroll_end_drag(value: fn() -> Nil) {
  attribute("onScrollEndDrag", value)
}

pub fn on_scroll_to_top(value: fn() -> Nil) {
  attribute("onScrollToTop", value)
}

pub type OverScrollMode {
  AutoOverScroll
  AlwaysOverScroll
  NeverOverScroll
}

pub fn over_scroll_mode(value: OverScrollMode) {
  let value = case value {
    AlwaysOverScroll -> "always"
    AutoOverScroll -> "auto"
    NeverOverScroll -> "never"
  }
  attribute("overScrollMode", value)
}

pub fn paging_enabled(value: Bool) {
  attribute("pagingEnabled", value)
}

pub fn persistent_scrollbar(value: Bool) {
  attribute("persistentScrollbar", value)
}

pub fn pinch_gesture_enabled(value: Bool) {
  attribute("pinchGestureEnabled", value)
}

pub fn refresh_control(value: Component) {
  attribute("refreshControl", value)
}

pub fn remove_clipped_subviews(value: Bool) {
  attribute("removeClippedSubviews", value)
}

pub fn scroll_enabled(value: Bool) {
  attribute("scrollEnabled", value)
}

pub fn scroll_event_throttle(value: Int) {
  attribute("scrollEventThrottle", value)
}

pub fn scroll_indicator_insets(value: view.Insets) {
  attribute("scrollIndicatorInsets", value)
}

pub fn scroll_perf_tag(value: String) {
  attribute("scrollPerfTag", value)
}

pub fn scroll_to_overflow_enabled(value: Bool) {
  attribute("scrollToOverflowEnabled", value)
}

pub fn scrolls_to_top(value: Bool) {
  attribute("scrollsToTop", value)
}

pub fn shows_horizontal_scroll_indicator(value: Bool) {
  attribute("showsHorizontalScrollIndicator", value)
}

pub fn shows_vertical_scroll_indicator(value: Bool) {
  attribute("showsVerticalScrollIndicator", value)
}

pub type Snap {
  Start
  Center
  End
}

pub fn snap_to_alignment(value: Snap) {
  let value = case value {
    Center -> "center"
    End -> "end"
    Start -> "start"
  }
  attribute("snapToAlignment", value)
}

pub fn snap_to_end(value: Bool) {
  attribute("snapToEnd", value)
}

pub fn snap_to_interval(value: Int) {
  attribute("snapToInterval", value)
}

pub fn snap_to_offsets(value: List(Int)) {
  let value = attributes.to_array(value)
  attribute("snapToOffsets", value)
}

pub fn snap_to_start(value: Bool) {
  attribute("snapToStart", value)
}

pub fn sticky_header_hidden_on_scroll(value: Bool) {
  attribute("stickyHeaderHiddenOnScroll", value)
}

pub fn sticky_header_indices(value: List(Int)) {
  let value = attributes.to_array(value)
  attribute("stickyHeaderIndices", value)
}

pub fn zoom_scale(value: Float) {
  attribute("zoomScale", value)
}
