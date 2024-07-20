import react/event.{type Event}
import react/event/mouse.{type MouseEvent}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type WheelEvent

@external(javascript, "../../events.ffi.mjs", "deltaMode")
pub fn delta_mode(event: WheelEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "deltaX")
pub fn delta_x(event: WheelEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "deltaY")
pub fn delta_y(event: WheelEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "deltaZ")
pub fn delta_z(event: WheelEvent) -> Float

pub fn as_mouse_event(event: WheelEvent) -> MouseEvent {
  coerce(event)
}

pub fn as_ui_event(event: WheelEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: WheelEvent) -> Event {
  coerce(event)
}
