//// Positions in a source, from the offsets glance produces. On the
//// JavaScript target, these are UTF-16 code unit indices.

import gleam/list
import gleam/string

@external(javascript, "./text.ffi.mjs", "prefix")
fn prefix(source: String, offset: Int) -> String

/// Line and column, both starting at 1, of an offset in a source. The
/// column counts graphemes, as a reader would.
pub fn position(source: String, offset: Int) -> #(Int, Int) {
  let lines = string.split(prefix(source, offset), "\n")
  let line = list.length(lines)
  let column = case list.last(lines) {
    Ok(last) -> string.length(last) + 1
    Error(Nil) -> 1
  }
  #(line, column)
}

/// Line and character, both starting at 0, of an offset in a source, the
/// character counting UTF-16 code units, as the Language Server Protocol
/// expects by default.
@external(javascript, "./text.ffi.mjs", "utf16Position")
pub fn utf16_position(source: String, offset: Int) -> #(Int, Int)

/// Offset of the end of the line containing `offset`.
@external(javascript, "./text.ffi.mjs", "lineEnd")
pub fn line_end(source: String, offset: Int) -> Int
