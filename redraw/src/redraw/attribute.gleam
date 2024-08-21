import gleam/option
import gleam/string
import redraw
import redraw/internals/attribute

pub type Attribute =
  attribute.Attribute

pub const attribute = attribute.attribute

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

/// The `inner_html` data should be created as close to where the HTML is
/// generated as possible. This ensures that all raw HTML being used in your
/// code is explicitly marked as such, and that only variables that you expect
/// to contain HTML are passed to `dangerously_set_inner_html`. It is not
/// recommended to create the object inline like
/// `html.div([attribute.dangerously_set_inner_html(attribute.inner_html(markup))], [])`
///
/// [Documentation](https://react.dev/reference/react-dom/components/common#dangerously-setting-the-inner-html)
@external(javascript, "../redraw.ffi.mjs", "innerHTML")
pub fn inner_html(html: String) -> InnerHTML

/// Overrides the innerHTML property of the DOM node and displays the passed
/// HTML inside. This should be used with extreme caution! If the HTML inside
/// isn’t trusted (for example, if it’s based on user data), you risk
/// introducing an XSS vulnerability.
///
/// [Documentation](https://react.dev/reference/react-dom/components/common#dangerously-setting-the-inner-html)
pub fn dangerously_set_inner_html(inner_html: InnerHTML) {
  attribute.attribute("dangerouslySetInnerHTML", inner_html)
}

/// A ref object from `redraw.use_ref`. Your ref will be filled with the DOM
/// element for this node. Contrarily to JS React, when using a Ref, you're
/// forced to use an optional type here. Because when using this function, you
/// want to get a reference from a real DOM node, meaning at the initialization
/// of the reference, you won't have any data. Use `ref_` when you want full
/// control over the ref you send to the Component.
pub fn ref(ref: redraw.Ref(option.Option(a))) {
  attribute.attribute("ref", fn(dom_ref) {
    redraw.set_current(ref, option.Some(dom_ref))
  })
}

/// A ref callback function. The callback will be provided with the DOM element
/// for this node. Use this function to get control on the ref provided by the
/// DOM node or the component.
pub fn ref_(ref: fn(a) -> Nil) {
  attribute.attribute("ref", ref)
}

pub fn suppress_content_editable_warning(value: Bool) {
  attribute.attribute("suppressContentEditableWarning", value)
}

pub fn suppress_hydration_warning(value: Bool) {
  attribute.attribute("suppressHydrationWarning", value)
}

@external(javascript, "../redraw.ffi.mjs", "convertStyle")
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

/// If true, the browser lets the user edit the rendered element directly.
/// This is used to implement rich text input libraries like Lexical. React
/// warns if you try to pass React children to an element with
/// `content_editable(True)` because React will not be able to update its content
/// after user edits.
pub fn content_editable(value: Bool) {
  attribute.attribute("contentEditable", value)
}

/// Data attributes let you attach some string data to the element, for example
/// `data("fruit", "banana")`. In React, they are not commonly used because you
/// would usually read data from props or state instead.
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

/// For <label> and <output>, lets you associate the label with some control.
/// Same as for HTML attribute.
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

/// Specifies a unique identifier for this element, which can be used to find
/// it later or connect it with other elements. Generate it with useId to avoid
/// clashes between multiple instances of the same component.
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

pub fn type_(name: String) {
  attribute.attribute("type", name)
}

pub fn value(val: String) {
  attribute.attribute("value", val)
}

pub fn checked(is_checked: Bool) {
  attribute.attribute("checked", is_checked)
}

pub fn placeholder(text: String) {
  attribute.attribute("placeholder", text)
}

pub fn selected(is_selected: Bool) {
  attribute.attribute("selected", is_selected)
}

pub fn accept(types: List(String)) {
  attribute.attribute("accept", string.join(types, " "))
}

pub fn accept_charset(types: List(String)) {
  attribute.attribute("acceptCharset", string.join(types, " "))
}

pub fn msg(uri: String) {
  attribute.attribute("msg", uri)
}

pub fn autocomplete(name: String) {
  attribute.attribute("autocomplete", name)
}

pub fn autofocus(should_autofocus: Bool) {
  attribute.attribute("autofocus", should_autofocus)
}

pub fn disabled(is_disabled: Bool) {
  attribute.attribute("disabled", is_disabled)
}

pub fn name(name: String) {
  attribute.attribute("name", name)
}

pub fn pattern(regex: String) {
  attribute.attribute("pattern", regex)
}

pub fn readonly(is_readonly: Bool) {
  attribute.attribute("readonly", is_readonly)
}

pub fn required(is_required: Bool) {
  attribute.attribute("required", is_required)
}

pub fn max(val: String) {
  attribute.attribute("max", val)
}

pub fn min(val: String) {
  attribute.attribute("min", val)
}

pub fn step(val: String) {
  attribute.attribute("step", val)
}

pub fn cols(val: Int) {
  attribute.attribute("cols", val)
}

pub fn rows(val: Int) {
  attribute.attribute("rows", val)
}

pub fn wrap(mode: String) {
  attribute.attribute("wrap", mode)
}

pub fn download(filename: String) {
  attribute.attribute("download", filename)
}

pub fn rel(relationship: String) {
  attribute.attribute("rel", relationship)
}

pub fn height(val: Int) {
  attribute.attribute("height", val)
}

pub fn width(val: Int) {
  attribute.attribute("width", val)
}

pub fn autoplay(should_autoplay: Bool) {
  attribute.attribute("autoplay", should_autoplay)
}

pub fn controls(visible: Bool) {
  attribute.attribute("controls", visible)
}

pub fn loop(should_loop: Bool) {
  attribute.attribute("loop", should_loop)
}

pub fn action(url: String) {
  attribute.attribute("action", url)
}

pub fn enctype(value: String) {
  attribute.attribute("enctype", value)
}

pub fn method(method: String) {
  attribute.attribute("method", method)
}

pub fn novalidate(value: Bool) {
  attribute.attribute("novalidate", value)
}

pub fn form_action(action: String) {
  attribute.attribute("formaction", action)
}

pub fn form_enctype(value: String) {
  attribute.attribute("formenctype", value)
}

pub fn form_method(method: String) {
  attribute.attribute("formmethod", method)
}

pub fn form_novalidate(value: Bool) {
  attribute.attribute("formnovalidate", value)
}

pub fn form_target(target: String) {
  attribute.attribute("formtarget", target)
}

pub fn open(is_open: Bool) {
  attribute.attribute("open", is_open)
}
