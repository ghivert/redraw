//// Rule 5: the module defining `main` must export `main` and factories
//// only. The transform hashes every other export, since importers may hold
//// it through an ESM binding, and propagates an update of it to the
//// importers; the entry module has none, so the page is reloaded.

import glance
import gleam/list
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/factories.{type Analysis}
import redraw_lint/loader.{type Module}

pub fn check(module: Module, analyses: List(Analysis)) -> List(Diagnostic) {
  let defines_main = list.any(analyses, fn(a) { a.function.name == "main" })
  case defines_main {
    False -> []
    True -> {
      let functions =
        list.filter_map(analyses, fn(analysis) {
          let function = analysis.function
          case
            function.publicity,
            function.name,
            factories.is_factory(analysis)
          {
            glance.Public, "main", _ | glance.Private, _, _ | _, _, True ->
              Error(Nil)
            glance.Public, name, False ->
              Ok(at(module, function.location, message("function", name)))
          }
        })
      let constants =
        list.filter_map(module.ast.constants, fn(constant) {
          let constant = constant.definition
          case constant.publicity {
            glance.Public ->
              Ok(at(
                module,
                constant.location,
                message("constant", constant.name),
              ))
            glance.Private -> Error(Nil)
          }
        })
      list.append(functions, constants)
    }
  }
}

fn message(kind: String, name: String) -> String {
  "The "
  <> kind
  <> " `"
  <> name
  <> "` is exported from the module defining `main`, which should export `main` and component factories only: an update reaching this module through the "
  <> kind
  <> " reloads the page, since `main` runs once and cannot be re-run. Make it private, or move it to another module."
}

fn at(module: Module, location: glance.Span, message: String) -> Diagnostic {
  diagnostic.new(
    rule: diagnostic.EntryExport,
    module: module.name,
    path: module.path,
    source: module.source,
    location:,
    message:,
  )
}
