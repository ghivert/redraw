//// Rules on the parameters of parameterized factories, whose arguments are
//// part of the identity of the components they build.

import glance
import gleam/list
import gleam/option.{None, Some}
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/factories.{type Analysis}
import redraw_lint/loader.{type Loader, type Module}
import redraw_lint/scope
import redraw_lint/types

pub fn check(
  loader: Loader,
  module: Module,
  analysis: Analysis,
) -> #(Loader, List(Diagnostic)) {
  case analysis.kind {
    Some(factories.Parameterized) -> {
      use state, parameter <- list.fold(
        analysis.function.parameters,
        #(loader, []),
      )
      let #(loader, diagnostics) =
        check_parameter(state.0, module, analysis.function, parameter)
      #(loader, list.append(state.1, diagnostics))
    }
    _ -> #(loader, [])
  }
}

fn check_parameter(
  loader: Loader,
  module: Module,
  function: glance.Function,
  parameter: glance.FunctionParameter,
) -> #(Loader, List(Diagnostic)) {
  let name = case parameter.name {
    glance.Named(name) -> name
    glance.Discarded(name) -> "_" <> name
  }
  let factory = "`" <> function.name <> "`"
  case parameter.type_ {
    None -> {
      let message =
        "The parameter `"
        <> name
        <> "` of the factory "
        <> factory
        <> " has no type annotation, so it cannot be checked. Fast Refresh identifies the components built by a parameterized factory by its arguments: annotate the parameter, so that the linter can tell whether it is safe."
      #(loader, [
        at(module, function.location, diagnostic.UnannotatedArgument, message),
      ])
    }
    Some(type_) -> {
      let #(loader, problems) = types.check(loader, module, type_)
      let diagnostics =
        list.map(problems, fn(problem) {
          case problem {
            types.Function(path, fn_type) -> {
              let message =
                "The parameter `"
                <> name
                <> "` of the factory "
                <> factory
                <> where(name, path)
                <> " is a function (`"
                <> fn_type
                <> "`). Fast Refresh identifies the components built by a parameterized factory by its arguments, and compares anonymous functions by their code: two closures with the same code capturing different values share an identity, and after a hot update both instances would call the last one. A callback varying per instance belongs in the props. A function that never varies can stay, as a named function."
              at(module, type_.location, diagnostic.FunctionArgument, message)
            }
            types.External(path, ref) -> {
              let message =
                "The parameter `"
                <> name
                <> "` of the factory "
                <> factory
                <> where(name, path)
                <> " has the type `"
                <> scope.describe(ref)
                <> "`, which is declared without constructors: a handle built in FFI. Fast Refresh identifies the components built by a parameterized factory by its arguments, and compares such a handle by its fields: two handles with the same shape share an identity, and after a hot update both instances would use the last one. Create the value in `main` and pass it through a context created there with `create_context_`, which is identified by its own identity, or through the props."
              at(module, type_.location, diagnostic.ExternalArgument, message)
            }
          }
        })
      #(loader, diagnostics)
    }
  }
}

fn where(name: String, path: List(String)) -> String {
  case path {
    [] -> ""
    _ -> ", at `" <> types.describe_path(name, path) <> "`,"
  }
}

fn at(
  module: Module,
  location: glance.Span,
  rule: diagnostic.Rule,
  message: String,
) -> Diagnostic {
  diagnostic.new(
    rule:,
    module: module.name,
    path: module.path,
    source: module.source,
    location:,
    message:,
  )
}
