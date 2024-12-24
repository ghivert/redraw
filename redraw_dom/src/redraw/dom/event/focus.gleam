//// The `FocusEvent` interface represents focus-related events, including
//// [`focus`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event),
//// [`blur`](https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event),
//// [`focusin`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event),
//// and [`focusout`](https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event).

import gleam/dynamic
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/FocusEvent)
pub type FocusEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/FocusEvent/relatedTarget)
@external(javascript, "../../../events.ffi.mjs", "relatedTarget")
pub fn related_target(event: FocusEvent) -> dynamic.Dynamic

/// `FocusEvent` inherits `UIEvent`.
pub fn as_ui_event(event: FocusEvent) -> UIEvent {
  coerce(event)
}

/// `FocusEvent` inherits `Event`.
pub fn as_event(event: FocusEvent) -> Event {
  coerce(event)
}
