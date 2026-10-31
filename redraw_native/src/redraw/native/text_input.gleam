import gleam/dynamic.{type Dynamic}
import redraw/internals/unsafe
import redraw/native/internal/attributes
import redraw/native/style.{type Style}
import redraw/native/stylesheet.{type StyleSheet}

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn allow_font_scaling(value: Bool) {
  attribute("allowFontScaling", value)
}

pub fn auto_capitalize(value: Bool) {
  attribute("autoCapitalize", value)
}

pub fn auto_complete(value: String) {
  attribute("autoComplete", value)
}

pub fn auto_correct(value: Bool) {
  attribute("autoCorrect", value)
}

pub fn auto_focus(value: Bool) {
  attribute("autoFocus", value)
}

pub fn blur_on_submit(value: Bool) {
  attribute("blurOnSubmit", value)
}

pub fn caret_hidden(value: Bool) {
  attribute("caretHidden", value)
}

pub fn clear_button_mode(value: String) {
  attribute("clearButtonMode", value)
}

pub fn clear_text_on_focus(value: Bool) {
  attribute("clearTextOnFocus", value)
}

pub fn context_menu_hidden(value: Bool) {
  attribute("contextMenuHidden", value)
}

pub fn data_detector_types(value: List(String)) {
  let value = attributes.to_array(value)
  attribute("dataDetectorTypes", value)
}

pub fn default_value(value: String) {
  attribute("defaultValue", value)
}

pub fn disable_keyboard_shortcuts(value: Bool) {
  attribute("disableKeyboardShortcuts", value)
}

pub fn cursor_color(value: String) {
  attribute("cursorColor", value)
}

pub fn disable_fullscreen_ui(value: Bool) {
  attribute("disableFullscreenUI", value)
}

pub fn editable(value: Bool) {
  attribute("editable", value)
}

pub fn enables_return_key_automatically(value: Bool) {
  attribute("enablesReturnKeyAutomatically", value)
}

pub fn enter_key_hint(value: String) {
  attribute("enterKeyHint", value)
}

pub fn important_for_autofill(value: String) {
  attribute("importantForAutofill", value)
}

pub fn inline_image_left(value: String) {
  attribute("inlineImageLeft", value)
}

pub fn inline_image_padding(value: Int) {
  attribute("inlineImagePadding", value)
}

pub fn input_accessory_view_id(value: String) {
  attribute("inputAccessoryViewID", value)
}

pub fn input_accessory_view_button_label(value: String) {
  attribute("inputAccessoryViewButtonLabel", value)
}

pub fn input_mode(value: String) {
  attribute("inputMode", value)
}

pub fn keyboard_appearance(value: String) {
  attribute("keyboardAppearance", value)
}

pub fn keyboard_type(value: String) {
  attribute("keyboardType", value)
}

pub fn line_break_strategy_ios(value: String) {
  attribute("lineBreakStrategyIOS", value)
}

pub fn line_break_mode_ios(value: String) {
  attribute("lineBreakModeIOS", value)
}

pub fn max_font_size_multiplier(value: Int) {
  attribute("maxFontSizeMultiplier", value)
}

pub fn max_length(value: Int) {
  attribute("maxLength", value)
}

pub fn multiline(value: Bool) {
  attribute("multiline", value)
}

pub fn number_of_lines(value: Int) {
  attribute("numberOfLines", value)
}

pub fn on_blur(value: fn(Dynamic) -> Nil) {
  attribute("onBlur", value)
}

pub fn on_change(value: fn(Dynamic) -> Nil) {
  attribute("onChange", value)
}

pub fn on_change_text(value: fn(String) -> Nil) {
  attribute("onChangeText", value)
}

pub fn on_content_size_change(value: fn(Dynamic) -> Nil) {
  attribute("onContentSizeChange", value)
}

pub fn on_end_editing(value: fn() -> Nil) {
  attribute("onEndEditing", value)
}

pub fn on_press_in(value: fn(Dynamic) -> Nil) {
  attribute("onPressIn", value)
}

pub fn on_press_out(value: fn(Dynamic) -> Nil) {
  attribute("onPressOut", value)
}

pub fn on_focus(value: fn(Dynamic) -> Nil) {
  attribute("onFocus", value)
}

pub fn on_key_press(value: fn(Dynamic) -> Nil) {
  attribute("onKeyPress", value)
}

pub fn on_layout(value: fn(Dynamic) -> Nil) {
  attribute("onLayout", value)
}

pub fn on_scroll(value: fn(Dynamic) -> Nil) {
  attribute("onScroll", value)
}

pub fn on_selection_change(value: fn(Dynamic) -> Nil) {
  attribute("onSelectionChange", value)
}

pub fn on_submit_editing(value: fn(Dynamic) -> Nil) {
  attribute("onSubmitEditing", value)
}

pub fn placeholder(value: String) {
  attribute("placeholder", value)
}

pub fn placeholder_text_color(value: String) {
  attribute("placeholderTextColor", value)
}

pub fn read_only(value: Bool) {
  attribute("readOnly", value)
}

pub fn return_key_label(value: String) {
  attribute("returnKeyLabel", value)
}

pub fn return_key_type(value: String) {
  attribute("returnKeyType", value)
}

pub fn reject_responder_termination(value: Bool) {
  attribute("rejectResponderTermination", value)
}

pub fn rows(value: Int) {
  attribute("rows", value)
}

pub fn scroll_enabled(value: Bool) {
  attribute("scrollEnabled", value)
}

pub fn secure_text_entry(value: Bool) {
  attribute("secureTextEntry", value)
}

pub fn selection(start start: Int, end end: Int) {
  let value = attributes.to_selection(start:, end:)
  attribute("selection", value)
}

pub fn selection_color(value: String) {
  attribute("selectionColor", value)
}

pub fn selection_handle_color(value: String) {
  attribute("selectionHandleColor", value)
}

pub fn select_text_on_focus(value: Bool) {
  attribute("selectTextOnFocus", value)
}

pub fn show_soft_input_on_focus(value: Bool) {
  attribute("showSoftInputOnFocus", value)
}

pub fn smart_insert_delete(value: Bool) {
  attribute("smartInsertDelete", value)
}

pub fn spell_check(value: Bool) {
  attribute("spellCheck", value)
}

pub fn submit_behavior(value: String) {
  attribute("submitBehavior", value)
}

pub fn text_align(value: String) {
  attribute("textAlign", value)
}

pub fn text_content_type(value: String) {
  attribute("textContentType", value)
}

pub fn password_rules(value: String) {
  attribute("passwordRules", value)
}

pub fn style(stylesheet: StyleSheet, name: String) {
  case stylesheet.get(stylesheet, name) {
    Error(_) -> none()
    Ok(style) -> attribute("style", style)
  }
}

pub fn styles(styles: List(Style)) {
  let value = stylesheet.compile(styles)
  attribute("style", value)
}

pub fn text_break_strategy(value: String) {
  attribute("textBreakStrategy", value)
}

pub fn underline_color_android(value: String) {
  attribute("underlineColorAndroid", value)
}

pub fn value(value: String) {
  attribute("value", value)
}

pub fn none() {
  attribute("none_", Nil)
}
