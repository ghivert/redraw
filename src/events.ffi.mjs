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

export function animationName(event) {
  return event.animationName
}

export function elapsedTime(event) {
  return event.elapsedTime
}

export function pseudoElement(event) {
  return event.pseudoElement
}

export function clipboardData(event) {
  return event.clipboardData
}

export function detail(event) {
  return event.detail
}

export function view(event) {
  return event.view
}

export function dataTransfer(event) {
  return event.dataTransfer
}

export function relatedTarget(event) {
  return event.relatedTarget
}

export function data(event) {
  return event.data
}

export function altKey(event) {
  return event.altKey
}

export function charCode(event) {
  return event.charCode
}

export function code(event) {
  return event.code
}

export function button(event) {
  return event.button
}

export function buttons(event) {
  return event.buttons
}

export function ctrlKey(event) {
  return event.ctrlKey
}

export function clientX(event) {
  return event.clientX
}

export function clientY(event) {
  return event.clientY
}

export function metaKey(event) {
  return event.metaKey
}

export function key(event) {
  return event.key
}

export function keyCode(event) {
  return event.keyCode
}

export function locale(event) {
  return event.locale
}

export function location(event) {
  return event.location
}

export function repeat(event) {
  return event.repeat
}

export function movementX(event) {
  return event.movementX
}

export function movementY(event) {
  return event.movementY
}

export function pageX(event) {
  return event.pageX
}

export function pageY(event) {
  return event.pageY
}

export function relatedTarget(event) {
  return event.relatedTarget
}

export function screenX(event) {
  return event.screenX
}

export function screenY(event) {
  return event.screenY
}

export function shiftKey(event) {
  return event.shiftKey
}

export function which(event) {
  return event.which
}

export function height(event) {
  return event.height
}

export function width(event) {
  return event.width
}

export function isPrimary(event) {
  return event.isPrimary
}

export function pointerId(event) {
  return event.pointerId
}

export function pointerType(event) {
  return event.pointerType
}

export function pressure(event) {
  return event.pressure
}

export function tangentialPressure(event) {
  return event.tangentialPressure
}

export function tiltX(event) {
  return event.tiltX
}

export function tiltY(event) {
  return event.tiltY
}

export function twist(event) {
  return event.twist
}

export function changedTouches(event) {
  return event.changedTouches
}

export function touches(event) {
  return event.touches
}

export function targetTouches(event) {
  return event.targetTouches
}

export function propertyName(event) {
  return event.propertyName
}

export function deltaMode(event) {
  return event.deltaMode
}

export function deltaX(event) {
  return event.deltaX
}

export function deltaY(event) {
  return event.deltaY
}

export function deltaZ(event) {
  return event.deltaZ
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

export function getModifierState(event, key) {
  return event.getModifierState(key)
}
