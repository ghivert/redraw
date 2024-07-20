import gleam/dynamic
import react/event.{type Event}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type MouseEvent

@external(javascript, "../../events.ffi.mjs", "clipboardData")
pub fn clipboard_data(event: MouseEvent) -> dynamic.Dynamic

@external(javascript, "../../events.ffi.mjs", "altKey")
pub fn alt_key(event: MouseEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "button")
pub fn button(event: MouseEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "buttons")
pub fn buttons(event: MouseEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: MouseEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "clientX")
pub fn client_x(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "clientY")
pub fn client_y(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "metaKey")
pub fn meta_key(event: MouseEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "movementX")
pub fn movement_x(event: MouseEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "movementY")
pub fn movement_y(event: MouseEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "pageX")
pub fn page_x(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "pageY")
pub fn page_y(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "relatedTarget")
pub fn related_target(event: MouseEvent) -> dynamic.Dynamic

@external(javascript, "../../events.ffi.mjs", "screenX")
pub fn screen_x(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "screenY")
pub fn screen_y(event: MouseEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "shiftKey")
pub fn shift_key(event: MouseEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: MouseEvent, key: String) -> Bool

pub fn as_ui_event(event: MouseEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: MouseEvent) -> Event {
  coerce(event)
}
