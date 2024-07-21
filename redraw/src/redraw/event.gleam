import gleam/dynamic

pub type Event

@external(javascript, "../events.ffi.mjs", "bubbles")
pub fn bubbles(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "cancelable")
pub fn cancelable(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "currentTarget")
pub fn current_target(event: Event) -> dynamic.Dynamic

@external(javascript, "../events.ffi.mjs", "defaultPrevented")
pub fn default_prevented(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "eventPhase")
pub fn event_phase(event: Event) -> Int

@external(javascript, "../events.ffi.mjs", "isTrusted")
pub fn is_trusted(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "target")
pub fn target(event: Event) -> dynamic.Dynamic

@external(javascript, "../events.ffi.mjs", "timeStamp")
pub fn time_stamp(event: Event) -> Int

@external(javascript, "../events.ffi.mjs", "nativeEvent")
pub fn native_event(event: Event) -> dynamic.Dynamic

@external(javascript, "../events.ffi.mjs", "preventDefault")
pub fn prevent_default(event: Event) -> Event

@external(javascript, "../events.ffi.mjs", "stopPropagation")
pub fn stop_propagation(event: Event) -> Event

@external(javascript, "../events.ffi.mjs", "persist")
pub fn persist(event: Event) -> Event

@external(javascript, "../events.ffi.mjs", "isDefaultPrevented")
pub fn is_default_prevented(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "isPropagationStopped")
pub fn is_propagation_stopped(event: Event) -> Bool

@external(javascript, "../events.ffi.mjs", "isPersistent")
pub fn is_persistent(event: Event) -> Bool
