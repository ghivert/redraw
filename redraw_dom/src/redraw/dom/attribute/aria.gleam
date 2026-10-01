//// ARIA attributes, used to improve accessibility of HTML and SVG elements.
//// When an attribute is not available here, fallback on `attribute.aria`.
////
//// All available attributes can be found in the
//// [MDN](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes)
//// documentation.

import gleam/float
import gleam/int
import gleam/list
import gleam/option
import gleam/string
import redraw/dom/attribute.{type Attribute}

fn bool_to_string(value: Bool) -> String {
  case value {
    True -> "true"
    False -> "false"
  }
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-activedescendant)
pub fn active_descendant(id: String) -> Attribute {
  attribute.aria("activedescendant", id)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-atomic)
pub fn atomic(value: Bool) -> Attribute {
  attribute.aria("atomic", bool_to_string(value))
}

/// Kind of autocomplete suggestions provided by an input.
pub type Autocomplete {
  Inline
  List
  Both
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-autocomplete)
pub fn autocomplete(value: option.Option(Autocomplete)) -> Attribute {
  let value = case value {
    option.Some(Inline) -> "inline"
    option.Some(List) -> "list"
    option.Some(Both) -> "both"
    option.None -> "none"
  }
  attribute.aria("autocomplete", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-braillelabel)
pub fn braille_label(value: String) -> Attribute {
  attribute.aria("braillelabel", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-brailleroledescription)
pub fn braille_role_description(value: String) -> Attribute {
  attribute.aria("brailleroledescription", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy)
pub fn busy(value: Bool) -> Attribute {
  attribute.aria("busy", bool_to_string(value))
}

/// State of a checkbox-like element, which can be partially checked.
pub type Mixable {
  Yes
  No
  Mixed
}

fn mixable_to_string(mixed: Mixable) -> String {
  case mixed {
    Yes -> "true"
    No -> "false"
    Mixed -> "mixed"
  }
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-checked)
pub fn checked(value: Mixable) -> Attribute {
  attribute.aria("checked", mixable_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colcount)
pub fn col_count(value: Int) -> Attribute {
  attribute.aria("colcount", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindex)
pub fn col_index(value: Int) -> Attribute {
  attribute.aria("colindex", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colindextext)
pub fn col_index_text(value: String) -> Attribute {
  attribute.aria("colindextext", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-colspan)
pub fn col_span(value: Int) -> Attribute {
  attribute.aria("colspan", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-controls)
pub fn controls(ids: List(String)) -> Attribute {
  attribute.aria("controls", string.join(ids, " "))
}

/// Kind of current item within a container or set of related elements.
pub type Current {
  Current(Bool)
  Page
  Step
  Location
  Date
  Time
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-current)
pub fn current(value: Current) -> Attribute {
  let value = case value {
    Current(value) -> bool_to_string(value)
    Page -> "page"
    Step -> "step"
    Location -> "location"
    Date -> "date"
    Time -> "time"
  }
  attribute.aria("current", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-describedby)
pub fn described_by(ids: List(String)) -> Attribute {
  attribute.aria("describedby", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-description)
pub fn description(value: String) -> Attribute {
  attribute.aria("description", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-details)
pub fn details(ids: List(String)) -> Attribute {
  attribute.aria("details", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled)
pub fn disabled(value: Bool) -> Attribute {
  attribute.aria("disabled", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-errormessage)
pub fn error_message(ids: List(String)) -> Attribute {
  attribute.aria("errormessage", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-expanded)
pub fn expanded(value: Bool) -> Attribute {
  attribute.aria("expanded", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-flowto)
pub fn flow_to(ids: List(String)) -> Attribute {
  attribute.aria("flowto", string.join(ids, " "))
}

/// Kind of popup triggered by an element. `HasPopup(True)` is the same as `Menu`.
pub type HasPopup {
  HasPopup(Bool)
  Menu
  Listbox
  Tree
  Grid
  Dialog
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-haspopup)
pub fn has_popup(value: HasPopup) -> Attribute {
  let value = case value {
    HasPopup(value) -> bool_to_string(value)
    Menu -> "menu"
    Listbox -> "listbox"
    Tree -> "tree"
    Grid -> "grid"
    Dialog -> "dialog"
  }
  attribute.aria("haspopup", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-hidden)
pub fn hidden(value: Bool) -> Attribute {
  attribute.aria("hidden", bool_to_string(value))
}

/// Kind of error detected on an element.
pub type Invalid {
  Invalid(Bool)
  Grammar
  Spelling
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid)
pub fn invalid(value: Invalid) -> Attribute {
  let value = case value {
    Invalid(value) -> bool_to_string(value)
    Grammar -> "grammar"
    Spelling -> "spelling"
  }
  attribute.aria("invalid", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-keyshortcuts)
pub fn key_shortcuts(shortcuts: List(String)) -> Attribute {
  attribute.aria("keyshortcuts", string.join(shortcuts, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-label)
pub fn label(value: String) -> Attribute {
  attribute.aria("label", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-labelledby)
pub fn labelled_by(ids: List(String)) -> Attribute {
  attribute.aria("labelledby", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-level)
pub fn level(value: Int) -> Attribute {
  attribute.aria("level", int.to_string(value))
}

/// Priority of the updates of a live region.
pub type Live {
  Assertive
  Polite
  Off
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-live)
pub fn live(value: Live) -> Attribute {
  let value = case value {
    Assertive -> "assertive"
    Polite -> "polite"
    Off -> "off"
  }
  attribute.aria("live", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-modal)
pub fn modal(value: Bool) -> Attribute {
  attribute.aria("modal", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiline)
pub fn multiline(value: Bool) -> Attribute {
  attribute.aria("multiline", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-multiselectable)
pub fn multiselectable(value: Bool) -> Attribute {
  attribute.aria("multiselectable", bool_to_string(value))
}

/// Orientation of an element.
pub type Orientation {
  Horizontal
  Vertical
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-orientation)
pub fn orientation(value: Orientation) -> Attribute {
  let value = case value {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
  attribute.aria("orientation", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-owns)
pub fn owns(ids: List(String)) -> Attribute {
  attribute.aria("owns", string.join(ids, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-placeholder)
pub fn placeholder(value: String) -> Attribute {
  attribute.aria("placeholder", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-posinset)
pub fn pos_in_set(value: Int) -> Attribute {
  attribute.aria("posinset", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-pressed)
pub fn pressed(value: Mixable) -> Attribute {
  attribute.aria("pressed", mixable_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-readonly)
pub fn readonly(value: Bool) -> Attribute {
  attribute.aria("readonly", bool_to_string(value))
}

/// Kind of changes notified by a live region.
pub type Relevant {
  Additions
  Removals
  Text
  All
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-relevant)
pub fn relevant(value: Relevant) -> Attribute {
  let value = case value {
    Additions -> "additions"
    Removals -> "removals"
    Text -> "text"
    All -> "all"
  }
  attribute.aria("relevant", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-required)
pub fn required(value: Bool) -> Attribute {
  attribute.aria("required", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-roledescription)
pub fn role_description(value: String) -> Attribute {
  attribute.aria("roledescription", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowcount)
pub fn row_count(value: Int) -> Attribute {
  attribute.aria("rowcount", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindex)
pub fn row_index(value: Int) -> Attribute {
  attribute.aria("rowindex", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowindextext)
pub fn row_index_text(value: String) -> Attribute {
  attribute.aria("rowindextext", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-rowspan)
pub fn row_span(value: Int) -> Attribute {
  attribute.aria("rowspan", int.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-selected)
pub fn selected(value: Bool) -> Attribute {
  attribute.aria("selected", bool_to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-setsize)
pub fn set_size(value: Int) -> Attribute {
  attribute.aria("setsize", int.to_string(value))
}

/// Sort order of a table or grid column.
pub type Sort {
  Ascending
  Descending
  Other
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-sort)
pub fn sort(value: option.Option(Sort)) -> Attribute {
  let value = case value {
    option.Some(Ascending) -> "ascending"
    option.Some(Descending) -> "descending"
    option.Some(Other) -> "other"
    option.None -> "none"
  }
  attribute.aria("sort", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemax)
pub fn value_max(value: Float) -> Attribute {
  attribute.aria("valuemax", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuemin)
pub fn value_min(value: Float) -> Attribute {
  attribute.aria("valuemin", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuenow)
pub fn value_now(value: Float) -> Attribute {
  attribute.aria("valuenow", float.to_string(value))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-valuetext)
pub fn value_text(value: String) -> Attribute {
  attribute.aria("valuetext", value)
}
