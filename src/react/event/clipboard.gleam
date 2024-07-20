import gleam/dynamic
import react/event.{type Event}
import react/internals/coerce.{coerce}

pub type ClipboardEvent

@external(javascript, "../../events.ffi.mjs", "clipboardData")
pub fn clipboard_data(event: ClipboardEvent) -> dynamic.Dynamic

pub fn as_event(event: ClipboardEvent) -> Event {
  coerce(event)
}
