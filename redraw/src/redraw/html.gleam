//// All built-in browser components, such as `<div>`, `<span>`, etc. support
//// common props and events. \
//// To stay compatible with the Lustre API, Redraw defines the entire set of
//// HTML elements. They're instantiated with JSX under-the-hood, and requires
//// a modern runtime to get them working.
////
//// [Find detailed documentation on MDN](https://developer.mozilla.org/docs/Web/HTML/Element).

import redraw.{type Component}
import redraw/internals/attribute.{to_props}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/html)
pub fn html(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("html", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/link)
pub fn link(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("link", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meta)
pub fn meta(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("meta", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/script)
pub fn script(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("script", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/style)
pub fn style(attrs, content) {
  let attrs = to_props(attrs)
  redraw.jsx("style", attrs, [text(content)])
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/title)
pub fn title(attrs, content) {
  let attrs = to_props(attrs)
  redraw.jsx("title", attrs, [text(content)])
}

/// Empty node. Does not render anything in the DOM.
pub fn none() {
  redraw.jsx("none_", Nil, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/API/Text)
pub fn text(content: String) -> Component {
  redraw.jsx("text_", Nil, content)
}

// DOM nodes

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/a)
pub fn a(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("a", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/abbr)
pub fn abbr(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("abbr", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/address)
pub fn address(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("address", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/area)
pub fn area(attrs) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("area", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/article)
pub fn article(attrs, children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("article", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/aside)
pub fn aside(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("aside", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/audio)
pub fn audio(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("audio", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/b)
pub fn b(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("b", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/base)
pub fn base(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("base", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdi)
pub fn bdi(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("bdi", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/bdo)
pub fn bdo(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("bdo", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/blockquote)
pub fn blockquote(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("blockquote", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/body)
pub fn body(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("body", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/br)
pub fn br(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("br", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/button)
pub fn button(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("button", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/canvas)
pub fn canvas(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("canvas", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/caption)
pub fn caption(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("caption", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/cite)
pub fn cite(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("cite", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/code)
pub fn code(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("code", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/col)
pub fn col(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("col", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/colgroup)
pub fn colgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("colgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/data)
pub fn data(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("data", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/datalist)
pub fn datalist(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("datalist", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dd)
pub fn dd(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dd", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/del)
pub fn del(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("del", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/details)
pub fn details(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("details", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dfn)
pub fn dfn(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dfn", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dialog)
pub fn dialog(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dialog", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/div)
pub fn div(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("div", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dl)
pub fn dl(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dl", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/dt)
pub fn dt(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dt", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/em)
pub fn em(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("em", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/embed)
pub fn embed(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("embed", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/fieldset)
pub fn fieldset(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("fieldset", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figcaption)
pub fn figcaption(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("figcaption", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/figure)
pub fn figure(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("figure", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/footer)
pub fn footer(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("footer", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/form)
pub fn form(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("form", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h1)
pub fn h1(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("h1", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h2)
pub fn h2(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h2", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h3)
pub fn h3(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h3", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h4)
pub fn h4(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h4", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h5)
pub fn h5(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h5", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/h6)
pub fn h6(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h6", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/head)
pub fn head(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("head", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/header)
pub fn header(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("header", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hgroup)
pub fn hgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("hgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/hr)
pub fn hr(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("hr", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/i)
pub fn i(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("i", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/iframe)
pub fn iframe(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("iframe", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/img)
pub fn img(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("img", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/input)
pub fn input(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("input", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ins)
pub fn ins(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ins", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/kbd)
pub fn kbd(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("kbd", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/label)
pub fn label(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("label", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/legend)
pub fn legend(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("legend", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/li)
pub fn li(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("li", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/main)
pub fn main(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("main", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/map)
pub fn map(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("map", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/mark)
pub fn mark(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("mark", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/menu)
pub fn menu(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("menu", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/meter)
pub fn meter(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("meter", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/nav)
pub fn nav(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("nav", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/noscript)
pub fn noscript(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("noscript", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/object)
pub fn object(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("object", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ol)
pub fn ol(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ol", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/optgroup)
pub fn optgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("optgroup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/option)
pub fn option(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("option", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/output)
pub fn output(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("output", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/p)
pub fn p(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("p", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/picture)
pub fn picture(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("picture", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/pre)
pub fn pre(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("pre", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/progress)
pub fn progress(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("progress", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/q)
pub fn q(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("q", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rp)
pub fn rp(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("rp", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/rt)
pub fn rt(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("rt", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ruby)
pub fn ruby(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ruby", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/s)
pub fn s(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("s", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/samp)
pub fn samp(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("samp", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/section)
pub fn section(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("section", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/select)
pub fn select(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("select", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/slot)
pub fn slot(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("slot", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/small)
pub fn small(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("small", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/source)
pub fn source(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("source", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/span)
pub fn span(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("span", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/strong)
pub fn strong(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("strong", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sub)
pub fn sub(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("sub", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/summary)
pub fn summary(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("summary", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/sup)
pub fn sup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("sup", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/table)
pub fn table(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("table", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tbody)
pub fn tbody(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tbody", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/td)
pub fn td(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("td", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/template)
pub fn template(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("template", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/textarea)
pub fn textarea(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("textarea", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tfoot)
pub fn tfoot(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tfoot", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/th)
pub fn th(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("th", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/thead)
pub fn thead(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("thead", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/time)
pub fn time(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("time", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/tr)
pub fn tr(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tr", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/track)
pub fn track(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("track", attrs, Nil)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/u)
pub fn u(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("u", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/ul)
pub fn ul(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ul", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/var)
pub fn var(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("var", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/video)
pub fn video(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("video", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/HTML/Element/wbr)
pub fn wbr(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("wbr", attrs, Nil)
}
