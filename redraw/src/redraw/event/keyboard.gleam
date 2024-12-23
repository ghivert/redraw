//// `KeyboardEvent` objects describe a user interaction with the keyboard; each
//// event describes a single interaction between the user and a key (or
//// combination of a key with modifier keys) on the keyboard. The event type
//// ([`keydown`](https://developer.mozilla.org/docs/Web/API/Element/keydown_event),
//// [`keypress`](https://developer.mozilla.org/docs/Web/API/Element/keypress_event),
//// or [`keyup`](https://developer.mozilla.org/docs/Web/API/Element/keyup_event))
//// identifies what kind of keyboard activity occurred.

import redraw/event.{type Event}
import redraw/event/ui.{type UIEvent}
import redraw/internals/coerce.{coerce}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent)
pub type KeyboardEvent

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/altKey)
@external(javascript, "../../events.ffi.mjs", "altKey")
pub fn alt_key(event: KeyboardEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/charCode)
@deprecated("This feature is no longer recommended. Though some browsers might still support it, it may have already been removed from the relevant web standards, may be in the process of being dropped, or may only be kept for compatibility purposes. Do not use this property, as it is deprecated. Instead, get the Unicode value of the character using the key property.")
@external(javascript, "../../events.ffi.mjs", "charCode")
pub fn char_code(event: KeyboardEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/code)
@external(javascript, "../../events.ffi.mjs", "code")
pub fn code(event: KeyboardEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/ctrlKey)
@external(javascript, "../../events.ffi.mjs", "ctrlKey")
pub fn ctrl_key(event: KeyboardEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/key)
@external(javascript, "../../events.ffi.mjs", "key")
pub fn key(event: KeyboardEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/keyCode)
@deprecated("This feature is no longer recommended. Though some browsers might still support it, it may have already been removed from the relevant web standards, may be in the process of being dropped, or may only be kept for compatibility purposes.")
@external(javascript, "../../events.ffi.mjs", "keyCode")
pub fn key_code(event: KeyboardEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/locale)
@external(javascript, "../../events.ffi.mjs", "locale")
pub fn locale(event: KeyboardEvent) -> String

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/metaKey)
@external(javascript, "../../events.ffi.mjs", "metaKey")
pub fn meta_key(event: KeyboardEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/location)
@external(javascript, "../../events.ffi.mjs", "location")
pub fn location(event: KeyboardEvent) -> Float

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/repeat)
@external(javascript, "../../events.ffi.mjs", "repeat")
pub fn repeat(event: KeyboardEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/shiftKey)
@external(javascript, "../../events.ffi.mjs", "shiftKey")
pub fn shift_key(event: KeyboardEvent) -> Bool

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/which)
@deprecated("This feature is no longer recommended. Though some browsers might still support it, it may have already been removed from the relevant web standards, may be in the process of being dropped, or may only be kept for compatibility purposes.")
@external(javascript, "../../events.ffi.mjs", "which")
pub fn which(event: KeyboardEvent) -> Int

/// [Documentation](https://developer.mozilla.org/docs/Web/API/KeyboardEvent/getModifierState)
@external(javascript, "../../events.ffi.mjs", "getModifierState")
pub fn get_modifier_state(event: KeyboardEvent, key: String) -> Bool

/// `KeyboardEvent` inherits `UIEvent`.
pub fn as_ui_event(event: KeyboardEvent) -> UIEvent {
  coerce(event)
}

/// `KeyboardEvent` inherits `Event`.
pub fn as_event(event: KeyboardEvent) -> Event {
  coerce(event)
}
