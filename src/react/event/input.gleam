import react/event.{type Event}
import react/internals/coerce.{coerce}

pub type InputEvent

@external(javascript, "../../events.ffi.mjs", "data")
pub fn data(event: InputEvent) -> String

pub fn as_event(event: InputEvent) -> Event {
  coerce(event)
}
