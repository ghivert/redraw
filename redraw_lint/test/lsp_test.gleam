import gleam/json
import gleam/string
import redraw_lint/diagnostic
import redraw_lint/lsp/protocol
import redraw_lint/text

fn diagnostic_at(source: String, start: Int, end: Int) {
  diagnostic.Diagnostic(
    rule: diagnostic.ImpureFactory,
    module: "app",
    path: "/app/src/app.gleam",
    line: 1,
    column: 1,
    start:,
    end:,
    message: "m",
  )
  |> protocol.to_lsp(source)
  |> json.to_string
}

pub fn utf16_position_test() {
  // "😀" is two UTF-16 code units, and one grapheme.
  let source = "// é😀\nlet x = \"😀\" |> f\n"
  let offset = 7 + 13
  assert text.utf16_position(source, offset) == #(1, 13)
  assert text.position(source, offset) == #(2, 13)
}

pub fn range_is_cut_at_the_end_of_the_first_line_test() {
  let source = "fn a() {\n  b()\n}\n"
  let lsp = diagnostic_at(source, 0, string.length(source))
  assert string.contains(
    lsp,
    "\"range\":{\"start\":{\"line\":0,\"character\":0},\"end\":{\"line\":0,\"character\":8}}",
  )
  assert string.contains(lsp, "\"code\":\"impure-factory\"")
  assert string.contains(lsp, "\"severity\":2")
}
