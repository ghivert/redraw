import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

pub type TransitionEvent

@external(javascript, "../../events.ffi.mjs", "elapsedTime")
pub fn elapsed_time(event: TransitionEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "propertyName")
pub fn property_name(event: TransitionEvent) -> String

@external(javascript, "../../events.ffi.mjs", "pseudoElement")
pub fn pseudo_element(event: TransitionEvent) -> String

pub fn as_event(event: TransitionEvent) -> Event {
  coerce(event)
}
