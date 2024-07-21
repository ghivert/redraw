import redraw/event.{type Event}
import redraw/event/animation.{type AnimationEvent}
import redraw/event/clipboard.{type ClipboardEvent}
import redraw/event/composition.{type CompositionEvent}
import redraw/event/drag.{type DragEvent}
import redraw/event/focus.{type FocusEvent}
import redraw/event/input.{type InputEvent}
import redraw/event/keyboard.{type KeyboardEvent}
import redraw/event/mouse.{type MouseEvent}
import redraw/event/pointer.{type PointerEvent}
import redraw/event/touch.{type TouchEvent}
import redraw/event/transition.{type TransitionEvent}
import redraw/event/wheel.{type WheelEvent}
import redraw/internals/attribute

pub fn on_animation_end(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationEnd", handler)
}

pub fn on_animation_end_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationEndCapture", handler)
}

pub fn on_animation_iteration(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationIteration", handler)
}

pub fn on_animation_iteration_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationIterationCapture", handler)
}

pub fn on_animation_start(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationStart", handler)
}

pub fn on_animation_start_capture(handler: fn(AnimationEvent) -> Nil) {
  attribute.attribute("onAnimationStartCapture", handler)
}

pub fn on_aux_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onAuxClick", handler)
}

pub fn on_aux_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onAuxClickCapture", handler)
}

pub fn on_before_input(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onBeforeInput", handler)
}

pub fn on_before_input_capture(handler: fn(InputEvent) -> Nil) {
  attribute.attribute("onBeforeInputCapture", handler)
}

pub fn on_blur(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onBlur", handler)
}

pub fn on_blur_capture(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onBlurCapture", handler)
}

pub fn on_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onClick", handler)
}

pub fn on_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onClickCapture", handler)
}

pub fn on_composition_start(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionStart", handler)
}

pub fn on_composition_start_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionStartCapture", handler)
}

pub fn on_composition_end(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionEnd", handler)
}

pub fn on_composition_end_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionEndCapture", handler)
}

pub fn on_composition_update(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionUpdate", handler)
}

pub fn on_composition_update_capture(handler: fn(CompositionEvent) -> Nil) {
  attribute.attribute("onCompositionUpdateCapture", handler)
}

pub fn on_context_menu(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onContextMenu", handler)
}

pub fn on_context_menu_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onContextMenuCapture", handler)
}

pub fn on_copy(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCopy", handler)
}

pub fn on_copy_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCopyCapture", handler)
}

pub fn on_cut(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCut", handler)
}

pub fn on_cut_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onCutCapture", handler)
}

pub fn on_double_click(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onDoubleClick", handler)
}

pub fn on_double_click_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onDoubleClickCapture", handler)
}

pub fn on_drag(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDrag", handler)
}

pub fn on_drag_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragCapture", handler)
}

pub fn on_drag_end(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnd", handler)
}

pub fn on_drag_end_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEndCapture", handler)
}

pub fn on_drag_enter(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnter", handler)
}

pub fn on_drag_enter_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragEnterCapture", handler)
}

pub fn on_drag_over(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragOver", handler)
}

pub fn on_drag_over_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragOverCapture", handler)
}

pub fn on_drag_start(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragStart", handler)
}

pub fn on_drag_start_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDragStartCapture", handler)
}

pub fn on_drop(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDrop", handler)
}

pub fn on_drop_capture(handler: fn(DragEvent) -> Nil) {
  attribute.attribute("onDropCapture", handler)
}

pub fn on_focus(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onFocus", handler)
}

pub fn on_focus_capture(handler: fn(FocusEvent) -> Nil) {
  attribute.attribute("onFocusCapture", handler)
}

pub fn on_got_pointer_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onGotPointerCapture", handler)
}

pub fn on_got_pointer_capture_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onGotPointerCaptureCapture", handler)
}

pub fn on_key_down(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyDown", handler)
}

pub fn on_key_down_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyDownCapture", handler)
}

pub fn on_key_press(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyPress", handler)
}

pub fn on_key_press_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyPressCapture", handler)
}

pub fn on_key_up(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyUp", handler)
}

pub fn on_key_up_capture(handler: fn(KeyboardEvent) -> Nil) {
  attribute.attribute("onKeyUpCapture", handler)
}

pub fn on_lost_pointer_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onLostPointerCapture", handler)
}

pub fn on_lost_pointer_capture_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onLostPointerCaptureCapture", handler)
}

pub fn on_mouse_down(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseDown", handler)
}

pub fn on_mouse_down_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseDownCapture", handler)
}

pub fn on_mouse_enter(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseEnter", handler)
}

pub fn on_mouse_leave(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseLeave", handler)
}

pub fn on_mouse_move(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseMove", handler)
}

pub fn on_mouse_move_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseMoveCapture", handler)
}

pub fn on_mouse_out(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseOut", handler)
}

pub fn on_mouse_out_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseOutCapture", handler)
}

pub fn on_mouse_up(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseUp", handler)
}

pub fn on_mouse_up_capture(handler: fn(MouseEvent) -> Nil) {
  attribute.attribute("onMouseUpCapture", handler)
}

pub fn on_pointer_cancel(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerCancel", handler)
}

pub fn on_pointer_cancel_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerCancelCapture", handler)
}

pub fn on_pointer_down(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerDown", handler)
}

pub fn on_pointer_down_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerDownCapture", handler)
}

pub fn on_pointer_enter(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerEnter", handler)
}

pub fn on_pointer_leave(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerLeave", handler)
}

pub fn on_pointer_move(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerMove", handler)
}

pub fn on_pointer_move_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerMoveCapture", handler)
}

pub fn on_pointer_out(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerOut", handler)
}

pub fn on_pointer_out_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerOutCapture", handler)
}

pub fn on_pointer_up(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerUp", handler)
}

pub fn on_pointer_up_capture(handler: fn(PointerEvent) -> Nil) {
  attribute.attribute("onPointerUpCapture", handler)
}

pub fn on_paste(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onPaste", handler)
}

pub fn on_paste_capture(handler: fn(ClipboardEvent) -> Nil) {
  attribute.attribute("onPasteCapture", handler)
}

pub fn on_scroll(handler: fn(Event) -> Nil) {
  attribute.attribute("onScroll", handler)
}

pub fn on_scroll_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onScrollCapture", handler)
}

pub fn on_select(handler: fn(Event) -> Nil) {
  attribute.attribute("onSelect", handler)
}

pub fn on_select_capture(handler: fn(Event) -> Nil) {
  attribute.attribute("onSelectCapture", handler)
}

pub fn on_touch_cancel(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchCancel", handler)
}

pub fn on_touch_cancel_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchCancelCapture", handler)
}

pub fn on_touch_end(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchEnd", handler)
}

pub fn on_touch_end_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchEndCapture", handler)
}

pub fn on_touch_move(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchMove", handler)
}

pub fn on_touch_move_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchMoveCapture", handler)
}

pub fn on_touch_start(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchStart", handler)
}

pub fn on_touch_start_capture(handler: fn(TouchEvent) -> Nil) {
  attribute.attribute("onTouchStartCapture", handler)
}

pub fn on_transition_end(handler: fn(TransitionEvent) -> Nil) {
  attribute.attribute("onTransitionEnd", handler)
}

pub fn on_transition_end_capture(handler: fn(TransitionEvent) -> Nil) {
  attribute.attribute("onTransitionEndCapture", handler)
}

pub fn on_wheel(handler: fn(WheelEvent) -> Nil) {
  attribute.attribute("onWheel", handler)
}

pub fn on_wheel_capture(handler: fn(WheelEvent) -> Nil) {
  attribute.attribute("onWheelCapture", handler)
}

pub fn on_reset(callback: fn(Event) -> Nil) {
  attribute.attribute("onReset", callback)
}

pub fn on_reset_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onResetCapture", callback)
}

pub fn on_submit(callback: fn(Event) -> Nil) {
  attribute.attribute("onSubmit", callback)
}

pub fn on_submit_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onSubmitCapture", callback)
}

pub fn on_cancel(callback: fn(Event) -> Nil) {
  attribute.attribute("onCancel", callback)
}

pub fn on_cancel_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onCancelCapture", callback)
}

pub fn on_close(callback: fn(Event) -> Nil) {
  attribute.attribute("onClose", callback)
}

pub fn on_close_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onCloseCapture", callback)
}

pub fn on_toggle(callback: fn(Event) -> Nil) {
  attribute.attribute("onToggle", callback)
}

pub fn on_toggle_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onToggleCapture", callback)
}

pub fn on_load(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoad", callback)
}

pub fn on_load_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadCapture", callback)
}

pub fn on_error(callback: fn(Event) -> Nil) {
  attribute.attribute("onError", callback)
}

pub fn on_error_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onErrorCapture", callback)
}

pub fn on_abort(callback: fn(Event) -> Nil) {
  attribute.attribute("onAbort", callback)
}

pub fn on_abort_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onAbortCapture", callback)
}

pub fn on_can_play(callback: fn(Event) -> Nil) {
  attribute.attribute("onCanPlay", callback)
}

pub fn on_can_play_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayCapture", callback)
}

pub fn on_can_play_through(callback: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayThrough", callback)
}

pub fn on_can_play_through_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onCanPlayThroughCapture", callback)
}

pub fn on_duration_change(callback: fn(Event) -> Nil) {
  attribute.attribute("onDurationChange", callback)
}

pub fn on_duration_change_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onDurationChangeCapture", callback)
}

pub fn on_emptied(callback: fn(Event) -> Nil) {
  attribute.attribute("onEmptied", callback)
}

pub fn on_emptied_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onEmptiedCapture", callback)
}

pub fn on_encrypted(callback: fn(Event) -> Nil) {
  attribute.attribute("onEncrypted", callback)
}

pub fn on_encrypted_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onEncryptedCapture", callback)
}

pub fn on_ended(callback: fn(Event) -> Nil) {
  attribute.attribute("onEnded", callback)
}

pub fn on_ended_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onEndedCapture", callback)
}

pub fn on_loaded_data(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadedData", callback)
}

pub fn on_loaded_data_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadedDataCapture", callback)
}

pub fn on_loaded_metadata(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadedMetadata", callback)
}

pub fn on_loaded_metadata_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadedMetadataCapture", callback)
}

pub fn on_load_start(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadStart", callback)
}

pub fn on_load_start_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onLoadStartCapture", callback)
}

pub fn on_pause(callback: fn(Event) -> Nil) {
  attribute.attribute("onPause", callback)
}

pub fn on_pause_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onPauseCapture", callback)
}

pub fn on_play(callback: fn(Event) -> Nil) {
  attribute.attribute("onPlay", callback)
}

pub fn on_play_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onPlayCapture", callback)
}

pub fn on_playing(callback: fn(Event) -> Nil) {
  attribute.attribute("onPlaying", callback)
}

pub fn on_playing_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onPlayingCapture", callback)
}

pub fn on_progress(callback: fn(Event) -> Nil) {
  attribute.attribute("onProgress", callback)
}

pub fn on_progress_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onProgressCapture", callback)
}

pub fn on_rate_change(callback: fn(Event) -> Nil) {
  attribute.attribute("onRateChange", callback)
}

pub fn on_rate_change_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onRateChangeCapture", callback)
}

pub fn on_resize(callback: fn(Event) -> Nil) {
  attribute.attribute("onResize", callback)
}

pub fn on_resize_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onResizeCapture", callback)
}

pub fn on_seeked(callback: fn(Event) -> Nil) {
  attribute.attribute("onSeeked", callback)
}

pub fn on_seeked_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onSeekedCapture", callback)
}

pub fn on_seeking(callback: fn(Event) -> Nil) {
  attribute.attribute("onSeeking", callback)
}

pub fn on_seeking_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onSeekingCapture", callback)
}

pub fn on_stalled(callback: fn(Event) -> Nil) {
  attribute.attribute("onStalled", callback)
}

pub fn on_stalled_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onStalledCapture", callback)
}

pub fn on_suspend(callback: fn(Event) -> Nil) {
  attribute.attribute("onSuspend", callback)
}

pub fn on_suspend_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onSuspendCapture", callback)
}

pub fn on_time_update(callback: fn(Event) -> Nil) {
  attribute.attribute("onTimeUpdate", callback)
}

pub fn on_time_update_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onTimeUpdateCapture", callback)
}

pub fn on_volume_change(callback: fn(Event) -> Nil) {
  attribute.attribute("onVolumeChange", callback)
}

pub fn on_volume_change_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onVolumeChangeCapture", callback)
}

pub fn on_waiting(callback: fn(Event) -> Nil) {
  attribute.attribute("onWaiting", callback)
}

pub fn on_waiting_capture(callback: fn(Event) -> Nil) {
  attribute.attribute("onWaitingCapture", callback)
}
