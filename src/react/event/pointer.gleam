import react/event.{type Event}
import react/event/mouse.{type MouseEvent}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type PointerEvent

@external(javascript, "../../events.ffi.mjs", "height")
pub fn height(event: PointerEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "isPrimary")
pub fn is_primary(event: PointerEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "pointerId")
pub fn pointer_id(event: PointerEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "pointerType")
pub fn pointer_type(event: PointerEvent) -> String

@external(javascript, "../../events.ffi.mjs", "pressure")
pub fn pressure(event: PointerEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "tangentialPressure")
pub fn tangential_pressure(event: PointerEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "tiltX")
pub fn tilt_x(event: PointerEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "tiltY")
pub fn tilt_y(event: PointerEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "twist")
pub fn twist(event: PointerEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "width")
pub fn width(event: PointerEvent) -> Int

pub fn as_mouse_event(event: PointerEvent) -> MouseEvent {
  coerce(event)
}

pub fn as_ui_event(event: PointerEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: PointerEvent) -> Event {
  coerce(event)
}
