import gleam/javascript/promise.{type Promise}
import gleam/list
import gleam/string
import gleeunit
import redraw_lint
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/project

pub fn main() {
  gleeunit.main()
}

/// Lints a fixture project under `test/fixtures`, against the real `redraw`
/// and `redraw_dom` sources of the repository.
fn lint_fixture(name: String) -> Promise(List(#(String, String, Int))) {
  let packages = [
    #("redraw", "../redraw/src"),
    #("redraw_dom", "../redraw_dom/src"),
    #("gleam_stdlib", "build/packages/gleam_stdlib/src"),
  ]
  use project <- promise.map(project.from_directories(
    "fixture",
    "fixtures/" <> name <> "/src",
    packages,
  ))
  let assert Ok(project) = project
  redraw_lint.lint_project(project) |> summarize
}

fn summarize(diagnostics: List(Diagnostic)) -> List(#(String, String, Int)) {
  use diagnostic <- list.map(diagnostics)
  #(diagnostic.code(diagnostic.rule), diagnostic.module, diagnostic.line)
}

pub fn example_project_test() -> Promise(Nil) {
  use diagnostics <- promise.map(redraw_lint.lint_directory("../example"))
  assert diagnostics == Ok([])
}

pub fn function_argument_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("function_argument"))
  assert diagnostics
    == [
      #("factory-function-argument", "callbacks", 9),
      #("factory-function-argument", "callbacks", 15),
      #("factory-function-argument", "callbacks", 21),
    ]
}

pub fn function_argument_message_test() -> Promise(Nil) {
  use project <- promise.map(
    project.from_directories("fixture", "fixtures/function_argument/src", [
      #("redraw", "../redraw/src"),
    ]),
  )
  let assert Ok(project) = project
  let assert [_, widget, ..] = redraw_lint.lint_project(project)
  assert string.contains(widget.message, "at `config.on_click`")
  assert string.contains(widget.message, "fn() -> Nil")
  assert string.contains(widget.message, "belongs in the props")
}

pub fn external_argument_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("external_argument"))
  assert diagnostics
    == [
      #("factory-external-argument", "handles", 18),
      #("factory-external-argument", "handles", 24),
      #("factory-external-argument", "handles", 30),
      #("factory-external-argument", "handles", 36),
    ]
}

pub fn external_argument_message_test() -> Promise(Nil) {
  use project <- promise.map(
    project.from_directories("fixture", "fixtures/external_argument/src", [
      #("redraw", "../redraw/src"),
    ]),
  )
  let assert Ok(project) = project
  let assert [counter, with_deps, ..] = redraw_lint.lint_project(project)
  assert string.contains(counter.message, "`store.Store`")
  assert string.contains(
    counter.message,
    "context created there with `create_context_`",
  )
  assert string.contains(with_deps.message, "at `deps.store`")
}

pub fn attribution_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("attribution"))
  assert diagnostics
    == [
      #("component-not-inline", "wrappers", 6),
      #("component-not-inline", "wrappers", 12),
      #("component-not-inline", "wrappers", 17),
      #("component-not-inline", "wrappers", 24),
    ]
}

pub fn duplicate_names_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("duplicate_names"))
  assert diagnostics
    == [
      #("duplicate-component-name", "twins", 5),
      #("duplicate-component-name", "twins", 10),
    ]
}

pub fn entry_export_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("entry_export"))
  assert diagnostics
    == [
      #("entry-module-export", "app", 5),
      #("entry-module-export", "app", 18),
      #("entry-module-export", "app", 26),
    ]
}

pub fn impure_factory_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("impure_factory"))
  assert diagnostics
    == [
      #("impure-factory", "impure", 7),
      #("impure-factory", "impure", 15),
      #("impure-factory", "impure", 23),
    ]
}

pub fn impure_factory_message_test() -> Promise(Nil) {
  use project <- promise.map(
    project.from_directories("fixture", "fixtures/impure_factory/src", [
      #("redraw", "../redraw/src"),
    ]),
  )
  let assert Ok(project) = project
  let assert [direct, wrapped, ..] = redraw_lint.lint_project(project)
  assert string.contains(
    direct.message,
    "calls `store.create`, declared with `@external`",
  )
  assert string.contains(
    wrapped.message,
    "calls `store.wrapped`, which reaches `store.create`",
  )
}

pub fn unannotated_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("unannotated"))
  assert diagnostics == [#("factory-unannotated-argument", "button", 4)]
}

pub fn unparsable_test() -> Promise(Nil) {
  use diagnostics <- promise.map(lint_fixture("unparsable"))
  assert diagnostics == [#("unparsable-module", "broken", 1)]
}

pub fn json_test() {
  let diagnostic =
    diagnostic.Diagnostic(
      rule: diagnostic.ImpureFactory,
      module: "app",
      path: "src/app.gleam",
      line: 3,
      column: 7,
      start: 20,
      end: 25,
      message: "m",
    )
  assert redraw_lint.to_json([diagnostic])
    == "[{\"rule\":\"impure-factory\",\"module\":\"app\",\"path\":\"src/app.gleam\",\"line\":3,\"column\":7,\"message\":\"m\"}]"
}
