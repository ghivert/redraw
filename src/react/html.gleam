import react.{type Component}
import react/internals/attribute.{to_props}

pub fn div(attrs, children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  react.jsx("div", attrs, children)
}

pub fn a(attrs, children: List(Component)) -> Component {
  let attrs = to_props(attrs)
  react.jsx("a", attrs, children)
}

pub fn img(attrs) -> Component {
  let attrs = to_props(attrs)
  react.jsx("img", attrs, Nil)
}

pub fn h1(attrs, children) -> Component {
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

pub fn button(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("button", attrs, children)
}

pub fn p(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("p", attrs, children)
}

pub fn pre(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("pre", attrs, children)
}

pub fn code(attrs, children) -> Component {
  let attrs = to_props(attrs)
  react.jsx("code", attrs, children)
}

pub fn text(content) -> Component {
  react.jsx("text_", Nil, content)
}
