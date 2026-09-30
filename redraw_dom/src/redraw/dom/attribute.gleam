//// Implementation for HTML and SVG attributes usable in React and in browser.
//// Contrarily to Lustre, every attributes can take arbitrary data, because
//// they're directly bind in the underlying component's props.
////
//// All available attributes can be found in the
//// [React.dev](https://react.dev/reference/react-dom/components/common#common)
//// documentation for detailed information, as well as on
//// [MDN](https://developer.mozilla.org/docs/Web/API/Element).

import gleam/dynamic.{type Dynamic}
import gleam/fetch/form_data.{type FormData}
import gleam/option
import gleam/string
import redraw/internal/unsafe
import redraw/ref

/// Attribute linked on an HTML or SVG node. Think about like a `prop` in React.
pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

/// Generic attribute. `key` will be the key in the HTML attributes as-is,
/// while content can be anything. `content` will be converted by React to
/// strings, so be careful to not send complicated data structure, but booleans,
/// strings numbers, etc. are plainly supported.
///
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Reference/Attributes)
pub fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLAnchorElement/href)
pub fn href(url: String) -> Attribute {
  attribute("href", url)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLAnchorElement/target)
pub fn target(value: String) -> Attribute {
  attribute("target", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLMediaElement/src)
pub fn src(value: String) -> Attribute {
  attribute("src", value)
}

/// To follow Lustre pattern, `class` is additive. When using multiple `class`
/// on a single element, they will all be applied on that element.
///
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/class)
pub fn class(value: String) -> Attribute {
  attribute("className", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLMediaElement/alt)
pub fn alt(value: String) -> Attribute {
  attribute("alt", value)
}

/// Inner HTML data are HTML that will not be verified sanitized.
/// Be careful when using it. You should almost always prefer to use
/// `redraw/element/html`.
pub type InnerHTML

/// The `inner_html` data should be created as close to where the HTML is
/// generated as possible. This ensures that all raw HTML being used in your
/// code is explicitly marked as such, and that only variables that you expect
/// to contain HTML are passed to `dangerously_set_inner_html`. It is not
/// recommended to create the object inline like
/// `html.div([attribute.dangerously_set_inner_html(attribute.inner_html(markup))], [])` \
/// [Documentation](https://react.dev/reference/react-dom/components/common#dangerously-setting-the-inner-html)
@external(javascript, "./attribute.ffi.mjs", "innerHTML")
pub fn inner_html(html: String) -> InnerHTML

/// Overrides the innerHTML property of the DOM node and displays the passed
/// HTML inside. This should be used with extreme caution! If the HTML inside
/// isn’t trusted (for example, if it’s based on user data), you risk
/// introducing an XSS vulnerability. \
/// [Documentation](https://react.dev/reference/react-dom/components/common#dangerously-setting-the-inner-html)
pub fn dangerously_set_inner_html(inner_html: InnerHTML) -> Attribute {
  attribute("dangerouslySetInnerHTML", inner_html)
}

/// A ref object from `redraw.use_ref`. Your ref will be filled with the DOM
/// element for this node. Contrarily to JS React, when using a Ref, you're
/// forced to use an optional type here. Because when using this function, you
/// want to get a reference from a real DOM node, meaning at the initialization
/// of the reference, you won't have any data. Use `ref_` when you want full
/// control over the ref you send to the Component. \
/// [Documentation](https://react.dev/reference/react-dom/components/common#manipulating-a-dom-node-with-a-ref)
pub fn ref(ref: ref.Ref(option.Option(a))) -> Attribute {
  use dom_ref <- attribute("ref")
  ref.assign(ref, option.Some(dom_ref))
}

/// A ref callback function. The callback will be provided with the DOM element
/// for this node. Use this function to get control on the ref provided by the
/// DOM node or the component. \
/// [Documentation](https://react.dev/reference/react-dom/components/common#manipulating-a-dom-node-with-a-ref)
pub fn ref_(ref: fn(a) -> Nil) -> Attribute {
  attribute("ref", ref)
}

/// If `True`, suppresses the warning that React shows for elements that both
/// have `children` and `content_editable(True)` (which normally do not work
/// together). Use this if you’re building a text input library that manages
/// the `contentEditable` content manually.
pub fn suppress_content_editable_warning(value: Bool) -> Attribute {
  attribute("suppressContentEditableWarning", value)
}

/// If you use [server rendering](https://react.dev/reference/react-dom/server),
/// normally there is a warning when the server and the client render different
/// content. In some rare cases (like timestamps), it is very hard or impossible
/// to guarantee an exact match. If you set suppressHydrationWarning to true,
/// React will not warn you about mismatches in the attributes and the content
/// of that element. It only works one level deep, and is intended to be used
/// as an escape hatch. Don’t overuse it.
/// [Read about suppressing hydration errors.](https://react.dev/reference/react-dom/client/hydrateRoot#suppressing-unavoidable-hydration-mismatch-errors)
pub fn suppress_hydration_warning(value: Bool) -> Attribute {
  attribute("suppressHydrationWarning", value)
}

@external(javascript, "./attribute.ffi.mjs", "convertStyle")
fn convert_style(styles: List(#(String, String))) -> a

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/style)
pub fn style(styles: List(#(String, String))) -> Attribute {
  attribute("style", convert_style(styles))
}

/// Set aria attribute on the node. Should be used like `aria("valuenow", "75")`.
pub fn aria(key: String, value: String) -> Attribute {
  attribute("aria-" <> key, value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/accesskey)
pub fn access_key(value: String) -> Attribute {
  attribute("accessKey", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/autocapitalize)
pub fn auto_capitalize(value: String) -> Attribute {
  attribute("autoCapitalize", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/autofocus)
pub fn auto_focus(value: Bool) -> Attribute {
  attribute("autoFocus", value)
}

/// Alias of `class`. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/class)
pub fn class_name(value: String) -> Attribute {
  attribute("className", value)
}

/// Specifies the value of a metadata name defined by the `<meta>` `name`
/// attribute. It takes a string as its value, and the expected syntax varies
/// depending on the `name` value used. \
/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/content)
pub fn content(value: String) -> Attribute {
  attribute("content", value)
}

/// If true, the browser lets the user edit the rendered element directly.
/// This is used to implement rich text input libraries like Lexical. React
/// warns if you try to pass React children to an element with
/// `content_editable(True)` because React will not be able to update its content
/// after user edits. \
/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTML/Global_attributes/contenteditable)
pub fn content_editable(value: Bool) -> Attribute {
  attribute("contentEditable", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/crossorigin)
pub fn cross_origin(value: String) -> Attribute {
  attribute("crossOrigin", value)
}

/// Data attributes let you attach some string data to the element, for example
/// `data("fruit", "banana")`. In React, they are not commonly used because you
/// would usually read data from props or state instead. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/data-*)
pub fn data(key: String, value: String) -> Attribute {
  attribute("data-" <> key, value)
}

/// Directionality of an element text.
pub type Dir {
  Ltr
  Rtl
}

/// Specifies the text direction of the element. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/dir)
pub fn dir(value: Dir) -> Attribute {
  let value = case value {
    Ltr -> "ltr"
    Rtl -> "rtl"
  }
  attribute("dir", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/dirname)
pub fn dirname(value: String) -> Attribute {
  attribute("dirName", value)
}

/// Specifies whether the element is draggable. Part of HTML Drag and Drop API. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/draggable)
pub fn draggable(value: Bool) -> Attribute {
  attribute("draggable", value)
}

/// Specifies which action to present for the enter key on virtual keyboards. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/enterkeyhint)
pub fn enter_key_hint(value: String) -> Attribute {
  attribute("enterKeyHint", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/exportparts)
pub fn export_parts(value: List(String)) -> Attribute {
  attribute("exportParts", string.join(value, with: ", "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/elementtiming)
pub fn element_timing(value: String) -> Attribute {
  attribute("elementTiming", value)
}

/// For <label> and <output>, lets you associate the label with some control.
/// Same as for HTML attribute. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/for)
pub fn for(value: String) -> Attribute {
  attribute("htmlFor", value)
}

/// Alias of `for`. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/for)
pub fn html_for(value: String) -> Attribute {
  attribute("htmlFor", value)
}

/// Specifies whether the element should be hidden. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/hidden)
pub fn hidden(value: Bool) -> Attribute {
  attribute("hidden", value)
}

/// For `<input type="email">`, `<input type="file">` and `<select>`, indicates
/// if it accepts one or more values. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Reference/multiple)
pub fn multiple(value: Bool) -> Attribute {
  attribute("multiple", value)
}

/// Specifies a unique identifier for this element, which can be used to find
/// it later or connect it with other elements. Generate it with useId to avoid
/// clashes between multiple instances of the same component. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/id)
pub fn id(value: String) -> Attribute {
  attribute("id", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/inert)
pub fn inert(value: Bool) -> Attribute {
  attribute("inert", value)
}

/// If specified, the component will behave like a custom element. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/is)
pub fn is(value: String) -> Attribute {
  attribute("is", value)
}

/// Specifies what kind of keyboard to display (for example, text, number or telephone). \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/inputmode)
pub fn input_mode(value: String) -> Attribute {
  attribute("inputMode", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/itemid)
pub fn item_id(value: String) -> Attribute {
  attribute("itemId", value)
}

/// Specifies which property the element represents for structured data crawlers. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/itemprop)
pub fn item_prop(value: String) -> Attribute {
  attribute("itemProp", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/itemref)
pub fn item_ref(value: String) -> Attribute {
  attribute("itemRef", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/itemscope)
pub fn item_scope(value: String) -> Attribute {
  attribute("itemScope", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/itemtype)
pub fn item_type(value: String) -> Attribute {
  attribute("itemType", value)
}

/// Specifies the language of the element. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/lang)
pub fn lang(value: String) -> Attribute {
  attribute("lang", value)
}

/// Specifies the element role explicitly for assistive technologies.
pub fn role(value: String) -> Attribute {
  attribute("role", value)
}

/// Specifies the slot name when using shadow DOM. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/slot)
pub fn slot(value: String) -> Attribute {
  attribute("slot", value)
}

/// If explicitly set to true or false, enables or disables spellchecking. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/spellcheck)
pub fn spell_check(value: Bool) -> Attribute {
  attribute("spellCheck", value)
}

/// Overrides the default Tab button behavior. Avoid using values other than -1 and 0. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/tabindex)
pub fn tab_index(value: Int) -> Attribute {
  attribute("tabIndex", value)
}

/// Specifies the tooltip text for the element. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/title)
pub fn title(value: String) -> Attribute {
  attribute("title", value)
}

/// Translate of a translatable element.
pub type Translate {
  Yes
  No
}

/// Passing No excludes the element content from being translated. \
/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/translate)
pub fn translate(value: Translate) -> Attribute {
  let value = case value {
    Yes -> "yes"
    No -> "no"
  }
  attribute("translate", value)
}

/// Type of an `input`. Value can be
/// [`"button"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/button),
/// [`"checkbox"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/checkbox),
/// [`"color"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/color),
/// [`"date"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/date),
/// [`"datetime-local"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/datetime-local),
/// [`"email"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/email),
/// [`"file"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/file),
/// [`"hidden"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/hidden),
/// [`"image"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/image),
/// [`"month"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/month),
/// [`"number"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/number),
/// [`"password"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/password),
/// [`"radio"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/radio),
/// [`"range"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/range),
/// [`"reset"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/reset),
/// [`"search"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/search),
/// [`"submit"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/submit),
/// [`"tel"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/tel),
/// [`"text"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/text),
/// [`"time"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/time),
/// [`"url"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/url), or
/// [`"week"`](https://developer.mozilla.org/docs/Web/HTML/Element/input/week).
pub fn type_(name: String) -> Attribute {
  attribute("type", name)
}

/// [Input Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/input#value) \
/// [Button Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#value)
pub fn value(val: String) -> Attribute {
  attribute("value", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/input#checked)
pub fn checked(is_checked: Bool) -> Attribute {
  attribute("checked", is_checked)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/part)
pub fn part(values: List(String)) -> Attribute {
  attribute("part", string.join(values, " "))
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/popover)
pub fn popover(value: String) -> Attribute {
  attribute("popover", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/placeholder)
pub fn placeholder(text: String) -> Attribute {
  attribute("placeholder", text)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/option#selected)
pub fn selected(is_selected: Bool) -> Attribute {
  attribute("selected", is_selected)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/accept)
pub fn accept(types: List(String)) -> Attribute {
  attribute("accept", string.join(types, " "))
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/acceptCharset)
pub fn accept_charset(types: List(String)) -> Attribute {
  attribute("acceptCharset", string.join(types, " "))
}

pub fn msg(uri: String) -> Attribute {
  attribute("msg", uri)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/autocomplete)
pub fn autocomplete(name: String) -> Attribute {
  attribute("autocomplete", name)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Global_attributes/autofocus)
pub fn autofocus(should_autofocus: Bool) -> Attribute {
  attribute("autofocus", should_autofocus)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/disabled)
pub fn disabled(is_disabled: Bool) -> Attribute {
  attribute("disabled", is_disabled)
}

/// [`<meta>` Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/meta/name) \
/// [`<form>` Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/name)
pub fn name(name: String) -> Attribute {
  attribute("name", name)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/pattern)
pub fn pattern(regex: String) -> Attribute {
  attribute("pattern", regex)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/readonly)
pub fn readonly(is_readonly: Bool) -> Attribute {
  attribute("readonly", is_readonly)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/required)
pub fn required(is_required: Bool) -> Attribute {
  attribute("required", is_required)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/max)
pub fn max(val: String) -> Attribute {
  attribute("max", val)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/maxlength)
pub fn max_length(value: String) -> Attribute {
  attribute("maxLength", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/min)
pub fn min(val: String) -> Attribute {
  attribute("min", val)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/minlength)
pub fn min_length(value: String) -> Attribute {
  attribute("minLength", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/step)
pub fn step(val: String) -> Attribute {
  attribute("step", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLTextAreaElement/cols)
pub fn cols(val: Int) -> Attribute {
  attribute("cols", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLTextAreaElement/rows)
pub fn rows(val: Int) -> Attribute {
  attribute("rows", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLTextAreaElement/wrap)
pub fn wrap(mode: String) -> Attribute {
  attribute("wrap", mode)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLAnchorElement/download)
pub fn download(filename: String) -> Attribute {
  attribute("download", filename)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Attributes/rel)
pub fn rel(relationship: String) -> Attribute {
  attribute("rel", relationship)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLObjectElement/height)
pub fn height(val: Int) -> Attribute {
  attribute("height", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLObjectElement/width)
pub fn width(val: Int) -> Attribute {
  attribute("width", val)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLMediaElement/autoplay)
pub fn autoplay(should_autoplay: Bool) -> Attribute {
  attribute("autoplay", should_autoplay)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/size)
pub fn size(value: Int) -> Attribute {
  attribute("size", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLMediaElement/controls)
pub fn controls(visible: Bool) -> Attribute {
  attribute("controls", visible)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLMediaElement/loop)
pub fn loop(should_loop: Bool) -> Attribute {
  attribute("loop", should_loop)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/action)
pub fn action(url: String) -> Attribute {
  attribute("action", url)
}

/// [Documentation](https://react.dev/reference/react-dom/components/form#handle-form-submission-on-the-client)
pub fn action_(handler: fn(FormData) -> Nil) -> Attribute {
  attribute("action", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/enctype)
pub fn enctype(value: String) -> Attribute {
  attribute("enctype", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/method)
pub fn method(method: String) -> Attribute {
  attribute("method", method)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLFormElement/novalidate)
pub fn novalidate(value: Bool) -> Attribute {
  attribute("novalidate", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/form)
pub fn form(value: String) -> Attribute {
  attribute("form", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#formaction)
pub fn form_action(action: String) -> Attribute {
  attribute("formAction", action)
}

/// [Documentation](/// [Documentation](https://react.dev/reference/react-dom/components/form#handle-form-submission-on-the-client)
pub fn form_action_(handler: fn(FormData) -> Nil) -> Attribute {
  attribute("formAction", handler)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#formenctype)
pub fn form_enctype(value: String) -> Attribute {
  attribute("formenctype", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#formmethod)
pub fn form_method(method: String) -> Attribute {
  attribute("formmethod", method)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#formnovalidate)
pub fn form_novalidate(value: Bool) -> Attribute {
  attribute("formnovalidate", value)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button#formtarget)
pub fn form_target(target: String) -> Attribute {
  attribute("formtarget", target)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/HTMLDetailsElement/open)
pub fn open(is_open: Bool) -> Attribute {
  attribute("open", is_open)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Global_attributes/lang)
pub fn nonce(nonce: String) -> Attribute {
  attribute("nonce", nonce)
}

/// [Documentation](https://react.dev/learn/rendering-lists)
pub fn key(key: String) -> Attribute {
  attribute("key", key)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/HTMLTableCellElement/colSpan)
pub fn col_span(value: Int) -> Attribute {
  attribute("colSpan", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/API/HTMLTableCellElement/rowSpan)
pub fn row_span(value: Int) -> Attribute {
  attribute("rowSpan", value)
}

/// `none` will not appear in HTML attributes. Use it for conditional rendering.
pub fn none() -> Attribute {
  attribute("none_", Nil)
}
