import redraw.{type Component}
import redraw/internals/attribute.{to_props}

pub fn html(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("html", attrs, children)
}

pub fn link(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("link", attrs, Nil)
}

pub fn meta(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("meta", attrs, Nil)
}

pub fn script(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("script", attrs, Nil)
}

pub fn style(attrs, content) {
  let attrs = to_props(attrs)
  redraw.jsx("style", attrs, [text(content)])
}

pub fn title(attrs, content) {
  let attrs = to_props(attrs)
  redraw.jsx("title", attrs, [text(content)])
}

pub fn none() {
  redraw.jsx("none_", Nil, Nil)
}

pub fn text(content: String) -> Component {
  redraw.jsx("text_", Nil, content)
}

// DOM nodes

pub fn a(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("a", attrs, children)
}

pub fn abbr(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("abbr", attrs, children)
}

pub fn address(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("address", attrs, children)
}

pub fn area(attrs) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("area", attrs, Nil)
}

pub fn article(attrs, children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("article", attrs, children)
}

pub fn aside(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("aside", attrs, children)
}

pub fn audio(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("audio", attrs, children)
}

pub fn b(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("b", attrs, children)
}

pub fn base(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("base", attrs, Nil)
}

pub fn bdi(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("bdi", attrs, children)
}

pub fn bdo(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("bdo", attrs, children)
}

pub fn blockquote(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("blockquote", attrs, children)
}

pub fn body(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("body", attrs, children)
}

pub fn br(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("br", attrs, Nil)
}

pub fn button(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("button", attrs, children)
}

pub fn canvas(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("canvas", attrs, children)
}

pub fn caption(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("caption", attrs, children)
}

pub fn cite(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("cite", attrs, children)
}

pub fn code(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("code", attrs, children)
}

pub fn col(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("col", attrs, Nil)
}

pub fn colgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("colgroup", attrs, children)
}

pub fn data(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("data", attrs, children)
}

pub fn datalist(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("datalist", attrs, children)
}

pub fn dd(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dd", attrs, children)
}

pub fn del(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("del", attrs, children)
}

pub fn details(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("details", attrs, children)
}

pub fn dfn(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dfn", attrs, children)
}

pub fn dialog(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dialog", attrs, children)
}

pub fn div(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("div", attrs, children)
}

pub fn dl(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dl", attrs, children)
}

pub fn dt(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("dt", attrs, children)
}

pub fn em(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("em", attrs, children)
}

pub fn embed(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("embed", attrs, Nil)
}

pub fn fieldset(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("fieldset", attrs, children)
}

pub fn figcaption(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("figcaption", attrs, children)
}

pub fn figure(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("figure", attrs, children)
}

pub fn footer(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("footer", attrs, children)
}

pub fn form(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("form", attrs, children)
}

pub fn h1(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("h1", attrs, children)
}

pub fn h2(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h2", attrs, children)
}

pub fn h3(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h3", attrs, children)
}

pub fn h4(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h4", attrs, children)
}

pub fn h5(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h5", attrs, children)
}

pub fn h6(attrs, children) -> Component {
  let attrs = to_props(attrs)
  redraw.jsx("h6", attrs, children)
}

pub fn head(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("head", attrs, children)
}

pub fn header(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("header", attrs, children)
}

pub fn hgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("hgroup", attrs, children)
}

pub fn hr(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("hr", attrs, Nil)
}

pub fn i(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("i", attrs, children)
}

pub fn iframe(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("iframe", attrs, Nil)
}

pub fn img(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("img", attrs, Nil)
}

pub fn input(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("input", attrs, Nil)
}

pub fn ins(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ins", attrs, children)
}

pub fn kbd(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("kbd", attrs, children)
}

pub fn label(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("label", attrs, children)
}

pub fn legend(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("legend", attrs, children)
}

pub fn li(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("li", attrs, children)
}

pub fn main(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("main", attrs, children)
}

pub fn map(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("map", attrs, children)
}

pub fn mark(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("mark", attrs, children)
}

pub fn menu(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("menu", attrs, children)
}

pub fn meter(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("meter", attrs, children)
}

pub fn nav(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("nav", attrs, children)
}

pub fn noscript(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("noscript", attrs, children)
}

pub fn object(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("object", attrs, children)
}

pub fn ol(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ol", attrs, children)
}

pub fn optgroup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("optgroup", attrs, children)
}

pub fn option(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("option", attrs, children)
}

pub fn output(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("output", attrs, children)
}

pub fn p(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("p", attrs, children)
}

pub fn picture(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("picture", attrs, children)
}

pub fn pre(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("pre", attrs, children)
}

pub fn progress(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("progress", attrs, children)
}

pub fn q(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("q", attrs, children)
}

pub fn rp(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("rp", attrs, children)
}

pub fn rt(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("rt", attrs, children)
}

pub fn ruby(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ruby", attrs, children)
}

pub fn s(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("s", attrs, children)
}

pub fn samp(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("samp", attrs, children)
}

pub fn section(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("section", attrs, children)
}

pub fn select(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("select", attrs, children)
}

pub fn slot(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("slot", attrs, children)
}

pub fn small(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("small", attrs, children)
}

pub fn source(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("source", attrs, Nil)
}

pub fn span(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("span", attrs, children)
}

pub fn strong(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("strong", attrs, children)
}

pub fn sub(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("sub", attrs, children)
}

pub fn summary(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("summary", attrs, children)
}

pub fn sup(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("sup", attrs, children)
}

pub fn table(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("table", attrs, children)
}

pub fn tbody(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tbody", attrs, children)
}

pub fn td(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("td", attrs, children)
}

pub fn template(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("template", attrs, children)
}

pub fn textarea(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("textarea", attrs, children)
}

pub fn tfoot(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tfoot", attrs, children)
}

pub fn th(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("th", attrs, children)
}

pub fn thead(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("thead", attrs, children)
}

pub fn time(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("time", attrs, children)
}

pub fn tr(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tr", attrs, children)
}

pub fn track(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("track", attrs, Nil)
}

pub fn u(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("u", attrs, children)
}

pub fn ul(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ul", attrs, children)
}

pub fn var(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("var", attrs, children)
}

pub fn video(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("video", attrs, children)
}

pub fn wbr(attrs) {
  let attrs = to_props(attrs)
  redraw.jsx("wbr", attrs, Nil)
}
