//// The `MouseEvent` interface represents events that occur due to the user
//// interacting with a pointing device (such as a mouse). Common events using
//// this interface include [`click`](https://developer.mozilla.org/docs/Web/API/Element/click_event),
//// [`dblclick`](https://developer.mozilla.org/docs/Web/API/Element/dblclick_event),
//// [`mouseup`](https://developer.mozilla.org/docs/Web/API/Element/mouseup_event),
//// [`mousedown`](https://developer.mozilla.org/docs/Web/API/Element/mousedown_event).

import gleam/dynamic
import redraw/dom/event/ui.{type UIEvent}
import redraw/event.{type Event}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent)
pub type MouseEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/altKey)
@external(javascript, "./events.ffi.mjs", "altKey")
pub fn alt_key(event: MouseEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/button)
@external(javascript, "./events.ffi.mjs", "button")
pub fn button(event: MouseEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/buttons)
@external(javascript, "./events.ffi.mjs", "buttons")
pub fn buttons(event: MouseEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/ctrlKey)
@external(javascript, "./events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: MouseEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/clientX)
@external(javascript, "./events.ffi.mjs", "clientX")
pub fn client_x(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/clientY)
@external(javascript, "./events.ffi.mjs", "clientY")
pub fn client_y(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/metaKey)
@external(javascript, "./events.ffi.mjs", "metaKey")
pub fn meta_key(event: MouseEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/movementX)
@external(javascript, "./events.ffi.mjs", "movementX")
pub fn movement_x(event: MouseEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/movementY)
@external(javascript, "./events.ffi.mjs", "movementY")
pub fn movement_y(event: MouseEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/pageX)
@external(javascript, "./events.ffi.mjs", "pageX")
pub fn page_x(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/pageY)
@external(javascript, "./events.ffi.mjs", "pageY")
pub fn page_y(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/offsetX)
@external(javascript, "./events.ffi.mjs", "offsetX")
pub fn offset_x(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/offsetY)
@external(javascript, "./events.ffi.mjs", "offsetY")
pub fn offset_y(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/relatedTarget)
@external(javascript, "./events.ffi.mjs", "relatedTarget")
pub fn related_target(event: MouseEvent) -> dynamic.Dynamic

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/screenX)
@external(javascript, "./events.ffi.mjs", "screenX")
pub fn screen_x(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/screenY)
@external(javascript, "./events.ffi.mjs", "screenY")
pub fn screen_y(event: MouseEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/shiftKey)
@external(javascript, "./events.ffi.mjs", "shiftKey")
pub fn shift_key(event: MouseEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/MouseEvent/getModifierState)
@external(javascript, "./events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: MouseEvent, key: String) -> Bool

/// `MouseEvent` inherits `UIEvent`.
pub fn as_ui_event(event: MouseEvent) -> UIEvent {
  coerce(event)
}

/// `MouseEvent` inherits `Event`.
pub fn as_event(event: MouseEvent) -> Event {
  coerce(event)
}
