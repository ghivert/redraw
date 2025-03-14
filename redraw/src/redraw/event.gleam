//// Event handlers will receive a React event object. It is also sometimes
//// known as a “synthetic event”.
////
//// ```gleam
//// import redraw/dom/events
//// import redraw/dom/html
////
//// pub fn render() {
////   html.button(
////     [
////       events.on_click(fn (event) {
////         io.debug(event) // React Event
////       })
////     ],
////     [html.text("Exampe")]
////   )
//// }
//// ```
////
//// It conforms to the same standard as the underlying DOM events, but fixes
//// some browser inconsistencies.
////
//// Some React events do not map directly to the browser’s native events.
//// For example in `on_mouse_leave`, `event.native_event(event)` will point to a
//// `MouseEvent` event.
//// The specific mapping is not part of the public API and may change in the
//// future. If you need the underlying browser event for some reason, read it
//// from `event.native_event(event)`.
////
//// Every events have their implementation as `redraw/dom/event/[event_name]`, and
//// their corresponding functions are implemented in those. Every time you need
//// to use one of the functions defined here, use `to_event` from the
//// corresponding module.
////
//// [Documentation](https://react.dev/reference/react-dom/components/common#react-event-object)

import gleam/dynamic/decode

/// Synthetic Event sent by React.
/// It conforms to the same standard as the underlying DOM events, but
/// fixes some browser inconsistencies. \
/// [Documentation](https://react.dev/reference/react-dom/components/common#react-event-object)
pub type Event

/// Returns whether the event bubbles through the DOM. \
/// [Documetation](https://developer.mozilla.org/docs/Web/API/Event/bubbles)
@external(javascript, "../events.ffi.mjs", "bubbles")
pub fn bubbles(event: Event) -> Bool

/// Returns whether the event can be canceled. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/cancelable)
@external(javascript, "../events.ffi.mjs", "cancelable")
pub fn cancelable(event: Event) -> Bool

/// Returns the node to which the current handler is attached in the React tree. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/currentTarget)
@external(javascript, "../events.ffi.mjs", "currentTarget")
pub fn current_target(event: Event) -> decode.Dynamic

/// Returns whether `prevent_default` was called. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/defaultPrevented)
@external(javascript, "../events.ffi.mjs", "defaultPrevented")
pub fn default_prevented(event: Event) -> Bool

/// Returns which phase the event is currently in. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/eventPhase)
@external(javascript, "../events.ffi.mjs", "eventPhase")
pub fn event_phase(event: Event) -> Int

/// Returns whether the event was initiated by user. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/isTrusted)
@external(javascript, "../events.ffi.mjs", "isTrusted")
pub fn is_trusted(event: Event) -> Bool

/// Returns the node on which the event has occurred (which could be a distant child). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/target)
@external(javascript, "../events.ffi.mjs", "target")
pub fn target(event: Event) -> decode.Dynamic

/// Returns the time when the event occurred. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/timeStamp)
@external(javascript, "../events.ffi.mjs", "timeStamp")
pub fn time_stamp(event: Event) -> Int

/// The original browser event object. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event)
@external(javascript, "../events.ffi.mjs", "nativeEvent")
pub fn native_event(event: Event) -> decode.Dynamic

/// Prevents the default browser action for the event. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/preventDefault)
@external(javascript, "../events.ffi.mjs", "preventDefault")
pub fn prevent_default(event: Event) -> Event

/// Stops the event propagation through the React tree. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Event/stopPropagation)
@external(javascript, "../events.ffi.mjs", "stopPropagation")
pub fn stop_propagation(event: Event) -> Event

/// Returns a boolean value indicating whether `prevent_default` was called. \
/// React addition, does not exist in standard browsers.
@external(javascript, "../events.ffi.mjs", "isDefaultPrevented")
pub fn is_default_prevented(event: Event) -> Bool

/// Returns a boolean value indicating whether `stop_propagation` was called.
/// React addition, does not exist in standard browsers.
@external(javascript, "../events.ffi.mjs", "isPropagationStopped")
pub fn is_propagation_stopped(event: Event) -> Bool

/// Not used with React DOM. With React Native, call this to read event’s properties after the event. \
/// React addition, does not exist in standard browsers.
@external(javascript, "../events.ffi.mjs", "persist")
pub fn persist(event: Event) -> Event

/// Not used with React DOM. With React Native, returns whether persist has been called. \
/// React addition, does not exist in standard browsers.
@external(javascript, "../events.ffi.mjs", "isPersistent")
pub fn is_persistent(event: Event) -> Bool
