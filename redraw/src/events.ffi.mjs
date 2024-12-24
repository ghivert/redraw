export function bubbles(event) {
  return event.bubbles
}

export function cancelable(event) {
  return event.cancelable
}

export function currentTarget(event) {
  return event.currentTarget
}

export function defaultPrevented(event) {
  return event.defaultPrevented
}

export function eventPhase(event) {
  return event.eventPhase
}

export function isTrusted(event) {
  return event.isTrusted
}

export function target(event) {
  return event.target
}

export function timeStamp(event) {
  return event.timeStamp
}

export function nativeEvent(event) {
  return event.nativeEvent
}

export function isDefaultPrevented(event) {
  return event.isDefaultPrevented()
}

export function isPropagationStopped(event) {
  return event.isPropagationStopped()
}

export function isPersistent(event) {
  return event.isPersistent()
}

export function preventDefault(event) {
  event.preventDefault()
  return event
}

export function stopPropagation(event) {
  event.stopPropagation()
  return event
}

export function persist(event) {
  event.persist()
  return event
}
