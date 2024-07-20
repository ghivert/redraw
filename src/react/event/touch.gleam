import gleam/dynamic
import react/event.{type Event}
import react/event/ui.{type UIEvent}
import react/internals/coerce.{coerce}

pub type TouchEvent

@external(javascript, "../../events.ffi.mjs", "altKey")
pub fn alt_key(event: TouchEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: TouchEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "changedTouches")
pub fn changed_touches(event: TouchEvent) -> dynamic.Dynamic

@external(javascript, "../../events.ffi.mjs", "metaKey")
pub fn meta_key(event: TouchEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "shiftKey")
pub fn shift_key(event: TouchEvent) -> Bool

@external(javascript, "../../events.ffi.mjs", "touches")
pub fn touches(event: TouchEvent) -> dynamic.Dynamic

@external(javascript, "../../events.ffi.mjs", "targetTouches")
pub fn target_touches(event: TouchEvent) -> dynamic.Dynamic

@external(javascript, "../../events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: TouchEvent, key: String) -> Bool

pub fn as_ui_event(event: TouchEvent) -> UIEvent {
  coerce(event)
}

pub fn as_event(event: TouchEvent) -> Event {
  coerce(event)
}
