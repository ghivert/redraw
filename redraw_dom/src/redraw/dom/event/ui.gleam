//// The `UIEvent` interface represents simple user interface events.

import gleam/dynamic
import redraw/event.{type Event}
import redraw/internals/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/UIEvent)
pub type UIEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/UIEvent/detail)
@external(javascript, "./events.ffi.mjs", "detail")
pub fn detail(event: UIEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/UIEvent/view)
@external(javascript, "./events.ffi.mjs", "view")
pub fn view(event: UIEvent) -> dynamic.Dynamic

/// `UIEvent` inherits `Event`.
pub const as_event: fn(UIEvent) -> Event = unsafe.coerce
