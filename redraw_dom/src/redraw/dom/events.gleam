//// Event listeners usable in React and in browser. \
//// All of them can be found in the
//// [React.dev](https://react.dev/reference/react-dom/components/common#common)
//// documentation for detailed information, as well as on
//// [MDN](https://developer.mozilla.org/docs/Web/API/Element).
////
//// Every event listener are defined as handlers, accepting an event, detailed
//// in their documentation.

import redraw/dom/attribute
import redraw/dom/event/animation.{type AnimationEvent}
import redraw/dom/event/clipboard.{type ClipboardEvent}
import redraw/dom/event/composition.{type CompositionEvent}
import redraw/dom/event/drag.{type DragEvent}
import redraw/dom/event/focus.{type FocusEvent}
import redraw/dom/event/input.{type InputEvent}
import redraw/dom/event/keyboard.{type KeyboardEvent}
import redraw/dom/event/mouse.{type MouseEvent}
import redraw/dom/event/pointer.{type PointerEvent}
import redraw/dom/event/touch.{type TouchEvent}
import redraw/dom/event/transition.{type TransitionEvent}
import redraw/dom/event/wheel.{type WheelEvent}
import redraw/event.{type Event}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationend_event)
pub fn on_animation_end(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationEnd", handler)
}

/// Alternative version of [`on_animation_end`](#on_animation_end) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationend_event)
pub fn on_animation_end_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationEndCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationiteration_event)
pub fn on_animation_iteration(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationIteration", handler)
}

/// Alternative version of [`on_animation_iteration`](#on_animation_iteration) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationiteration_event)
pub fn on_animation_iteration_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationIterationCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationstart_event)
pub fn on_animation_start(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationStart", handler)
}

/// Alternative version of [`on_animation_start`](#on_animation_start) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/animationstart_event)
pub fn on_animation_start_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationStartCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/auxclick_event)
pub fn on_aux_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onAuxClick", handler)
}

/// Alternative version of [`on_aux_click`](#on_aux_click) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/auxclick_event)
pub fn on_aux_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onAuxClickCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/beforeinput_event)
pub fn on_before_input(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onBeforeInput", handler)
}

/// Alternative version of [`on_before_input`](#on_before_input) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/beforeinput_event)
pub fn on_before_input_capture(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onBeforeInputCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/blur_event)
pub fn on_blur(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onBlur", handler)
}

/// Alternative version of [`on_blur`](#on_blur) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/blur_event)
pub fn on_blur_capture(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onBlurCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/input_event)
pub fn on_change(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onChange", handler)
}

/// Alternative version of [`on_change`](#on_change) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/input_event)
pub fn on_change_capture(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onChangeCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/click_event)
pub fn on_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onClick", handler)
}

/// Alternative version of [`on_click`](#on_click) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/click_event)
pub fn on_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onClickCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionstart_event)
pub fn on_composition_start(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionStart", handler)
}

/// Alternative version of [`on_composition_start`](#on_composition_start) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionstart_event)
pub fn on_composition_start_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionStartCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionend_event)
pub fn on_composition_end(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionEnd", handler)
}

/// Alternative version of [`on_composition_end`](#on_composition_end) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionend_event)
pub fn on_composition_end_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionEndCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionupdate_event)
pub fn on_composition_update(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionUpdate", handler)
}

/// Alternative version of [`on_composition_update`](#on_composition_update) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/compositionupdate_event)
pub fn on_composition_update_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionUpdateCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/context_event)
pub fn on_context_menu(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onContextMenu", handler)
}

/// Alternative version of [`on_context_menu`](#on_context_menu) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/context_event)
pub fn on_context_menu_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onContextMenuCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/copy_event)
pub fn on_copy(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCopy", handler)
}

/// Alternative version of [`on_copy`](#on_copy) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/copy_event)
pub fn on_copy_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCopyCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/cut_event)
pub fn on_cut(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCut", handler)
}

/// Alternative version of [`on_cut`](#on_cut) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/cut_event)
pub fn on_cut_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCutCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/dblclick_event)
pub fn on_double_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onDoubleClick", handler)
}

/// Alternative version of [`on_double_click`](#on_double_click) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/dblclick_event)
pub fn on_double_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onDoubleClickCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/drag_event)
pub fn on_drag(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDrag", handler)
}

/// Alternative version of [`on_drag`](#on_drag) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/drag_event)
pub fn on_drag_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragend_event)
pub fn on_drag_end(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnd", handler)
}

/// Alternative version of [`on_drag_end`](#on_drag_end) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragend_event)
pub fn on_drag_end_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEndCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragenter_event)
pub fn on_drag_enter(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnter", handler)
}

/// Alternative version of [`on_drag_enter`](#on_drag_enter) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragenter_event)
pub fn on_drag_enter_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnterCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragover_event)
pub fn on_drag_over(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragOver", handler)
}

/// Alternative version of [`on_drag_over`](#on_drag_over) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragover_event)
pub fn on_drag_over_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragOverCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragstart_event)
pub fn on_drag_start(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragStart", handler)
}

/// Alternative version of [`on_drag_start`](#on_drag_start) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragstart_event)
pub fn on_drag_start_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragStartCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragleave_event)
pub fn on_drag_leave(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragLeave", handler)
}

/// Alternative version of [`on_drag_leave`](#on_drag_leave) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLElement/dragleave_event)
pub fn on_drag_leave_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragLeaveCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/drop_event)
pub fn on_drop(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDrop", handler)
}

/// Alternative version of [`on_drop`](#on_drop) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/drop_event)
pub fn on_drop_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDropCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/focus_event)
pub fn on_focus(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onFocus", handler)
}

/// Alternative version of [`on_focus`](#on_focus) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/focus_event)
pub fn on_focus_capture(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onFocusCapture", handler)
}

/// Alternative version of [`on_got_pointer`](#on_got_pointer) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/gotpointercapture_event)
pub fn on_got_pointer_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onGotPointerCapture", handler)
}

/// Alternative version of [`on_got_pointer_capture`](#on_got_pointer_capture) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/gotpointercapture_event)
pub fn on_got_pointer_capture_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onGotPointerCaptureCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/input_event)
pub fn on_input(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onInput", handler)
}

/// Alternative version of [`on_input`](#on_input) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/input_event)
pub fn on_input_capture(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onInputCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keydown_event)
pub fn on_key_down(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyDown", handler)
}

/// Alternative version of [`on_key_down`](#on_key_down) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keydown_event)
pub fn on_key_down_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyDownCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keypress_event)
pub fn on_key_press(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyPress", handler)
}

/// Alternative version of [`on_key_press`](#on_key_press) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keypress_event)
pub fn on_key_press_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyPressCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keyup_event)
pub fn on_key_up(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyUp", handler)
}

/// Alternative version of [`on_key_up`](#on_key_up) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/keyup_event)
pub fn on_key_up_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyUpCapture", handler)
}

/// Alternative version of [`on_lost_pointer`](#on_lost_pointer) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/lostpointercapture_event)
pub fn on_lost_pointer_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onLostPointerCapture", handler)
}

/// Alternative version of [`on_lost_pointer_capture`](#on_lost_pointer_capture) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/lostpointercapture_event)
pub fn on_lost_pointer_capture_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onLostPointerCaptureCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mousedown_event)
pub fn on_mouse_down(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseDown", handler)
}

/// Alternative version of [`on_mouse_down`](#on_mouse_down) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mousedown_event)
pub fn on_mouse_down_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseDownCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseenter_event)
pub fn on_mouse_enter(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseEnter", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseleave_event)
pub fn on_mouse_leave(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseLeave", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mousemove_event)
pub fn on_mouse_move(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseMove", handler)
}

/// Alternative version of [`on_mouse_move`](#on_mouse_move) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mousemove_event)
pub fn on_mouse_move_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseMoveCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseout_event)
pub fn on_mouse_out(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseOut", handler)
}

/// Alternative version of [`on_mouse_out`](#on_mouse_out) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseout_event)
pub fn on_mouse_out_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseOutCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseup_event)
pub fn on_mouse_up(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseUp", handler)
}

/// Alternative version of [`on_mouse_up`](#on_mouse_up) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/mouseup_event)
pub fn on_mouse_up_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseUpCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointercancel_event)
pub fn on_pointer_cancel(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerCancel", handler)
}

/// Alternative version of [`on_pointer_cancel`](#on_pointer_cancel) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointercancel_event)
pub fn on_pointer_cancel_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerCancelCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerdown_event)
pub fn on_pointer_down(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerDown", handler)
}

/// Alternative version of [`on_pointer_down`](#on_pointer_down) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerdown_event)
pub fn on_pointer_down_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerDownCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerenter_event)
pub fn on_pointer_enter(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerEnter", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerleave_event)
pub fn on_pointer_leave(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerLeave", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointermove_event)
pub fn on_pointer_move(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerMove", handler)
}

/// Alternative version of [`on_pointer_move`](#on_pointer_move) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointermove_event)
pub fn on_pointer_move_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerMoveCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerout_event)
pub fn on_pointer_out(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerOut", handler)
}

/// Alternative version of [`on_pointer_out`](#on_pointer_out) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerout_event)
pub fn on_pointer_out_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerOutCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerup_event)
pub fn on_pointer_up(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerUp", handler)
}

/// Alternative version of [`on_pointer_up`](#on_pointer_up) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pointerup_event)
pub fn on_pointer_up_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerUpCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/paste_event)
pub fn on_paste(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onPaste", handler)
}

/// Alternative version of [`on_paste`](#on_paste) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/paste_event)
pub fn on_paste_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onPasteCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/scroll_event)
pub fn on_scroll(handler: fn(Event) -> Nil) {
  attribute.attribute("onScroll", handler)
}

/// Alternative version of [`on_scroll`](#on_scroll) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/scroll_event)
pub fn on_scroll_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onScrollCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/select_event)
pub fn on_select(handler: fn(Event) -> Nil) {
  attribute.attribute("onSelect", handler)
}

/// Alternative version of [`on_select`](#on_select) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/select_event)
pub fn on_select_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSelectCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchcancel_event)
pub fn on_touch_cancel(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchCancel", handler)
}

/// Alternative version of [`on_touch_cancel`](#on_touch_cancel) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchcancel_event)
pub fn on_touch_cancel_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchCancelCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchend_event)
pub fn on_touch_end(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchEnd", handler)
}

/// Alternative version of [`on_touch_end`](#on_touch_end) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchend_event)
pub fn on_touch_end_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchEndCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchmove_event)
pub fn on_touch_move(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchMove", handler)
}

/// Alternative version of [`on_touch_move`](#on_touch_move) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchmove_event)
pub fn on_touch_move_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchMoveCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchstart_event)
pub fn on_touch_start(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchStart", handler)
}

/// Alternative version of [`on_touch_start`](#on_touch_start) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/touchstart_event)
pub fn on_touch_start_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchStartCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/transitionend_event)
pub fn on_transition_end(handler: fn(TransitionEvent) -> Nil) {
  attribute.attribute("onTransitionEnd", handler)
}

/// Alternative version of [`on_transition_end`](#on_transition_end) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/transitionend_event)
pub fn on_transition_end_capture(handler: fn(TransitionEvent) -> Nil) {
  attribute.attribute("onTransitionEndCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/wheel_event)
pub fn on_wheel(handler: fn(WheelEvent) -> Nil) {
  attribute.attribute("onWheel", handler)
}

/// Alternative version of [`on_wheel`](#on_wheel) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/wheel_event)
pub fn on_wheel_capture(handler: fn(WheelEvent) -> Nil) {
  attribute.attribute("onWheelCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/reset_event)
pub fn on_reset(handler: fn(Event) -> Nil) {
  attribute.attribute("onReset", handler)
}

/// Alternative version of [`on_reset`](#on_reset) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/reset_event)
pub fn on_reset_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onResetCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/submit_event)
pub fn on_submit(handler: fn(Event) -> Nil) {
  attribute.attribute("onSubmit", handler)
}

/// Alternative version of [`on_submit`](#on_submit) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/submit_event)
pub fn on_submit_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSubmitCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/cancel_event)
pub fn on_cancel(handler: fn(Event) -> Nil) {
  attribute.attribute("onCancel", handler)
}

/// Alternative version of [`on_cancel`](#on_cancel) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/cancel_event)
pub fn on_cancel_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onCancelCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/close_event)
pub fn on_close(handler: fn(Event) -> Nil) {
  attribute.attribute("onClose", handler)
}

/// Alternative version of [`on_close`](#on_close) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/close_event)
pub fn on_close_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onCloseCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/toggle_event)
pub fn on_toggle(handler: fn(Event) -> Nil) {
  attribute.attribute("onToggle", handler)
}

/// Alternative version of [`on_toggle`](#on_toggle) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/toggle_event)
pub fn on_toggle_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onToggleCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/load_event)
pub fn on_load(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoad", handler)
}

/// Alternative version of [`on_load`](#on_load) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/load_event)
pub fn on_load_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/error_event)
pub fn on_error(handler: fn(Event) -> Nil) {
  attribute.attribute("onError", handler)
}

/// Alternative version of [`on_error`](#on_error) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/error_event)
pub fn on_error_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onErrorCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/abort_event)
pub fn on_abort(handler: fn(Event) -> Nil) {
  attribute.attribute("onAbort", handler)
}

/// Alternative version of [`on_abort`](#on_abort) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/abort_event)
pub fn on_abort_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onAbortCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/canplay_event)
pub fn on_can_play(handler: fn(Event) -> Nil) {
  attribute.attribute("onCanPlay", handler)
}

/// Alternative version of [`on_can_play`](#on_can_play) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/canplay_event)
pub fn on_can_play_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/canplaythrough_event)
pub fn on_can_play_through(handler: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayThrough", handler)
}

/// Alternative version of [`on_can_play_through`](#on_can_play_through) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/canplaythrough_event)
pub fn on_can_play_through_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayThroughCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/durationchange_event)
pub fn on_duration_change(handler: fn(Event) -> Nil) {
  attribute.attribute("onDurationChange", handler)
}

/// Alternative version of [`on_duration_change`](#on_duration_change) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/durationchange_event)
pub fn on_duration_change_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onDurationChangeCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/emptied_event)
pub fn on_emptied(handler: fn(Event) -> Nil) {
  attribute.attribute("onEmptied", handler)
}

/// Alternative version of [`on_emptied`](#on_emptied) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/emptied_event)
pub fn on_emptied_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onEmptiedCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/encrypted_event)
pub fn on_encrypted(handler: fn(Event) -> Nil) {
  attribute.attribute("onEncrypted", handler)
}

/// Alternative version of [`on_encrypted`](#on_encrypted) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/encrypted_event)
pub fn on_encrypted_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onEncryptedCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/ended_event)
pub fn on_ended(handler: fn(Event) -> Nil) {
  attribute.attribute("onEnded", handler)
}

/// Alternative version of [`on_ended`](#on_ended) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/ended_event)
pub fn on_ended_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onEndedCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadeddata_event)
pub fn on_loaded_data(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadedData", handler)
}

/// Alternative version of [`on_loaded_data`](#on_loaded_data) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadeddata_event)
pub fn on_loaded_data_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadedDataCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadedmetadata_event)
pub fn on_loaded_metadata(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadedMetadata", handler)
}

/// Alternative version of [`on_loaded_metadata`](#on_loaded_metadata) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadedmetadata_event)
pub fn on_loaded_metadata_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadedMetadataCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadstart_event)
pub fn on_load_start(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadStart", handler)
}

/// Alternative version of [`on_load_start`](#on_load_start) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/loadstart_event)
pub fn on_load_start_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onLoadStartCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pause_event)
pub fn on_pause(handler: fn(Event) -> Nil) {
  attribute.attribute("onPause", handler)
}

/// Alternative version of [`on_pause`](#on_pause) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/pause_event)
pub fn on_pause_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onPauseCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/play_event)
pub fn on_play(handler: fn(Event) -> Nil) {
  attribute.attribute("onPlay", handler)
}

/// Alternative version of [`on_play`](#on_play) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/play_event)
pub fn on_play_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onPlayCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/playing_event)
pub fn on_playing(handler: fn(Event) -> Nil) {
  attribute.attribute("onPlaying", handler)
}

/// Alternative version of [`on_playing`](#on_playing) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/playing_event)
pub fn on_playing_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onPlayingCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/progress_event)
pub fn on_progress(handler: fn(Event) -> Nil) {
  attribute.attribute("onProgress", handler)
}

/// Alternative version of [`on_progress`](#on_progress) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/progress_event)
pub fn on_progress_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onProgressCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/ratechange_event)
pub fn on_rate_change(handler: fn(Event) -> Nil) {
  attribute.attribute("onRateChange", handler)
}

/// Alternative version of [`on_rate_change`](#on_rate_change) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/ratechange_event)
pub fn on_rate_change_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onRateChangeCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/resize_event)
pub fn on_resize(handler: fn(Event) -> Nil) {
  attribute.attribute("onResize", handler)
}

/// Alternative version of [`on_resize`](#on_resize) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/resize_event)
pub fn on_resize_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onResizeCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/seeked_event)
pub fn on_seeked(handler: fn(Event) -> Nil) {
  attribute.attribute("onSeeked", handler)
}

/// Alternative version of [`on_seeked`](#on_seeked) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/seeked_event)
pub fn on_seeked_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSeekedCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/seeking_event)
pub fn on_seeking(handler: fn(Event) -> Nil) {
  attribute.attribute("onSeeking", handler)
}

/// Alternative version of [`on_seeking`](#on_seeking) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/seeking_event)
pub fn on_seeking_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSeekingCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/stalled_event)
pub fn on_stalled(handler: fn(Event) -> Nil) {
  attribute.attribute("onStalled", handler)
}

/// Alternative version of [`on_stalled`](#on_stalled) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/stalled_event)
pub fn on_stalled_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onStalledCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/suspend_event)
pub fn on_suspend(handler: fn(Event) -> Nil) {
  attribute.attribute("onSuspend", handler)
}

/// Alternative version of [`on_suspend`](#on_suspend) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/suspend_event)
pub fn on_suspend_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSuspendCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/timeupdate_event)
pub fn on_time_update(handler: fn(Event) -> Nil) {
  attribute.attribute("onTimeUpdate", handler)
}

/// Alternative version of [`on_time_update`](#on_time_update) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/Element/timeupdate_event)
pub fn on_time_update_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onTimeUpdateCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/volumechange_event)
pub fn on_volume_change(handler: fn(Event) -> Nil) {
  attribute.attribute("onVolumeChange", handler)
}

/// Alternative version of [`on_volume_change`](#on_volume_change) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Element/volumechange_event)
pub fn on_volume_change_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onVolumeChangeCapture", handler)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/waiting_event)
pub fn on_waiting(handler: fn(Event) -> Nil) {
  attribute.attribute("onWaiting", handler)
}

/// Alternative version of [`on_waiting`](#on_waiting) that runs during
/// [capture phase](https://react.dev/learn/responding-to-events#capture-phase-events). \
/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/waiting_event)
pub fn on_waiting_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onWaitingCapture", handler)
}

/// `none` will not appear in HTML attributes. Use it for conditional rendering.
pub const none = attribute.none
