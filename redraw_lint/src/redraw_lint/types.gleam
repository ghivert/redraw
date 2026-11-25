//// Classification of the type of a factory parameter, following how
//// `serialize` in `redraw/internal/hot.ffi.mjs` identifies factory
//// arguments. Values are compared structurally, so a type is safe when every
//// value it holds is data: basic types, lists, tuples, custom types with
//// constructors whose fields are safe. A function is compared by its code,
//// not by what it captures. A type declared without constructors is a
//// handle built in FFI, compared by its fields, which does not tell two
//// handles with the same shape apart. `redraw.Context` is identified by its
//// own identity, `redraw.ReactComponent` by the name of its render function,
//// and `gleam/dict.Dict` is data.

import glance
import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}
import gleam/set.{type Set}
import gleam/string
import redraw_lint/loader.{type Loader, type Module}
import redraw_lint/scope.{type Ref, Ref}

pub type Problem {
  /// A function, at `path` inside the parameter.
  Function(path: List(String), type_: String)
  /// A type declared without constructors, at `path` inside the parameter.
  External(path: List(String), type_: Ref)
}

/// A type as written in a module, with the type variables bound by the
/// generic type it was reached through.
type Typed {
  Typed(module: Module, type_: glance.Type, bindings: Dict(String, Typed))
}

pub fn check(
  loader: Loader,
  module: Module,
  type_: glance.Type,
) -> #(Loader, List(Problem)) {
  let #(loader, problems) =
    check_typed(loader, Typed(module, type_, dict.new()), [], set.new())
  #(loader, list.reverse(problems))
}

fn check_typed(
  loader: Loader,
  typed: Typed,
  path: List(String),
  visited: Set(Ref),
) -> #(Loader, List(Problem)) {
  case typed.type_ {
    glance.FunctionType(..) -> #(loader, [
      Function(list.reverse(path), to_string(typed.type_)),
    ])
    glance.TupleType(_, elements) ->
      list.index_fold(elements, #(loader, []), fn(state, element, index) {
        let #(loader, problems) =
          check_typed(
            state.0,
            Typed(..typed, type_: element),
            [int_to_string(index), ..path],
            visited,
          )
        #(loader, list.append(problems, state.1))
      })
    glance.VariableType(_, name) ->
      case dict.get(typed.bindings, name) {
        Ok(bound) -> check_typed(loader, bound, path, visited)
        Error(Nil) -> #(loader, [])
      }
    glance.HoleType(..) -> #(loader, [])
    glance.NamedType(_, name, qualifier, parameters) -> {
      let arguments =
        list.map(parameters, Typed(typed.module, _, typed.bindings))
      case scope.resolve_type(typed.module, qualifier, name) {
        None -> check_arguments(loader, arguments, path, visited)
        Some(Ref("redraw", "Context"))
        | Some(Ref("redraw", "ReactComponent")) -> #(loader, [])
        Some(Ref("gleam/dict", "Dict")) ->
          check_arguments(loader, arguments, path, visited)
        Some(ref) ->
          case set.contains(visited, ref) {
            True -> #(loader, [])
            False ->
              check_declaration(
                loader,
                ref,
                arguments,
                path,
                set.insert(visited, ref),
              )
          }
      }
    }
  }
}

/// Checks the arguments of a generic type whose own structure is safe, like
/// `List(a)`, `Result(a, b)` or a tuple: its values hold values of the
/// arguments.
fn check_arguments(
  loader: Loader,
  arguments: List(Typed),
  path: List(String),
  visited: Set(Ref),
) -> #(Loader, List(Problem)) {
  list.fold(arguments, #(loader, []), fn(state, argument) {
    let #(loader, problems) = check_typed(state.0, argument, path, visited)
    #(loader, list.append(problems, state.1))
  })
}

fn check_declaration(
  loader: Loader,
  ref: Ref,
  arguments: List(Typed),
  path: List(String),
  visited: Set(Ref),
) -> #(Loader, List(Problem)) {
  let #(loader, module) = loader.load(loader, ref.module)
  case module {
    // A module that cannot be read or parsed leaves the type unchecked.
    Error(_) -> #(loader, [])
    Ok(module) -> {
      let custom =
        list.find(module.ast.custom_types, fn(t) {
          t.definition.name == ref.name
        })
      let alias =
        list.find(module.ast.type_aliases, fn(t) {
          t.definition.name == ref.name
        })
      case custom, alias {
        Ok(glance.Definition(_, glance.CustomType(variants: [], ..))), _ -> #(
          loader,
          [External(list.reverse(path), ref)],
        )
        Ok(glance.Definition(_, custom)), _ -> {
          let bindings = bind(custom.parameters, arguments)
          use state, variant <- list.fold(custom.variants, #(loader, []))
          use state, field, index <- list.index_fold(variant.fields, state)
          let #(type_, label) = case field {
            glance.LabelledVariantField(item, label) -> #(item, label)
            glance.UnlabelledVariantField(item) -> #(item, int_to_string(index))
          }
          let #(loader, problems) =
            check_typed(
              state.0,
              Typed(module, type_, bindings),
              [label, ..path],
              visited,
            )
          #(loader, list.append(problems, state.1))
        }
        _, Ok(glance.Definition(_, alias)) -> {
          let bindings = bind(alias.parameters, arguments)
          check_typed(
            loader,
            Typed(module, alias.aliased, bindings),
            path,
            visited,
          )
        }
        _, _ -> #(loader, [])
      }
    }
  }
}

fn bind(
  parameters: List(String),
  arguments: List(Typed),
) -> Dict(String, Typed) {
  list.zip(parameters, arguments) |> dict.from_list
}

pub fn to_string(type_: glance.Type) -> String {
  case type_ {
    glance.NamedType(_, name, qualifier, parameters) -> {
      let prefix = case qualifier {
        Some(q) -> q <> "."
        None -> ""
      }
      prefix <> name <> generics(parameters)
    }
    glance.TupleType(_, elements) -> "#(" <> join(elements) <> ")"
    glance.FunctionType(_, parameters, return) ->
      "fn(" <> join(parameters) <> ") -> " <> to_string(return)
    glance.VariableType(_, name) | glance.HoleType(_, name) -> name
  }
}

fn generics(parameters: List(glance.Type)) -> String {
  case parameters {
    [] -> ""
    _ -> "(" <> join(parameters) <> ")"
  }
}

fn join(types: List(glance.Type)) -> String {
  types |> list.map(to_string) |> string.join(", ")
}

fn int_to_string(index: Int) -> String {
  string.inspect(index)
}

/// Describes the location of a problem inside a parameter, like `config.store`.
pub fn describe_path(parameter: String, path: List(String)) -> String {
  string.join([parameter, ..path], ".")
}
