import gleam/dynamic
import react/internals/attribute.{Attribute}

pub type Event

@external(javascript, "../events.ffi.mjs", "bubbles")
pub fn bubbles(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "cancelable")
pub fn cancelable(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "currentTarget")
pub fn current_target(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "defaultPrevented")
pub fn default_prevented(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "eventPhase")
pub fn event_phase(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "isTrusted")
pub fn is_trusted(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "target")
pub fn target(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "timeStamp")
pub fn time_stamp(event: Event) -> Bool

pub fn on_click(handler: fn() -> Nil) {
  Attribute("onClick", dynamic.from(handler))
}
