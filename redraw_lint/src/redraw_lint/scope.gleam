//// Resolution of the names used in a module to the module defining them,
//// through its imports. Local bindings shadowing a module-level name are not
//// tracked: a parameter named like an imported function would be resolved
//// to the import.

import glance
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import redraw_lint/loader.{type Module}

/// A module-level value or type, by its defining module and name.
pub type Ref {
  Ref(module: String, name: String)
}

/// Resolves the callee of a call, a `Variable` or a `module.name` access, to
/// the module-level function it refers to.
pub fn resolve_value(
  module: Module,
  expression: glance.Expression,
) -> Option(Ref) {
  case expression {
    glance.Variable(_, name) -> resolve_unqualified(module, name, Value)
    glance.FieldAccess(_, glance.Variable(_, alias), name) ->
      case imported_module(module, alias) {
        Some(imported) -> Some(Ref(imported, name))
        None -> None
      }
    _ -> None
  }
}

/// Resolves a type name, qualified by a module alias or not, to the module
/// declaring it. `None` for a prelude type, or an unknown name.
pub fn resolve_type(
  module: Module,
  qualifier: Option(String),
  name: String,
) -> Option(Ref) {
  case qualifier {
    Some(alias) ->
      case imported_module(module, alias) {
        Some(imported) -> Some(Ref(imported, name))
        None -> None
      }
    None -> resolve_unqualified(module, name, Type)
  }
}

type Namespace {
  Value
  Type
}

fn resolve_unqualified(
  module: Module,
  name: String,
  namespace: Namespace,
) -> Option(Ref) {
  let local = case namespace {
    Value -> list.any(module.ast.functions, fn(f) { f.definition.name == name })
    Type ->
      list.any(module.ast.custom_types, fn(t) { t.definition.name == name })
      || list.any(module.ast.type_aliases, fn(t) { t.definition.name == name })
  }
  case local {
    True -> Some(Ref(module.name, name))
    False ->
      {
        use import_ <- list.find_map(module.ast.imports)
        let unqualified = case namespace {
          Value -> import_.definition.unqualified_values
          Type -> import_.definition.unqualified_types
        }
        use item <- list.find_map(unqualified)
        case option.unwrap(item.alias, item.name) == name {
          True -> Ok(Ref(import_.definition.module, item.name))
          False -> Error(Nil)
        }
      }
      |> option.from_result
  }
}

/// The module imported under `alias` in `module`, if any.
pub fn imported_module(module: Module, alias: String) -> Option(String) {
  list.find_map(module.ast.imports, fn(import_) {
    let import_ = import_.definition
    let binding = case import_.alias {
      Some(glance.Named(name)) -> name
      Some(glance.Discarded(_)) -> ""
      None ->
        import_.module
        |> string.split("/")
        |> list.last
        |> option.from_result
        |> option.unwrap("")
    }
    case binding == alias {
      True -> Ok(import_.module)
      False -> Error(Nil)
    }
  })
  |> option.from_result
}

pub fn describe(ref: Ref) -> String {
  let Ref(module:, name:) = ref
  let short =
    module
    |> string.split("/")
    |> list.last
    |> option.from_result
    |> option.unwrap(module)
  short <> "." <> name
}
