//// The `InputEvent` interface represents an event notifying the user of editable content changes.

import redraw/event.{type Event}
import redraw/internals/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/InputEvent)
pub type InputEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/InputEvent/data)
@external(javascript, "./events.ffi.mjs", "data")
pub fn data(event: InputEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements/input#value)
@external(javascript, "./events.ffi.mjs", "value")
pub fn value(event: InputEvent) -> String

/// `InputEvent` inherits `Event`.
pub const as_event: fn(InputEvent) -> Event = unsafe.coerce
