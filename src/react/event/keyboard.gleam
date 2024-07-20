import react/event.{type Event}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type KeyboardEvent

@external(javascript, "../../events.ffi.mjs", "altKey")
pub fn alt_key(event: KeyboardEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "charCode")
pub fn char_code(event: KeyboardEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "code")
pub fn code(event: KeyboardEvent) -> String

@external(javascript, "../../events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: KeyboardEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "key")
pub fn key(event: KeyboardEvent) -> String

@external(javascript, "../../events.ffi.mjs", "keyCode")
pub fn key_code(event: KeyboardEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "locale")
pub fn locale(event: KeyboardEvent) -> String

@external(javascript, "../../events.ffi.mjs", "metaKey")
pub fn meta_key(event: KeyboardEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "location")
pub fn location(event: KeyboardEvent) -> Float

@external(javascript, "../../events.ffi.mjs", "repeat")
pub fn repeat(event: KeyboardEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "shiftKey")
pub fn shift_key(event: KeyboardEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "which")
pub fn which(event: KeyboardEvent) -> Int

@external(javascript, "../../events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: KeyboardEvent, key: String) -> Bool

pub fn as_ui_event(event: KeyboardEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: KeyboardEvent) -> Event {
  coerce(event)
}
