import gleam/dynamic
import react
import react/internals/attribute

pub type Attribute =
  attribute.Attribute

pub fn href(url: String) {
  attribute.attribute("href", url)
}

pub fn target(value: String) {
  attribute.attribute("target", value)
}

pub fn src(value: String) {
  attribute.attribute("src", value)
}

pub fn class(value: String) {
  attribute.attribute("className", value)
}

pub fn alt(value: String) {
  attribute.attribute("alt", value)
}

pub type InnerHTML

@external(javascript, "../react.ffi.mjs", "innerHTML")
pub fn inner_html(html: String) -> InnerHTML

/// Overrides the innerHTML property of the DOM node and displays the passed HTML inside. This should be used with extreme caution! If the HTML inside isn’t trusted (for example, if it’s based on user data), you risk introducing an XSS vulnerability.
pub fn dangerously_set_inner_html(inner_html: InnerHTML) {
  attribute.attribute("dangerouslySetInnerHTML", inner_html)
}

/// A ref object from `react.use_ref`. Your ref will be filled with the DOM element for this node.
pub fn ref(ref: react.Ref(a)) {
  attribute.attribute("ref", ref)
}

/// A ref callback function. The callback will be provided with the DOM element for this node.
pub fn ref_(ref: fn(dynamic.Dynamic) -> Nil) {
  attribute.attribute("ref", ref)
}

pub fn suppress_content_editable_warning(value: Bool) {
  attribute.attribute("suppressContentEditableWarning", value)
}

pub fn suppress_hydration_warning(value: Bool) {
  attribute.attribute("suppressHydrationWarning", value)
}

@external(javascript, "../react.ffi.mjs", "convertStyle")
fn convert_style(styles: List(#(String, String))) -> a

pub fn style(styles: List(#(String, String))) {
  attribute.attribute("style", convert_style(styles))
}

/// Set aria attribute on the node. Should be used like `aria("valuenow", "75")`.
pub fn aria(key: String, value: String) {
  attribute.attribute("aria-" <> key, value)
}

pub fn access_key(value: String) {
  attribute.attribute("accessKey", value)
}

pub fn auto_capitalize(value: String) {
  attribute.attribute("autoCapitalize", value)
}

/// Alias of `class`.
pub fn class_name(value: String) {
  attribute.attribute("className", value)
}

/// If true, the browser lets the user edit the rendered element directly. This is used to implement rich text input libraries like Lexical. React warns if you try to pass React children to an element with contentEditable={true} because React will not be able to update its content after user edits.
pub fn content_editable(value: Bool) {
  attribute.attribute("contentEditable", value)
}

/// Data attributes let you attach some string data to the element, for example data-fruit="banana". In React, they are not commonly used because you would usually read data from props or state instead.
pub fn data(key: String, value: String) {
  attribute.attribute("data-" <> key, value)
}

pub type Dir {
  Ltr
  Rtl
}

/// Specifies the text direction of the element.
pub fn dir(value: Dir) {
  let value = case value {
    Ltr -> "ltr"
    Rtl -> "rtl"
  }
  attribute.attribute("dir", value)
}

/// Specifies whether the element is draggable. Part of HTML Drag and Drop API.
pub fn draggable(value: Bool) {
  attribute.attribute("draggable", value)
}

/// Specifies which action to present for the enter key on virtual keyboards.
pub fn enter_key_hint(value: String) {
  attribute.attribute("enterKeyHint", value)
}

/// For <label> and <output>, lets you associate the label with some control. Same as for HTML attribute. React uses the standard DOM property names (htmlFor) instead of HTML attribute names.
pub fn for(value: String) {
  attribute.attribute("htmlFor", value)
}

/// Alias of `for`.
pub fn html_for(value: String) {
  attribute.attribute("htmlFor", value)
}

/// Specifies whether the element should be hidden.
pub fn hidden(value: Bool) {
  attribute.attribute("hidden", value)
}

/// Specifies a unique identifier for this element, which can be used to find it later or connect it with other elements. Generate it with useId to avoid clashes between multiple instances of the same component.
pub fn id(value: String) {
  attribute.attribute("id", value)
}

/// If specified, the component will behave like a custom element.
pub fn is(value: String) {
  attribute.attribute("is", value)
}

/// Specifies what kind of keyboard to display (for example, text, number or telephone).
pub fn input_mode(value: String) {
  attribute.attribute("inputMode", value)
}

/// Specifies which property the element represents for structured data crawlers.
pub fn item_prop(value: String) {
  attribute.attribute("itemProp", value)
}

/// Specifies the language of the element.
pub fn lang(value: String) {
  attribute.attribute("lang", value)
}

/// Specifies the element role explicitly for assistive technologies.
pub fn role(value: String) {
  attribute.attribute("role", value)
}

/// Specifies the slot name when using shadow DOM.
pub fn slot(value: String) {
  attribute.attribute("slot", value)
}

/// If explicitly set to true or false, enables or disables spellchecking.
pub fn spell_check(value: Bool) {
  attribute.attribute("spellCheck", value)
}

/// Overrides the default Tab button behavior. Avoid using values other than -1 and 0.
pub fn tab_index(value: Int) {
  attribute.attribute("tabIndex", value)
}

/// Specifies the tooltip text for the element.
pub fn title(value: String) {
  attribute.attribute("title", value)
}

pub type Translate {
  Yes
  No
}

/// Passing No excludes the element content from being translated.
pub fn translate(value: Translate) {
  let value = case value {
    Yes -> "yes"
    No -> "no"
  }
  attribute.attribute("translate", value)
}
