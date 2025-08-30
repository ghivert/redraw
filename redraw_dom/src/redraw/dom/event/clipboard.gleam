//// The `ClipboardEvent` interface of the [Clipboard API](https://developer.mozilla.org/docs/Web/API/Clipboard_API) represents events
//// providing information related to modification of the clipboard, that is
//// [`cut`](https://developer.mozilla.org/docs/Web/API/Element/cut_event),
//// [`copy`](https://developer.mozilla.org/docs/Web/API/Element/cut_event), and
//// [`paste`](https://developer.mozilla.org/docs/Web/API/Element/cut_event) events.

import gleam/dynamic
import redraw/event.{type Event}
import redraw/internals/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/ClipboardEvent)
pub type ClipboardEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/ClipboardEvent/clipboardData)
@external(javascript, "./events.ffi.mjs", "clipboardData")
pub fn clipboard_data(event: ClipboardEvent) -> dynamic.Dynamic

/// `ClipboardEvent` inherits `Event`.
pub const as_event: fn(ClipboardEvent) -> Event = unsafe.coerce
