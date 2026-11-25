//// Language server publishing the warnings of the linter, for editors:
//// `gleam run -m redraw_lint/lsp`, speaking the Language Server Protocol on
//// stdin and stdout. It runs next to the Gleam language server, and only
//// publishes diagnostics.
////
//// Projects are found from the files the editor opens: the closest
//// directory with a `gleam.toml` that lists `redraw_lint` in its
//// dependencies. Other Gleam projects, such as the libraries a project
//// depends on, are left alone. A project is read from disk once; then the
//// buffers of the editor replace the files, saved or not. The whole root
//// package is linted again after every change, since a change in a type can
//// raise a warning in another module, once the editor has been quiet for a
//// moment. Parsing results are cached, so only changed modules are parsed.

import gleam/dict.{type Dict}
import gleam/dynamic/decode
import gleam/javascript/promise.{type Promise}
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/set.{type Set}
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/fs
import redraw_lint/lint
import redraw_lint/loader.{type Loader}
import redraw_lint/lsp/protocol.{Envelope}
import redraw_lint/lsp/transport
import redraw_lint/project.{type Project}

const version = "0.1.0"

/// Delay without message before linting, in milliseconds.
const debounce = 150

const package = "redraw_lint"

type State {
  State(
    /// Loaded projects, by root directory.
    projects: Dict(String, Workspace),
    /// Root directories of projects not linted since their last change.
    pending: Set(String),
    /// Root directories found without the linter, not to look up again.
    ignored: Set(String),
  )
}

type Workspace {
  Workspace(
    project: Project,
    loader: Loader,
    /// Files with published diagnostics, to clear when they are fixed.
    published: Set(String),
  )
}

pub fn main() -> Promise(Nil) {
  transport.start()
  loop(State(projects: dict.new(), pending: set.new(), ignored: set.new()))
}

fn loop(state: State) -> Promise(Nil) {
  let timeout = case set.is_empty(state.pending) {
    True -> -1
    False -> debounce
  }
  use incoming <- promise.await(transport.read(timeout))
  case incoming {
    transport.Closed -> promise.resolve(fs.exit(0))
    transport.Timeout -> loop(lint_pending(state))
    transport.Message(text) ->
      case json.parse(text, protocol.envelope()) {
        Ok(envelope) -> handle(state, envelope) |> promise.await(loop)
        Error(_) -> {
          transport.send(protocol.log(1, "cannot decode a message"))
          loop(state)
        }
      }
  }
}

fn handle(state: State, envelope: protocol.Envelope) -> Promise(State) {
  let Envelope(id:, method:, params:) = envelope
  case method, id {
    Some("initialize"), Some(id) -> {
      transport.send(protocol.response(id, protocol.capabilities(version)))
      case decode.run(params, protocol.root_uri()) {
        Ok(Some(uri)) ->
          case transport.uri_to_path(uri) {
            Ok(root) -> open_project(state, fs.resolve(root))
            Error(Nil) -> promise.resolve(state)
          }
        _ -> promise.resolve(state)
      }
    }
    Some("shutdown"), Some(id) -> {
      transport.send(protocol.response(id, json.null()))
      promise.resolve(state)
    }
    Some("exit"), _ -> {
      fs.exit(0)
      promise.resolve(state)
    }
    Some("textDocument/didOpen"), None ->
      case decode.run(params, protocol.did_open()) {
        Ok(#(uri, text)) -> update(state, uri, Some(text))
        Error(_) -> promise.resolve(state)
      }
    Some("textDocument/didChange"), None ->
      case decode.run(params, protocol.did_change()) {
        Ok(#(uri, text)) -> update(state, uri, Some(text))
        Error(_) -> promise.resolve(state)
      }
    // A closed buffer goes back to the file on disk.
    Some("textDocument/didClose"), None ->
      case decode.run(params, protocol.text_document_uri()) {
        Ok(uri) -> update(state, uri, None)
        Error(_) -> promise.resolve(state)
      }
    Some(method), Some(id) -> {
      transport.send(protocol.error_response(
        id,
        -32_601,
        "method not supported: " <> method,
      ))
      promise.resolve(state)
    }
    _, _ -> promise.resolve(state)
  }
}

/// Applies the content of a buffer, or of the file on disk with `None`, to
/// every project containing the file, loading its project first if needed.
fn update(
  state: State,
  uri: String,
  content: Option(String),
) -> Promise(State) {
  case transport.uri_to_path(uri) {
    Error(Nil) -> promise.resolve(state)
    Ok(path) -> {
      let path = fs.resolve(path)
      use state <- promise.await(ensure_project(state, path))
      use content <- promise.map(case content {
        Some(content) -> promise.resolve(Ok(content))
        None -> fs.read_file(path)
      })
      case content {
        Error(_) -> state
        Ok(content) -> apply(state, path, content)
      }
    }
  }
}

fn apply(state: State, path: String, content: String) -> State {
  dict.fold(state.projects, state, fn(state, root, workspace) {
    let project = workspace.project
    let concerned =
      project.has_file(project, path)
      || project.module_name(project, path) |> is_ok
    case concerned {
      False -> state
      True -> {
        let project = project.update_file(project, path, content)
        let workspace = Workspace(..workspace, project:)
        State(
          ..state,
          projects: dict.insert(state.projects, root, workspace),
          pending: set.insert(state.pending, root),
        )
      }
    }
  })
}

/// Loads the project of the file at `path`, when it is not loaded yet.
fn ensure_project(state: State, path: String) -> Promise(State) {
  let known =
    dict.values(state.projects)
    |> list.any(fn(workspace) {
      project.module_name(workspace.project, path) |> is_ok
    })
  case known {
    True -> promise.resolve(state)
    False -> {
      use root <- promise.await(fs.find_project_root(path))
      case root {
        Error(Nil) -> promise.resolve(state)
        Ok(root) -> open_project(state, root)
      }
    }
  }
}

fn open_project(state: State, root: String) -> Promise(State) {
  case dict.has_key(state.projects, root) || set.contains(state.ignored, root) {
    True -> promise.resolve(state)
    False -> {
      use enabled <- promise.await(project.depends_on(root, package))
      case enabled {
        False ->
          promise.resolve(
            State(..state, ignored: set.insert(state.ignored, root)),
          )
        True -> {
          use loaded <- promise.map(project.load(root))
          case loaded {
            Error(error) -> {
              transport.send(protocol.log(1, project.describe_error(error)))
              State(..state, ignored: set.insert(state.ignored, root))
            }
            Ok(project) -> {
              transport.send(protocol.log(3, "linting " <> root))
              let workspace =
                Workspace(
                  project:,
                  loader: loader.new(project),
                  published: set.new(),
                )
              State(
                ..state,
                projects: dict.insert(state.projects, root, workspace),
                pending: set.insert(state.pending, root),
              )
            }
          }
        }
      }
    }
  }
}

fn lint_pending(state: State) -> State {
  let projects =
    set.fold(state.pending, state.projects, fn(projects, root) {
      case dict.get(projects, root) {
        Error(Nil) -> projects
        Ok(workspace) -> dict.insert(projects, root, lint_workspace(workspace))
      }
    })
  State(..state, projects:, pending: set.new())
}

/// Lints a project and publishes its diagnostics. A file that cannot be
/// parsed, which happens all the time while typing, keeps its previous
/// diagnostics: the Gleam language server already reports the syntax error.
fn lint_workspace(workspace: Workspace) -> Workspace {
  let loader = loader.with_project(workspace.loader, workspace.project)
  let #(loader, diagnostics) = lint.run_with(loader)
  let unparsable =
    diagnostics
    |> list.filter(fn(d) { d.rule == diagnostic.Unparsable })
    |> list.map(fn(d) { d.path })
    |> set.from_list
  let by_path =
    diagnostics
    |> list.filter(fn(d) { d.rule != diagnostic.Unparsable })
    |> list.group(fn(d) { d.path })
  let paths =
    set.union(set.from_list(dict.keys(by_path)), workspace.published)
    |> set.difference(unparsable)
  set.each(paths, fn(path) {
    let diagnostics = dict.get(by_path, path) |> unwrap_list
    publish(workspace.project, path, list.reverse(diagnostics))
  })
  let published =
    set.from_list(dict.keys(by_path))
    |> set.union(set.intersection(workspace.published, unparsable))
  Workspace(..workspace, loader:, published:)
}

fn publish(
  project: Project,
  path: String,
  diagnostics: List(Diagnostic),
) -> Nil {
  let diagnostics =
    list.map(diagnostics, fn(d) {
      let source = case dict.get(project.modules, d.module) {
        Ok(source) -> source.content
        Error(Nil) -> ""
      }
      protocol.to_lsp(d, source)
    })
  transport.send(protocol.publish(transport.path_to_uri(path), diagnostics))
}

fn unwrap_list(result: Result(List(a), Nil)) -> List(a) {
  case result {
    Ok(items) -> items
    Error(Nil) -> []
  }
}

fn is_ok(result: Result(a, b)) -> Bool {
  case result {
    Ok(_) -> True
    Error(_) -> False
  }
}
