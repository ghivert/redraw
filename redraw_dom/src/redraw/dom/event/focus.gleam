//// The `FocusEvent` interface represents focus-related events, including
//// [`focus`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event),
//// [`blur`](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event),
//// [`focusin`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event),
//// and [`focusout`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event).

import gleam/dynamic
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internals/unsafe

/// [Documentation](https://developer.mozilla.org/docs/Web/API/FocusEvent)
pub type FocusEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/FocusEvent/relatedTarget)
@external(javascript, "./events.ffi.mjs", "relatedTarget")
pub fn related_target(event: FocusEvent) -> dynamic.Dynamic

/// `FocusEvent` inherits `UIEvent`.
pub const as_ui_event: fn(FocusEvent) -> UIEvent = unsafe.coerce

/// `FocusEvent` inherits `Event`.
pub const as_event: fn(FocusEvent) -> Event = unsafe.coerce
