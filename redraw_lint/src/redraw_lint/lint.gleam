//// Runs every rule on the modules of the root package of a project.

import glance
import gleam/dict
import gleam/int
import gleam/list
import gleam/order
import glexer
import glexer/token
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/factories
import redraw_lint/loader.{type Loader}
import redraw_lint/project.{type Project}
import redraw_lint/rules/arguments
import redraw_lint/rules/components
import redraw_lint/rules/entry
import redraw_lint/rules/purity

pub fn run(project: Project) -> List(Diagnostic) {
  let #(_, diagnostics) = run_with(loader.new(project))
  diagnostics
}

/// Lints the project of the loader, and returns the loader with its cache
/// filled, to lint the next version of the sources faster.
pub fn run_with(loader: Loader) -> #(Loader, List(Diagnostic)) {
  project.root_modules(loader.project(loader))
  |> list.fold(#(loader, []), fn(state, name) {
    let #(loader, diagnostics) = lint_module(state.0, name)
    #(loader, list.append(state.1, diagnostics))
  })
}

fn lint_module(loader: Loader, name: String) -> #(Loader, List(Diagnostic)) {
  let #(loader, module) = loader.load(loader, name)
  case module {
    Error(loader.ParseError(_, path, error)) -> {
      let source = case dict.get(loader.project(loader).modules, name) {
        Ok(source) -> source.content
        Error(Nil) -> ""
      }
      #(loader, [unparsable(name, path, source, error)])
    }
    Error(loader.NotFound(_)) -> #(loader, [])
    Ok(module) -> {
      let analyses =
        list.map(module.ast.functions, fn(function) {
          factories.analyse(module, function.definition)
        })
      let #(loader, per_function) =
        list.fold(analyses, #(loader, []), fn(state, analysis) {
          let #(loader, arguments) = arguments.check(state.0, module, analysis)
          let #(loader, purity) = purity.check(loader, module, analysis)
          let attribution = components.check_attribution(module, analysis)
          #(loader, list.flatten([state.1, arguments, attribution, purity]))
        })
      let diagnostics =
        list.flatten([
          per_function,
          components.check_names(module, analyses),
          entry.check(module, analyses),
        ])
        |> list.sort(fn(a, b) {
          case int.compare(a.line, b.line) {
            order.Eq -> int.compare(a.column, b.column)
            other -> other
          }
        })
      #(loader, diagnostics)
    }
  }
}

fn unparsable(
  name: String,
  path: String,
  source: String,
  error: glance.Error,
) -> Diagnostic {
  let #(detail, location) = case error {
    glance.UnexpectedEndOfInput -> {
      let end = string_length_utf16(source)
      #("unexpected end of input", glance.Span(end, end))
    }
    glance.UnexpectedToken(token, glexer.Position(offset)) -> {
      let text = token.to_source(token)
      #(
        "unexpected `" <> text <> "`",
        glance.Span(offset, offset + string_length_utf16(text)),
      )
    }
  }
  diagnostic.new(
    rule: diagnostic.Unparsable,
    module: name,
    path:,
    source:,
    location:,
    message: "This module cannot be parsed by glance ("
      <> detail
      <> "): it is not linted.",
  )
}

@external(javascript, "./text.ffi.mjs", "length")
fn string_length_utf16(text: String) -> Int
