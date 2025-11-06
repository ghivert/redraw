export const bubbles = (event) => event.bubbles
export const cancelable = (event) => event.cancelable
export const currentTarget = (event) => event.currentTarget
export const defaultPrevented = (event) => event.defaultPrevented
export const eventPhase = (event) => event.eventPhase
export const isTrusted = (event) => event.isTrusted
export const target = (event) => event.target
export const timeStamp = (event) => event.timeStamp
export const nativeEvent = (event) => event.nativeEvent
export const isDefaultPrevented = (event) => event.isDefaultPrevented()
export const isPropagationStopped = (event) => event.isPropagationStopped()
export const isPersistent = (event) => event.isPersistent()

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
