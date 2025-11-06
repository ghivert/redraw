//// The DOM `CompositionEvent` represents events that occur due to the user
//// indirectly entering text.
////
//// [Input Method Editor Documentation](https://developer.mozilla.org/docs/Glossary/Input_method_editor).

import redraw/event.{type Event}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/CompositionEvent)
pub type CompositionEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/CompositionEvent/data)
@external(javascript, "./events.ffi.mjs", "data")
pub fn data(event: CompositionEvent) -> String

/// `CompositionEvent` inherits `Event`.
pub const as_event: fn(CompositionEvent) -> Event = unsafe.coerce
