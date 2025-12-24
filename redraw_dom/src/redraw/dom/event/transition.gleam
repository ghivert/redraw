//// The `TransitionEvent` interface represents events providing information
//// related to [transitions](https://developer.mozilla.org/docs/Web/CSS/CSS_transitions/Using_CSS_transitions).

import redraw/event.{type Event}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TransitionEvent)
pub type TransitionEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TransitionEvent/elapsedTime)
@external(javascript, "./events.ffi.mjs", "elapsedTime")
pub fn elapsed_time(event: TransitionEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TransitionEvent/propertyName)
@external(javascript, "./events.ffi.mjs", "propertyName")
pub fn property_name(event: TransitionEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/TransitionEvent/pseudoElement)
@external(javascript, "./events.ffi.mjs", "pseudoElement")
pub fn pseudo_element(event: TransitionEvent) -> String

/// `TransitionEvent` inherits `Event`.
pub const as_event: fn(TransitionEvent) -> Event = unsafe.coerce
