import glance
import gleam/int
import gleam/json.{type Json}
import redraw_lint/text

pub type Rule {
  /// A factory parameter is a function.
  FunctionArgument
  /// A factory parameter is a type declared without constructors.
  ExternalArgument
  /// A factory parameter has no type annotation.
  UnannotatedArgument
  /// `component_` is called with a render that is not a function literal, or
  /// inside an anonymous function.
  UnattributedComponent
  /// Two components of a module share a name.
  DuplicateComponentName
  /// The module defining `main` exports something else than `main` and
  /// factories.
  EntryExport
  /// A factory calls an external function.
  ImpureFactory
  /// A module of the project cannot be parsed.
  Unparsable
}

pub type Diagnostic {
  Diagnostic(
    rule: Rule,
    module: String,
    path: String,
    /// Line and column of the start, both starting at 1.
    line: Int,
    column: Int,
    /// Offsets of the code concerned in the source, as produced by glance:
    /// UTF-16 code unit indices on JavaScript.
    start: Int,
    end: Int,
    message: String,
  )
}

/// A diagnostic on the code at `location` in `source`.
pub fn new(
  rule rule: Rule,
  module module: String,
  path path: String,
  source source: String,
  location location: glance.Span,
  message message: String,
) -> Diagnostic {
  let #(line, column) = text.position(source, location.start)
  Diagnostic(
    rule:,
    module:,
    path:,
    line:,
    column:,
    start: location.start,
    end: location.end,
    message:,
  )
}

pub fn code(rule: Rule) -> String {
  case rule {
    FunctionArgument -> "factory-function-argument"
    ExternalArgument -> "factory-external-argument"
    UnannotatedArgument -> "factory-unannotated-argument"
    UnattributedComponent -> "component-not-inline"
    DuplicateComponentName -> "duplicate-component-name"
    EntryExport -> "entry-module-export"
    ImpureFactory -> "impure-factory"
    Unparsable -> "unparsable-module"
  }
}

pub fn format(diagnostic: Diagnostic) -> String {
  let Diagnostic(rule:, path:, line:, column:, message:, ..) = diagnostic
  path
  <> ":"
  <> int.to_string(line)
  <> ":"
  <> int.to_string(column)
  <> ": warning["
  <> code(rule)
  <> "] "
  <> message
}

pub fn to_json(diagnostic: Diagnostic) -> Json {
  let Diagnostic(rule:, module:, path:, line:, column:, message:, ..) =
    diagnostic
  json.object([
    #("rule", json.string(code(rule))),
    #("module", json.string(module)),
    #("path", json.string(path)),
    #("line", json.int(line)),
    #("column", json.int(column)),
    #("message", json.string(message)),
  ])
}
