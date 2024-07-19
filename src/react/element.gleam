import react.{type Component}

pub fn div(attrs, children: List(Component)) -> Component {
  react.jsx("div", attrs, children)
}

pub fn a(attrs, children: List(Component)) -> Component {
  react.jsx("a", attrs, children)
}

pub fn img(attrs) -> Component {
  react.jsx("img", attrs, [])
}

pub fn text(content) -> Component {
  react.jsx("text_", Nil, content)
}
