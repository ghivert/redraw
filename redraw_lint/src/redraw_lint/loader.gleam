//// Parses the modules of a project with glance, on demand, and caches the
//// result. The loader is threaded through the analysis: every function
//// needing a module returns the updated loader.
////
//// The cache survives a change of the project sources, through
//// `with_project`: a module is parsed again only when its source changed,
//// which keeps a long-running caller, like the language server, from
//// parsing the dependencies again at every keystroke.

import glance
import gleam/dict.{type Dict}
import gleam/result
import redraw_lint/project.{type Project, Source}
import redraw_lint/text

pub type Module {
  Module(
    package: String,
    name: String,
    path: String,
    source: String,
    ast: glance.Module,
  )
}

pub type LoadError {
  NotFound(module: String)
  ParseError(module: String, path: String, error: glance.Error)
}

pub opaque type Loader {
  Loader(
    project: Project,
    /// Parse results, with the source they were parsed from.
    cache: Dict(String, #(String, Result(Module, LoadError))),
  )
}

pub fn new(project: Project) -> Loader {
  Loader(project:, cache: dict.new())
}

/// The same loader on new sources, keeping the modules whose source did not
/// change.
pub fn with_project(loader: Loader, project: Project) -> Loader {
  Loader(..loader, project:)
}

pub fn project(loader: Loader) -> Project {
  loader.project
}

pub fn load(
  loader: Loader,
  name: String,
) -> #(Loader, Result(Module, LoadError)) {
  case dict.get(loader.project.modules, name) {
    Error(Nil) -> #(loader, Error(NotFound(name)))
    Ok(source) ->
      case dict.get(loader.cache, name) {
        Ok(#(content, result)) if content == source.content -> #(loader, result)
        _ -> {
          let result = parse(name, source)
          let cache = dict.insert(loader.cache, name, #(source.content, result))
          #(Loader(..loader, cache:), result)
        }
      }
  }
}

fn parse(name: String, source: project.Source) -> Result(Module, LoadError) {
  let Source(package:, path:, content:) = source
  glance.module(content)
  |> result.map_error(ParseError(name, path, _))
  |> result.map(Module(package:, name:, path:, source: content, ast: _))
}

/// Line and column, both starting at 1, of an offset in the module source.
pub fn position(module: Module, offset: Int) -> #(Int, Int) {
  text.position(module.source, offset)
}
