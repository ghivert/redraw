//// The messages of the Language Server Protocol the server understands,
//// and the conversion of diagnostics to LSP diagnostics.

import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode.{type Decoder}
import gleam/int
import gleam/json.{type Json}
import gleam/list
import gleam/option.{type Option, None}
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/text

pub type Id {
  IntId(Int)
  StringId(String)
}

pub type Envelope {
  Envelope(id: Option(Id), method: Option(String), params: Dynamic)
}

pub fn envelope() -> Decoder(Envelope) {
  let id =
    decode.one_of(decode.map(decode.int, IntId), [
      decode.map(decode.string, StringId),
    ])
  use id <- decode.optional_field("id", None, decode.optional(id))
  use method <- decode.optional_field(
    "method",
    None,
    decode.optional(decode.string),
  )
  use params <- decode.optional_field("params", dynamic.nil(), decode.dynamic)
  decode.success(Envelope(id:, method:, params:))
}

/// The root folder of `initialize`, if any.
pub fn root_uri() -> Decoder(Option(String)) {
  use root <- decode.optional_field(
    "rootUri",
    None,
    decode.optional(decode.string),
  )
  decode.success(root)
}

pub fn text_document_uri() -> Decoder(String) {
  decode.at(["textDocument", "uri"], decode.string)
}

/// The URI and text of `textDocument/didOpen`.
pub fn did_open() -> Decoder(#(String, String)) {
  use uri <- decode.subfield(["textDocument", "uri"], decode.string)
  use text <- decode.subfield(["textDocument", "text"], decode.string)
  decode.success(#(uri, text))
}

/// The URI and the new text of `textDocument/didChange`, with full
/// synchronization: the last change holds the whole document.
pub fn did_change() -> Decoder(#(String, String)) {
  use uri <- decode.subfield(["textDocument", "uri"], decode.string)
  use changes <- decode.field(
    "contentChanges",
    decode.list(decode.at(["text"], decode.string)),
  )
  case list.last(changes) {
    Ok(text) -> decode.success(#(uri, text))
    Error(Nil) -> decode.failure(#(uri, ""), "contentChanges")
  }
}

pub fn id_to_json(id: Id) -> Json {
  case id {
    IntId(id) -> json.int(id)
    StringId(id) -> json.string(id)
  }
}

pub fn response(id: Id, result: Json) -> String {
  json.object([
    #("jsonrpc", json.string("2.0")),
    #("id", id_to_json(id)),
    #("result", result),
  ])
  |> json.to_string
}

pub fn error_response(id: Id, code: Int, message: String) -> String {
  json.object([
    #("jsonrpc", json.string("2.0")),
    #("id", id_to_json(id)),
    #(
      "error",
      json.object([
        #("code", json.int(code)),
        #("message", json.string(message)),
      ]),
    ),
  ])
  |> json.to_string
}

pub fn notification(method: String, params: Json) -> String {
  json.object([
    #("jsonrpc", json.string("2.0")),
    #("method", json.string(method)),
    #("params", params),
  ])
  |> json.to_string
}

pub fn capabilities(version: String) -> Json {
  json.object([
    #(
      "capabilities",
      json.object([
        #(
          "textDocumentSync",
          json.object([
            #("openClose", json.bool(True)),
            // Full synchronization: every change sends the whole document.
            #("change", json.int(1)),
          ]),
        ),
      ]),
    ),
    #(
      "serverInfo",
      json.object([
        #("name", json.string("redraw_lint")),
        #("version", json.string(version)),
      ]),
    ),
  ])
}

/// A `window/logMessage` notification. `kind`: 1 error, 2 warning, 3 info.
pub fn log(kind: Int, message: String) -> String {
  notification(
    "window/logMessage",
    json.object([
      #("type", json.int(kind)),
      #("message", json.string("redraw_lint: " <> message)),
    ]),
  )
}

pub fn publish(uri: String, diagnostics: List(Json)) -> String {
  notification(
    "textDocument/publishDiagnostics",
    json.object([
      #("uri", json.string(uri)),
      #("diagnostics", json.preprocessed_array(diagnostics)),
    ]),
  )
}

/// A diagnostic of the linter as an LSP warning. The range covers the code
/// concerned, cut at the end of its first line, so that a multi-line call
/// or function does not underline a whole block.
pub fn to_lsp(diagnostic: Diagnostic, source: String) -> Json {
  let end = int.min(diagnostic.end, text.line_end(source, diagnostic.start))
  let end = int.max(end, diagnostic.start)
  json.object([
    #(
      "range",
      json.object([
        #("start", position(source, diagnostic.start)),
        #("end", position(source, end)),
      ]),
    ),
    // Warning.
    #("severity", json.int(2)),
    #("code", json.string(diagnostic.code(diagnostic.rule))),
    #("source", json.string("redraw_lint")),
    #("message", json.string(diagnostic.message)),
  ])
}

fn position(source: String, offset: Int) -> Json {
  let #(line, character) = text.utf16_position(source, offset)
  json.object([
    #("line", json.int(line)),
    #("character", json.int(character)),
  ])
}
