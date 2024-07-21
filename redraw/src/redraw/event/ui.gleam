import gleam/dynamic
import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

pub type UIEvent

@external(javascript, "../../events.ffi.mjs", "detail")
pub fn detail(event: UIEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "view")
pub fn view(event: UIEvent) -> dynamic.Dynamic

pub fn as_event(event: UIEvent) -> Event {
  coerce(event)
}
