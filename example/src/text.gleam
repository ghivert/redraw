import gleam/string

/// A helper module without components, used by `button` through a helper
/// used by `example`: editing it must reach the app through both.
pub fn title(text: String) -> String {
  case string.pop_grapheme(text) {
    Ok(#(first, rest)) -> string.uppercase(first) <> rest
    Error(_) -> text
  }
}
