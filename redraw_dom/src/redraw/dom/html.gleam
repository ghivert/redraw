//// All built-in browser components, such as `<div>`, `<span>`, etc. support
//// common attributes and events. \
//// To stay compatible with the Lustre API, Redraw defines the entire set of
//// HTML elements. They're instantiated with JSX under-the-hood, and requires
//// a modern runtime to get them working.
////
//// [Find detailed documentation on MDN](https://developer.mozilla.org/docs/Web/HTML/Element).

import redraw.{type Component}
import redraw/dom/attribute.{type Attribute}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Reference/Elements)
pub fn element(
  tag: String,
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx(tag, attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/html)
pub fn html(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("html", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/link)
pub fn link(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("link", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meta)
pub fn meta(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("meta", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/script)
pub fn script(attrs: List(Attribute), script: String) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("script", attrs, [text(script)])
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/style)
pub fn style(attrs: List(Attribute), content) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("style", attrs, [text(content)])
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/title)
pub fn title(attrs: List(Attribute), content) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("title", attrs, [text(content)])
}

/// Empty node. Does not render anything in the DOM.
pub fn none() -> Component {
  redraw.jsx("none_", Nil, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Text)
pub fn text(content: String) -> Component {
  redraw.jsx("text_", Nil, content)
}

// DOM nodes

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/a)
pub fn a(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("a", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/abbr)
pub fn abbr(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("abbr", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/address)
pub fn address(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("address", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/area)
pub fn area(attrs) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("area", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/article)
pub fn article(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("article", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/aside)
pub fn aside(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("aside", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/audio)
pub fn audio(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("audio", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/b)
pub fn b(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("b", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/base)
pub fn base(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("base", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdi)
pub fn bdi(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("bdi", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdo)
pub fn bdo(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("bdo", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/blockquote)
pub fn blockquote(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("blockquote", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/body)
pub fn body(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("body", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/br)
pub fn br(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("br", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button)
pub fn button(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("button", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/canvas)
pub fn canvas(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("canvas", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/caption)
pub fn caption(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("caption", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/cite)
pub fn cite(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("cite", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/code)
pub fn code(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("code", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/col)
pub fn col(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("col", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/colgroup)
pub fn colgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("colgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/data)
pub fn data(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("data", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/datalist)
pub fn datalist(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("datalist", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dd)
pub fn dd(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("dd", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/del)
pub fn del(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("del", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/details)
pub fn details(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("details", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dfn)
pub fn dfn(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("dfn", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dialog)
pub fn dialog(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("dialog", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/div)
pub fn div(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("div", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dl)
pub fn dl(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("dl", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dt)
pub fn dt(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("dt", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/em)
pub fn em(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("em", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/embed)
pub fn embed(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("embed", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/fieldset)
pub fn fieldset(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("fieldset", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figcaption)
pub fn figcaption(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("figcaption", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figure)
pub fn figure(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("figure", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/footer)
pub fn footer(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("footer", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/form)
pub fn form(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("form", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h1)
pub fn h1(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h1", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h2)
pub fn h2(attrs: List(Attribute), children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h2", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h3)
pub fn h3(attrs: List(Attribute), children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h3", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h4)
pub fn h4(attrs: List(Attribute), children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h4", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h5)
pub fn h5(attrs: List(Attribute), children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h5", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h6)
pub fn h6(attrs: List(Attribute), children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h6", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/head)
pub fn head(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("head", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/header)
pub fn header(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("header", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hgroup)
pub fn hgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("hgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hr)
pub fn hr(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("hr", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/i)
pub fn i(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("i", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/iframe)
pub fn iframe(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("iframe", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/img)
pub fn img(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("img", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/input)
pub fn input(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("input", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ins)
pub fn ins(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("ins", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/kbd)
pub fn kbd(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("kbd", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/label)
pub fn label(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("label", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/legend)
pub fn legend(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("legend", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/li)
pub fn li(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("li", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/main)
pub fn main(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("main", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/map)
pub fn map(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("map", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/mark)
pub fn mark(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("mark", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/menu)
pub fn menu(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("menu", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meter)
pub fn meter(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("meter", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/nav)
pub fn nav(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("nav", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/noscript)
pub fn noscript(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("noscript", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/object)
pub fn object(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("object", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ol)
pub fn ol(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("ol", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/optgroup)
pub fn optgroup(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("optgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/option)
pub fn option(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("option", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/output)
pub fn output(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("output", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/p)
pub fn p(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("p", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/picture)
pub fn picture(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("picture", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/pre)
pub fn pre(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("pre", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/progress)
pub fn progress(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("progress", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/q)
pub fn q(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("q", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rp)
pub fn rp(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("rp", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rt)
pub fn rt(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("rt", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ruby)
pub fn ruby(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("ruby", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/s)
pub fn s(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("s", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/samp)
pub fn samp(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("samp", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/section)
pub fn section(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("section", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/select)
pub fn select(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("select", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/slot)
pub fn slot(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("slot", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/small)
pub fn small(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("small", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/source)
pub fn source(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("source", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/span)
pub fn span(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("span", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/strong)
pub fn strong(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("strong", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sub)
pub fn sub(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("sub", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/summary)
pub fn summary(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("summary", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sup)
pub fn sup(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("sup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/table)
pub fn table(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("table", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tbody)
pub fn tbody(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("tbody", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/td)
pub fn td(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("td", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/template)
pub fn template(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("template", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/textarea)
pub fn textarea(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("textarea", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tfoot)
pub fn tfoot(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("tfoot", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/th)
pub fn th(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("th", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/thead)
pub fn thead(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("thead", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/time)
pub fn time(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("time", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tr)
pub fn tr(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("tr", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/track)
pub fn track(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("track", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/u)
pub fn u(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("u", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ul)
pub fn ul(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("ul", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/var)
pub fn var(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("var", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/video)
pub fn video(attrs: List(Attribute), children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("video", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/wbr)
pub fn wbr(attrs: List(Attribute)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("wbr", attrs, Nil)
}

// TODO expose it later
@external(javascript, "../../attribute.ffi.mjs", "toProps")
@internal
pub fn to_props(attrs: List(Attribute)) -> b
