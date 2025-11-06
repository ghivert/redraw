//// To provide quality support for touch-based user interfaces, touch events
//// offer the ability to interpret finger (or stylus) activity on touch screens
//// or trackpads.
////
//// The touch events interfaces are relatively low-level APIs that can be used
//// to support application-specific multi-touch interactions such as a
//// two-finger gesture. A multi-touch interaction starts when a finger (or
//// stylus) first touches the contact surface. Other fingers may subsequently
//// touch the surface and optionally move across the touch surface. The
//// interaction ends when the fingers are removed from the surface. During this
//// interaction, an application receives touch events during the start, move,
//// and end phases.
////
//// Touch events are similar to mouse events except they support simultaneous
//// touches and at different locations on the touch surface. The `TouchEvent`
//// interface encapsulates all of the touchpoints that are currently active.
//// The [`Touch`](https://developer.mozilla.org/docs/Web/API/Touch)
//// interface, which represents a single touchpoint, includes information such
//// as the position of the touch point relative to the browser viewport.
////
//// [Documentation](https://developer.mozilla.org/docs/Web/API/Touch_events)

import gleam/dynamic
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent)
pub type TouchEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/altKey)
@external(javascript, "./events.ffi.mjs", "altKey")
pub fn alt_key(event: TouchEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/ctrlKey)
@external(javascript, "./events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: TouchEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/changedTouches)
@external(javascript, "./events.ffi.mjs", "changedTouches")
pub fn changed_touches(event: TouchEvent) -> dynamic.Dynamic

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/metaKey)
@external(javascript, "./events.ffi.mjs", "metaKey")
pub fn meta_key(event: TouchEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/shiftKey)
@external(javascript, "./events.ffi.mjs", "shiftKey")
pub fn shift_key(event: TouchEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/touches)
@external(javascript, "./events.ffi.mjs", "touches")
pub fn touches(event: TouchEvent) -> dynamic.Dynamic

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/targetTouches)
@external(javascript, "./events.ffi.mjs", "targetTouches")
pub fn target_touches(event: TouchEvent) -> dynamic.Dynamic

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TouchEvent/getModifierState)
@external(javascript, "./events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: TouchEvent, key: String) -> Bool

/// `TouchEvent` inherits `UIEvent`.
pub const as_ui_event: fn(TouchEvent) -> UIEvent = unsafe.coerce

/// `TouchEvent` inherits `Event`.
pub const as_event: fn(TouchEvent) -> Event = unsafe.coerce
