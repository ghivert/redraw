//// The `PointerEvent` interface represents the state of a DOM event produced by
//// a pointer such as the geometry of the contact point, the device type that
//// generated the event, the amount of pressure that was applied on the contact
//// surface, etc.
////
//// A pointer is a hardware agnostic representation of input devices (such as a
//// mouse, pen or contact point on a touch-enable surface). The pointer can
//// target a specific coordinate (or set of coordinates) on the contact surface
//// such as a screen.
////
//// A pointer's hit test is the process a browser uses to determine the target
//// element for a pointer event. Typically, this is determined by considering
//// the pointer's location and also the visual layout of elements in a document
//// on screen media.

import redraw/event.{type Event}
import redraw/event/mouse.{type MouseEvent}
import redraw/event/ui.{type UIEvent}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent)
pub type PointerEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/altitudeAngle)
@external(javascript, "../../events.ffi.mjs", "altitudeAngle")
pub fn altitude_angle(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/azimuthAngle)
@external(javascript, "../../events.ffi.mjs", "azimuthAngle")
pub fn azimuth_angle(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/height)
@external(javascript, "../../events.ffi.mjs", "height")
pub fn height(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/isPrimary)
@external(javascript, "../../events.ffi.mjs", "isPrimary")
pub fn is_primary(event: PointerEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/pointerId)
@external(javascript, "../../events.ffi.mjs", "pointerId")
pub fn pointer_id(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/pointerType)
@external(javascript, "../../events.ffi.mjs", "pointerType")
pub fn pointer_type(event: PointerEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/pressure)
@external(javascript, "../../events.ffi.mjs", "pressure")
pub fn pressure(event: PointerEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/tangentialPressure)
@external(javascript, "../../events.ffi.mjs", "tangentialPressure")
pub fn tangential_pressure(event: PointerEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/tiltX)
@external(javascript, "../../events.ffi.mjs", "tiltX")
pub fn tilt_x(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/tiltY)
@external(javascript, "../../events.ffi.mjs", "tiltY")
pub fn tilt_y(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/twist)
@external(javascript, "../../events.ffi.mjs", "twist")
pub fn twist(event: PointerEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/PointerEvent/width)
@external(javascript, "../../events.ffi.mjs", "width")
pub fn width(event: PointerEvent) -> Int

/// `PointerEvent` inherits `MouseEvent`.
pub fn as_mouse_event(event: PointerEvent) -> MouseEvent {
  coerce(event)
}

/// `PointerEvent` inherits `UIEvent`.
pub fn as_ui_event(event: PointerEvent) -> UIEvent {
  coerce(event)
}

/// `PointerEvent` inherits `Event`.
pub fn as_event(event: PointerEvent) -> Event {
  coerce(event)
}
