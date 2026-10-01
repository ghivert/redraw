//// ARIA attributes, used to improve accessibility of HTML and SVG elements.
//// When an attribute is not available here, fallback on `attribute.aria`.
////
//// All available attributes can be found in the
//// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes)
//// documentation.

import gleam/float
import gleam/int
import gleam/string
import redraw/dom/attribute.{type Attribute}

fn aria(key: String, value: String) -> Attribute {
  attribute.attribute("aria-" <> key, value)
}

fn bool_to_string(value: Bool) -> String {
  case value {
    True -> "true"
    False -> "false"
  }
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-activedescendant)
pub fn active_descendant(id: String) -> Attribute {
  aria("activedescendant", id)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-atomic)
pub fn atomic(value: Bool) -> Attribute {
  aria("atomic", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-autocomplete)
pub fn autocomplete(value: String) -> Attribute {
  aria("autocomplete", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-braillelabel)
pub fn braille_label(value: String) -> Attribute {
  aria("braillelabel", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-brailleroledescription)
pub fn braille_role_description(value: String) -> Attribute {
  aria("brailleroledescription", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy)
pub fn busy(value: Bool) -> Attribute {
  aria("busy", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-checked)
pub fn checked(value: String) -> Attribute {
  aria("checked", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colcount)
pub fn col_count(value: Int) -> Attribute {
  aria("colcount", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindex)
pub fn col_index(value: Int) -> Attribute {
  aria("colindex", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindextext)
pub fn col_index_text(value: String) -> Attribute {
  aria("colindextext", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colspan)
pub fn col_span(value: Int) -> Attribute {
  aria("colspan", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-controls)
pub fn controls(ids: List(String)) -> Attribute {
  aria("controls", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-current)
pub fn current(value: String) -> Attribute {
  aria("current", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-describedby)
pub fn described_by(ids: List(String)) -> Attribute {
  aria("describedby", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-description)
pub fn description(value: String) -> Attribute {
  aria("description", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-details)
pub fn details(ids: List(String)) -> Attribute {
  aria("details", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled)
pub fn disabled(value: Bool) -> Attribute {
  aria("disabled", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-errormessage)
pub fn error_message(ids: List(String)) -> Attribute {
  aria("errormessage", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-expanded)
pub fn expanded(value: Bool) -> Attribute {
  aria("expanded", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-flowto)
pub fn flow_to(ids: List(String)) -> Attribute {
  aria("flowto", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-haspopup)
pub fn has_popup(value: String) -> Attribute {
  aria("haspopup", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-hidden)
pub fn hidden(value: Bool) -> Attribute {
  aria("hidden", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid)
pub fn invalid(value: String) -> Attribute {
  aria("invalid", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-keyshortcuts)
pub fn key_shortcuts(shortcuts: List(String)) -> Attribute {
  aria("keyshortcuts", string.join(shortcuts, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-label)
pub fn label(value: String) -> Attribute {
  aria("label", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-labelledby)
pub fn labelled_by(ids: List(String)) -> Attribute {
  aria("labelledby", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-level)
pub fn level(value: Int) -> Attribute {
  aria("level", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-live)
pub fn live(value: String) -> Attribute {
  aria("live", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-modal)
pub fn modal(value: Bool) -> Attribute {
  aria("modal", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiline)
pub fn multiline(value: Bool) -> Attribute {
  aria("multiline", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiselectable)
pub fn multiselectable(value: Bool) -> Attribute {
  aria("multiselectable", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-orientation)
pub fn orientation(value: String) -> Attribute {
  aria("orientation", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-owns)
pub fn owns(ids: List(String)) -> Attribute {
  aria("owns", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-placeholder)
pub fn placeholder(value: String) -> Attribute {
  aria("placeholder", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-posinset)
pub fn pos_in_set(value: Int) -> Attribute {
  aria("posinset", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-pressed)
pub fn pressed(value: String) -> Attribute {
  aria("pressed", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-readonly)
pub fn readonly(value: Bool) -> Attribute {
  aria("readonly", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-relevant)
pub fn relevant(value: String) -> Attribute {
  aria("relevant", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-required)
pub fn required(value: Bool) -> Attribute {
  aria("required", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-roledescription)
pub fn role_description(value: String) -> Attribute {
  aria("roledescription", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowcount)
pub fn row_count(value: Int) -> Attribute {
  aria("rowcount", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindex)
pub fn row_index(value: Int) -> Attribute {
  aria("rowindex", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindextext)
pub fn row_index_text(value: String) -> Attribute {
  aria("rowindextext", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowspan)
pub fn row_span(value: Int) -> Attribute {
  aria("rowspan", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-selected)
pub fn selected(value: Bool) -> Attribute {
  aria("selected", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-setsize)
pub fn set_size(value: Int) -> Attribute {
  aria("setsize", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-sort)
pub fn sort(value: String) -> Attribute {
  aria("sort", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemax)
pub fn value_max(value: Float) -> Attribute {
  aria("valuemax", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemin)
pub fn value_min(value: Float) -> Attribute {
  aria("valuemin", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuenow)
pub fn value_now(value: Float) -> Attribute {
  aria("valuenow", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuetext)
pub fn value_text(value: String) -> Attribute {
  aria("valuetext", value)
}
