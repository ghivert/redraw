import gleam/dynamic
import react/event.{type Event}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type FocusEvent

@external(javascript, "../../events.ffi.mjs", "relatedTarget")
pub fn related_target(event: FocusEvent) -> dynamic.Dynamic

pub fn as_ui_event(event: FocusEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: FocusEvent) -> Event {
  coerce(event)
}
