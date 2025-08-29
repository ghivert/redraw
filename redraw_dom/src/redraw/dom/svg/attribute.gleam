import redraw/dom/attribute.{type Attribute, attribute}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Reference/Attribute/viewBox)
pub fn viewbox(viewbox: String) -> Attribute {
  attribute("viewBox", viewbox)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Attribute/fill)
pub fn fill(fill: String) -> Attribute {
  attribute("fill", fill)
}
