//// The `WheelEvent` interface represents events that occur due to the user
//// moving a mouse wheel or similar input device.
////
//// > This is the standard wheel event interface to use. Old versions
//// of browsers implemented the non-standard and non-cross-browser-compatible
//// `MouseWheelEvent` and `MouseScrollEvent` interfaces. Use this interface and
//// avoid the non-standard ones.
////
//// Don't confuse the wheel event with the [`scroll`](https://developer.mozilla.org/docs/Web/API/Element/scroll_event) event:
//// - A `wheel` event doesn't necessarily dispatch a `scroll` event. For example,
////   the element may be unscrollable at all. Zooming actions using the wheel
////   or trackpad also fire `wheel` events.
//// - A `scroll` event isn't necessarily triggered by a `wheel` event. Elements
////   can also be scrolled by using the keyboard, dragging a scrollbar, or
////   using JavaScript.
//// - Even when the `wheel` event does trigger scrolling, the `delta*` values in
////   the `wheel` event don't necessarily reflect the content's scrolling
////   direction.

import redraw/dom/event/mouse.{type MouseEvent}
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/WheelEvent)
pub type WheelEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/WheelEvent/deltaMode)
@external(javascript, "./events.ffi.mjs", "deltaMode")
pub fn delta_mode(event: WheelEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/WheelEvent/deltaX)
@external(javascript, "./events.ffi.mjs", "deltaX")
pub fn delta_x(event: WheelEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/WheelEvent/deltaY)
@external(javascript, "./events.ffi.mjs", "deltaY")
pub fn delta_y(event: WheelEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/WheelEvent/deltaZ)
@external(javascript, "./events.ffi.mjs", "deltaZ")
pub fn delta_z(event: WheelEvent) -> Float

/// `WheelEvent` inherits `MouseEvent`.
pub const as_mouse_event: fn(WheelEvent) -> MouseEvent = unsafe.coerce

/// `WheelEvent` inherits `UIEvent`.
pub const as_ui_event: fn(WheelEvent) -> UIEvent = unsafe.coerce

/// `WheelEvent` inherits `Event`.
pub const as_event: fn(WheelEvent) -> Event = unsafe.coerce
