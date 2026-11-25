//// Command line entry point: `gleam run -m redraw_lint [--json] [root]`.
////
//// Lints the Redraw project at `root` (the current directory by default)
//// for the patterns that Fast Refresh, through `vite-plugin-redraw`, cannot
//// handle. Prints one warning per line, or a JSON array with `--json`, and
//// exits with 1 when there is at least one warning.

import argv
import gleam/int
import gleam/io
import gleam/javascript/promise.{type Promise}
import gleam/json
import gleam/list
import gleam/string
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/fs
import redraw_lint/lint
import redraw_lint/project.{type Project}

pub fn main() -> Promise(Nil) {
  let arguments = argv.load().arguments
  let as_json = list.contains(arguments, "--json")
  let root =
    arguments
    |> list.filter(fn(argument) { !string.starts_with(argument, "--") })
    |> list.first
    |> fn(root) {
      case root {
        Ok(root) -> root
        Error(Nil) -> fs.cwd()
      }
    }
  use diagnostics <- promise.map(lint_directory(root))
  case diagnostics {
    Error(error) -> {
      io.println_error("redraw_lint: " <> project.describe_error(error))
      fs.exit(2)
    }
    Ok(diagnostics) -> {
      report(diagnostics, as_json)
      case diagnostics {
        [] -> Nil
        _ -> fs.exit(1)
      }
    }
  }
}

/// Lints the project at `root`.
pub fn lint_directory(
  root: String,
) -> Promise(Result(List(Diagnostic), project.Error)) {
  use project <- promise.map(project.load(root))
  use project <- result_map(project)
  lint.run(project)
}

/// Lints a project already loaded, for callers keeping the sources in
/// memory, like a Vite plugin.
pub fn lint_project(project: Project) -> List(Diagnostic) {
  lint.run(project)
}

/// The diagnostics as a JSON array of `{rule, module, path, line, column,
/// message}` objects.
pub fn to_json(diagnostics: List(Diagnostic)) -> String {
  json.array(diagnostics, diagnostic.to_json) |> json.to_string
}

fn report(diagnostics: List(Diagnostic), as_json: Bool) -> Nil {
  case as_json {
    True -> io.println(to_json(diagnostics))
    False -> {
      list.each(diagnostics, fn(diagnostic) {
        io.println(diagnostic.format(diagnostic))
        io.println("")
      })
      case list.length(diagnostics) {
        0 -> io.println("No Fast Refresh warning.")
        1 -> io.println("1 Fast Refresh warning.")
        n -> io.println(int.to_string(n) <> " Fast Refresh warnings.")
      }
    }
  }
}

fn result_map(result: Result(a, e), next: fn(a) -> b) -> Result(b, e) {
  case result {
    Ok(value) -> Ok(next(value))
    Error(error) -> Error(error)
  }
}
