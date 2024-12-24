//// The `DragEvent` interface is a DOM event that represents a drag and drop
//// interaction. The user initiates a drag by placing a pointer device (such as
//// a mouse) on the touch surface and then dragging the pointer to a new
//// location (such as another DOM element). Applications are free to interpret
//// a drag and drop interaction in an application-specific way.
////
//// [Drag and Drop API Documentation](https://developer.mozilla.org/docs/Web/API/HTML_Drag_and_Drop_API)

import gleam/dynamic
import redraw/dom/event/mouse.{type MouseEvent}
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/DragEvent)
pub type DragEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/DragEvent/dataTransfer)
@external(javascript, "../../../events.ffi.mjs", "dataTransfer")
pub fn data_transfer(event: DragEvent) -> dynamic.Dynamic

/// `DragEvent` inherits from `MouseEvent`.
pub fn as_mouse_event(event: DragEvent) -> MouseEvent {
  coerce(event)
}

/// `DragEvent` inherits from `UIEvent`.
pub fn as_ui_event(event: DragEvent) -> UIEvent {
  coerce(event)
}

/// `DragEvent` inherits `Event`.
pub fn as_event(event: DragEvent) -> Event {
  coerce(event)
}
