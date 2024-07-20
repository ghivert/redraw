import gleam/dynamic.{type Dynamic}

pub type Attribute {
  Attribute(key: String, content: Dynamic)
}

@external(javascript, "../../react.ffi.mjs", "toProps")
pub fn to_props(attrs: List(Attribute)) -> a

pub fn attribute(key: String, content: a) {
  Attribute(key: key, content: dynamic.from(content))
}
