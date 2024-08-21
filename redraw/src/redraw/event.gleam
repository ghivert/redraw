import gleam/dynamic

/// Synthetic Event sent by React.
/// It conforms to the same standard as the underlying DOM events, but fixes some browser inconsistencies.
///
/// [Documentation](https://react.dev/reference/react-dom/components/common#react-event-object)
pub type Event

/// Returns whether the event bubbles through the DOM.
@external(javascript, "../events.ffi.mjs", "bubbles")
pub fn bubbles(event: Event) -> Bool

/// Returns whether the event can be canceled.
@external(javascript, "../events.ffi.mjs", "cancelable")
pub fn cancelable(event: Event) -> Bool

/// Returns the node to which the current handler is attached in the React tree.
@external(javascript, "../events.ffi.mjs", "currentTarget")
pub fn current_target(event: Event) -> dynamic.Dynamic

/// Returns whether `prevent_default` was called.
@external(javascript, "../events.ffi.mjs", "defaultPrevented")
pub fn default_prevented(event: Event) -> Bool

/// Returns which phase the event is currently in.
@external(javascript, "../events.ffi.mjs", "eventPhase")
pub fn event_phase(event: Event) -> Int

/// Returns whether the event was initiated by user.
@external(javascript, "../events.ffi.mjs", "isTrusted")
pub fn is_trusted(event: Event) -> Bool

/// Returns the node on which the event has occurred (which could be a distant child).
@external(javascript, "../events.ffi.mjs", "target")
pub fn target(event: Event) -> dynamic.Dynamic

/// Returns the time when the event occurred.
@external(javascript, "../events.ffi.mjs", "timeStamp")
pub fn time_stamp(event: Event) -> Int

/// The original browser event object.
@external(javascript, "../events.ffi.mjs", "nativeEvent")
pub fn native_event(event: Event) -> dynamic.Dynamic

/// Prevents the default browser action for the event.
@external(javascript, "../events.ffi.mjs", "preventDefault")
pub fn prevent_default(event: Event) -> Event

/// Stops the event propagation through the React tree.
@external(javascript, "../events.ffi.mjs", "stopPropagation")
pub fn stop_propagation(event: Event) -> Event

/// Returns a boolean value indicating whether `prevent_default` was called.
@external(javascript, "../events.ffi.mjs", "isDefaultPrevented")
pub fn is_default_prevented(event: Event) -> Bool

/// Returns a boolean value indicating whether `stop_propagation` was called.
@external(javascript, "../events.ffi.mjs", "isPropagationStopped")
pub fn is_propagation_stopped(event: Event) -> Bool

/// Not used with React DOM. With React Native, call this to read event’s properties after the event.
@external(javascript, "../events.ffi.mjs", "persist")
pub fn persist(event: Event) -> Event

/// Not used with React DOM. With React Native, returns whether persist has been called.
@external(javascript, "../events.ffi.mjs", "isPersistent")
pub fn is_persistent(event: Event) -> Bool
