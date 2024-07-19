import gleam/dynamic.{type Dynamic}

pub type Attribute {
  Attribute(key: String, content: Dynamic)
}

@external(javascript, "../../react.ffi.mjs", "toProps")
pub fn to_props(attrs: List(Attribute)) -> a
