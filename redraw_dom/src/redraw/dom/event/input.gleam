//// The `InputEvent` interface represents an event notifying the user of editable content changes.

import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/InputEvent)
pub type InputEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/InputEvent/data)
@external(javascript, "../../../events.ffi.mjs", "data")
pub fn data(event: InputEvent) -> String

/// `InputEvent` inherits `Event`.
pub fn as_event(event: InputEvent) -> Event {
  coerce(event)
}
