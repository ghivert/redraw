import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

pub type AnimationEvent

@external(javascript, "../../events.ffi.mjs", "animationName")
pub fn animation_name(event: AnimationEvent) -> String

@external(javascript, "../../events.ffi.mjs", "elapsedTime")
pub fn elapsed_time(event: AnimationEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "pseudoElement")
pub fn pseudo_element(event: AnimationEvent) -> String

pub fn as_event(event: AnimationEvent) -> Event {
  coerce(event)
}
