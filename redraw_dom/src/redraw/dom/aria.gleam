import gleam/string
import redraw/dom/attribute.{type Attribute}
import redraw/internal/unsafe

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-expanded)
pub fn expanded(value: Bool) -> Attribute {
  let value =
    value
    |> unsafe.coerce
    |> string.lowercase
  attribute.aria("expanded", value)
}

/// [Documentation](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-disabled)
pub fn disabled(value: Bool) -> Attribute {
  let value =
    value
    |> unsafe.coerce
    |> string.lowercase
  attribute.aria("disabled", value)
}
