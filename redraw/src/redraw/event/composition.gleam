import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

pub type CompositionEvent

@external(javascript, "../../events.ffi.mjs", "data")
pub fn data(event: CompositionEvent) -> String

pub fn as_event(event: CompositionEvent) -> Event {
  coerce(event)
}
