import react.{type Component}
import react/internals/attribute.{to_props}

pub fn html(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("html", attrs, children)
}

pub fn link(attrs) {
  let attrs = to_props(attrs)
  react.jsx("link", attrs, Nil)
}

pub fn meta(attrs) {
  let attrs = to_props(attrs)
  react.jsx("meta", attrs, Nil)
}

pub fn script(attrs) {
  let attrs = to_props(attrs)
  react.jsx("script", attrs, Nil)
}

pub fn style(attrs, content) {
  let attrs = to_props(attrs)
  react.jsx("style", attrs, [text(content)])
}

pub fn title(attrs, content) {
  let attrs = to_props(attrs)
  react.jsx("title", attrs, [text(content)])
}

pub fn text(content) -> Component {
  react.jsx("text_", Nil, content)
}

// DOM nodes

pub fn a(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  react.jsx("a", attrs, children)
}

pub fn abbr(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  react.jsx("abbr", attrs, children)
}

pub fn address(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  react.jsx("address", attrs, children)
}

pub fn area(attrs) -> Component {
  let attrs = to_props(attrs)
  react.jsx("area", attrs, Nil)
}

pub fn article(attrs, children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  react.jsx("article", attrs, children)
}

pub fn aside(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("aside", attrs, children)
}

pub fn audio(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("audio", attrs, children)
}

pub fn b(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("b", attrs, children)
}

pub fn base(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("base", attrs, children)
}

pub fn bdi(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("bdi", attrs, children)
}

pub fn bdo(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("bdo", attrs, children)
}

pub fn blockquote(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("blockquote", attrs, children)
}

pub fn body(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("body", attrs, children)
}

pub fn br(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("br", attrs, children)
}

pub fn button(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("button", attrs, children)
}

pub fn canvas(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("canvas", attrs, children)
}

pub fn caption(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("caption", attrs, children)
}

pub fn cite(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("cite", attrs, children)
}

pub fn code(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("code", attrs, children)
}

pub fn col(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("col", attrs, children)
}

pub fn colgroup(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("colgroup", attrs, children)
}

pub fn data(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("data", attrs, children)
}

pub fn datalist(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("datalist", attrs, children)
}

pub fn dd(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("dd", attrs, children)
}

pub fn del(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("del", attrs, children)
}

pub fn details(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("details", attrs, children)
}

pub fn dfn(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("dfn", attrs, children)
}

pub fn dialog(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("dialog", attrs, children)
}

pub fn div(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("div", attrs, children)
}

pub fn dl(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("dl", attrs, children)
}

pub fn dt(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("dt", attrs, children)
}

pub fn em(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("em", attrs, children)
}

pub fn embed(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("embed", attrs, children)
}

pub fn fieldset(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("fieldset", attrs, children)
}

pub fn figcaption(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("figcaption", attrs, children)
}

pub fn figure(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("figure", attrs, children)
}

pub fn footer(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("footer", attrs, children)
}

pub fn form(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("form", attrs, children)
}

pub fn h1(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("h1", attrs, children)
}

pub fn h2(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("h2", attrs, children)
}

pub fn h3(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("h3", attrs, children)
}

pub fn h4(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("h4", attrs, children)
}

pub fn h5(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("h5", attrs, children)
}

pub fn h6(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("h6", attrs, children)
}

pub fn head(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("head", attrs, children)
}

pub fn header(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("header", attrs, children)
}

pub fn hgroup(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("hgroup", attrs, children)
}

pub fn hr(attrs) {
  let attrs = to_props(attrs)
  react.jsx("hr", attrs, Nil)
}

pub fn i(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("i", attrs, children)
}

pub fn iframe(attrs) {
  let attrs = to_props(attrs)
  react.jsx("iframe", attrs, Nil)
}

pub fn img(attrs) {
  let attrs = to_props(attrs)
  react.jsx("img", attrs, Nil)
}

pub fn input(attrs) {
  let attrs = to_props(attrs)
  react.jsx("input", attrs, Nil)
}

pub fn ins(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("ins", attrs, children)
}

pub fn kbd(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("kbd", attrs, children)
}

pub fn label(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("label", attrs, children)
}

pub fn legend(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("legend", attrs, children)
}

pub fn li(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("li", attrs, children)
}

pub fn main(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("main", attrs, children)
}

pub fn map(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("map", attrs, children)
}

pub fn mark(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("mark", attrs, children)
}

pub fn menu(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("menu", attrs, children)
}

pub fn meter(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("meter", attrs, children)
}

pub fn nav(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("nav", attrs, children)
}

pub fn noscript(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("noscript", attrs, children)
}

pub fn object(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("object", attrs, children)
}

pub fn ol(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("ol", attrs, children)
}

pub fn optgroup(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("optgroup", attrs, children)
}

pub fn option(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("option", attrs, children)
}

pub fn output(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("output", attrs, children)
}

pub fn p(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("p", attrs, children)
}

pub fn picture(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("picture", attrs, children)
}

pub fn pre(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("pre", attrs, children)
}

pub fn progress(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("progress", attrs, children)
}

pub fn q(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("q", attrs, children)
}

pub fn rp(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("rp", attrs, children)
}

pub fn rt(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("rt", attrs, children)
}

pub fn ruby(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("ruby", attrs, children)
}

pub fn s(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("s", attrs, children)
}

pub fn samp(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("samp", attrs, children)
}

pub fn section(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("section", attrs, children)
}

pub fn select(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("select", attrs, children)
}

pub fn slot(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("slot", attrs, children)
}

pub fn small(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("small", attrs, children)
}

pub fn source(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("source", attrs, children)
}

pub fn span(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("span", attrs, children)
}

pub fn strong(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("strong", attrs, children)
}

pub fn sub(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("sub", attrs, children)
}

pub fn summary(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("summary", attrs, children)
}

pub fn sup(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("sup", attrs, children)
}

pub fn table(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("table", attrs, children)
}

pub fn tbody(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("tbody", attrs, children)
}

pub fn td(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("td", attrs, children)
}

pub fn template(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("template", attrs, children)
}

pub fn textarea(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("textarea", attrs, children)
}

pub fn tfoot(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("tfoot", attrs, children)
}

pub fn th(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("th", attrs, children)
}

pub fn thead(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("thead", attrs, children)
}

pub fn time(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("time", attrs, children)
}

pub fn tr(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("tr", attrs, children)
}

pub fn track(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("track", attrs, children)
}

pub fn u(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("u", attrs, children)
}

pub fn ul(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("ul", attrs, children)
}

pub fn var(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("var", attrs, children)
}

pub fn video(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("video", attrs, children)
}

pub fn wbr(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("wbr", attrs, children)
}
