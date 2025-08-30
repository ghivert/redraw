//// All built-in browser components, such as `<div>`, `<span>`, etc. support
//// common attributes and events. \
//// To stay compatible with the Lustre API, Redraw defines the entire set of
//// HTML elements. They're instantiated with JSX under-the-hood, and requires
//// a modern runtime to get them working.
////
//// [Find detailed documentation on MDN](https://developer.mozilla.org/docs/Web/HTML/Element).

import redraw.{type Component}
import redraw/dom/attribute.{type Attribute}

const convert_children = True

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements)
pub fn element(
  tag: String,
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: tag, props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/html)
pub fn html(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "html", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/link)
pub fn link(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "link", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meta)
pub fn meta(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "meta", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/script)
pub fn script(attrs: List(Attribute), script: String) -> Component {
  let props = to_props(attrs)
  redraw.jsx(
    type_: "script",
    props:,
    children: [text(script)],
    convert_children:,
  )
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/style)
pub fn style(attrs: List(Attribute), content) -> Component {
  let props = to_props(attrs)
  redraw.jsx(
    type_: "style",
    props:,
    children: [text(content)],
    convert_children:,
  )
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/title)
pub fn title(attrs: List(Attribute), content) -> Component {
  let props = to_props(attrs)
  redraw.jsx(
    type_: "title",
    props:,
    children: [text(content)],
    convert_children:,
  )
}

/// Empty node. Does not render anything in the DOM.
pub fn none() -> Component {
  redraw.jsx(type_: "none_", props: Nil, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Text)
pub fn text(content: String) -> Component {
  redraw.jsx(type_: "text_", props: Nil, children: content, convert_children:)
}

// DOM nodes

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/a)
pub fn a(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "a", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/abbr)
pub fn abbr(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "abbr", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/address)
pub fn address(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "address", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/area)
pub fn area(attrs) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "area", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/article)
pub fn article(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "article", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/aside)
pub fn aside(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "aside", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/audio)
pub fn audio(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "audio", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/b)
pub fn b(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "b", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/base)
pub fn base(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "base", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdi)
pub fn bdi(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "bdi", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdo)
pub fn bdo(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "bdo", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/blockquote)
pub fn blockquote(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "blockquote", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/body)
pub fn body(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "body", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/br)
pub fn br(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "br", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button)
pub fn button(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "button", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/canvas)
pub fn canvas(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "canvas", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/caption)
pub fn caption(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "caption", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/cite)
pub fn cite(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "cite", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/code)
pub fn code(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "code", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/col)
pub fn col(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "col", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/colgroup)
pub fn colgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "colgroup", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/data)
pub fn data(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "data", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/datalist)
pub fn datalist(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "datalist", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dd)
pub fn dd(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "dd", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/del)
pub fn del(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "del", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/details)
pub fn details(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "details", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dfn)
pub fn dfn(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "dfn", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dialog)
pub fn dialog(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "dialog", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/div)
pub fn div(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "div", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dl)
pub fn dl(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "dl", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dt)
pub fn dt(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "dt", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/em)
pub fn em(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "em", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/embed)
pub fn embed(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "embed", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/fieldset)
pub fn fieldset(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "fieldset", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figcaption)
pub fn figcaption(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "figcaption", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figure)
pub fn figure(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "figure", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/footer)
pub fn footer(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "footer", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/form)
pub fn form(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "form", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h1)
pub fn h1(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h1", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h2)
pub fn h2(attrs: List(Attribute), children) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h2", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h3)
pub fn h3(attrs: List(Attribute), children) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h3", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h4)
pub fn h4(attrs: List(Attribute), children) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h4", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h5)
pub fn h5(attrs: List(Attribute), children) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h5", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h6)
pub fn h6(attrs: List(Attribute), children) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "h6", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/head)
pub fn head(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "head", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/header)
pub fn header(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "header", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hgroup)
pub fn hgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "hgroup", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hr)
pub fn hr(attrs) {
  let props = to_props(attrs)
  redraw.jsx(type_: "hr", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/i)
pub fn i(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "i", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/iframe)
pub fn iframe(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "iframe", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/img)
pub fn img(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "img", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/input)
pub fn input(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "input", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ins)
pub fn ins(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "ins", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/kbd)
pub fn kbd(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "kbd", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/label)
pub fn label(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "label", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/legend)
pub fn legend(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "legend", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/li)
pub fn li(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "li", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/main)
pub fn main(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "main", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/map)
pub fn map(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "map", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/mark)
pub fn mark(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "mark", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/menu)
pub fn menu(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "menu", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meter)
pub fn meter(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "meter", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/nav)
pub fn nav(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "nav", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/noscript)
pub fn noscript(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "noscript", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/object)
pub fn object(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "object", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ol)
pub fn ol(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "ol", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/optgroup)
pub fn optgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "optgroup", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/option)
pub fn option(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "option", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/output)
pub fn output(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "output", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/p)
pub fn p(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "p", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/picture)
pub fn picture(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "picture", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/pre)
pub fn pre(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "pre", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/progress)
pub fn progress(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "progress", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/q)
pub fn q(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "q", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rp)
pub fn rp(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "rp", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rt)
pub fn rt(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "rt", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ruby)
pub fn ruby(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "ruby", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/s)
pub fn s(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "s", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/samp)
pub fn samp(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "samp", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/section)
pub fn section(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "section", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/select)
pub fn select(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "select", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/slot)
pub fn slot(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "slot", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/small)
pub fn small(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "small", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/source)
pub fn source(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "source", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/span)
pub fn span(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "span", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/strong)
pub fn strong(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "strong", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sub)
pub fn sub(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "sub", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/summary)
pub fn summary(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "summary", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sup)
pub fn sup(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "sup", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/table)
pub fn table(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "table", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tbody)
pub fn tbody(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "tbody", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/td)
pub fn td(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "td", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/template)
pub fn template(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "template", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/textarea)
pub fn textarea(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "textarea", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tfoot)
pub fn tfoot(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "tfoot", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/th)
pub fn th(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "th", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/thead)
pub fn thead(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "thead", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/time)
pub fn time(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "time", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tr)
pub fn tr(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "tr", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/track)
pub fn track(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "track", props:, children: Nil, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/u)
pub fn u(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "u", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ul)
pub fn ul(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "ul", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/var)
pub fn var(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "var", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/video)
pub fn video(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "video", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/wbr)
pub fn wbr(attrs: List(Attribute)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "wbr", props:, children: Nil, convert_children:)
}

@external(javascript, "./html.ffi.mjs", "toProps")
pub fn to_props(attrs: List(Attribute)) -> b
