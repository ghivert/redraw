import gleam/dynamic
import redraw/event.{type Event}
import redraw/event/mouse.{type MouseEvent}
import redraw/event/ui.{type UIEvent}
import redraw/internals/coerce.{coerce}

pub type DragEvent

@external(javascript, "../../events.ffi.mjs", "dataTransfer")
pub fn data_transfer(event: DragEvent) -> dynamic.Dynamic

pub fn as_mouse_event(event: DragEvent) -> MouseEvent {
  coerce(event)
}

pub fn as_ui_event(event: DragEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: DragEvent) -> Event {
  coerce(event)
}
