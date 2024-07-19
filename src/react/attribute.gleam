import gleam/dynamic
import react/internals/attribute.{Attribute}

pub type Attribute =
  attribute.Attribute

pub fn href(url: String) {
  Attribute("href", dynamic.from(url))
}

pub fn target(value: String) {
  Attribute("target", dynamic.from(value))
}

pub fn src(value: String) {
  Attribute("src", dynamic.from(value))
}

pub fn class(value: String) {
  Attribute("className", dynamic.from(value))
}

pub fn alt(value: String) {
  Attribute("alt", dynamic.from(value))
}
