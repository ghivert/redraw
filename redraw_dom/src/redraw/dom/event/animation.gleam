//// The `AnimationEvent` interface represents events providing information
//// related to [animations](https://developer.mozilla.org/docs/Web/CSS/CSS_animations/Using_CSS_animations).

import redraw/event.{type Event}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/AnimationEvent)
pub type AnimationEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/AnimationEvent/animationName)
@external(javascript, "./events.ffi.mjs", "animationName")
pub fn animation_name(event: AnimationEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/AnimationEvent/elapsedTime)
@external(javascript, "./events.ffi.mjs", "elapsedTime")
pub fn elapsed_time(event: AnimationEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/AnimationEvent/pseudoElement)
@external(javascript, "./events.ffi.mjs", "pseudoElement")
pub fn pseudo_element(event: AnimationEvent) -> String

/// `AnimationEvent` inherits `Event`.
pub const as_event: fn(AnimationEvent) -> Event = unsafe.coerce
