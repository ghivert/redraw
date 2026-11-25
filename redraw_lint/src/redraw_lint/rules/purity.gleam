//// Rule 6: factories are re-run on every hot update of their module, so
//// they must be pure. A call, at factory level, to a function declared with
//// `@external(javascript, ...)` runs again at every re-run: a resource it
//// creates is created anew. Contexts created with `create_context_` are
//// keyed by the transform, and keep their identity across re-runs.
////
//// Functions of the standard library are taken as pure. A call to a function
//// of the project is followed, a few levels deep, to catch wrappers around
//// an external; a function of a dependency is not followed, so an external
//// reached through a dependency is not reported.

import glance
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/set.{type Set}
import gleam/string
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/factories.{type Analysis}
import redraw_lint/loader.{type Loader, type Module}
import redraw_lint/scope.{type Ref, Ref}
import redraw_lint/walk

const max_depth = 3

const pure_packages = ["gleam_stdlib"]

const allowed = [
  Ref("redraw", "component_"),
  Ref("redraw", "compose"),
  Ref("redraw", "memoize_"),
  Ref("redraw", "create_context_"),
]

pub fn check(
  loader: Loader,
  module: Module,
  analysis: Analysis,
) -> #(Loader, List(Diagnostic)) {
  case factories.is_factory(analysis) {
    False -> #(loader, [])
    True -> {
      use state, call <- list.fold(analysis.calls, #(loader, []))
      let #(loader, chain) = impure(state.0, module, call.callee, 0, set.new())
      case chain {
        None -> #(loader, state.1)
        Some(chain) -> {
          let diagnostic =
            diagnostic.new(
              rule: diagnostic.ImpureFactory,
              module: module.name,
              path: module.path,
              source: module.source,
              location: call.location,
              message: message(analysis.function.name, chain),
            )
          #(loader, list.append(state.1, [diagnostic]))
        }
      }
    }
  }
}

/// The chain of calls from `callee` to an external function, if any.
fn impure(
  loader: Loader,
  module: Module,
  callee: glance.Expression,
  depth: Int,
  visited: Set(Ref),
) -> #(Loader, Option(List(Ref))) {
  case scope.resolve_value(module, callee) {
    None -> #(loader, None)
    Some(ref) -> {
      case list.contains(allowed, ref) || set.contains(visited, ref) {
        True -> #(loader, None)
        False -> {
          let #(loader, target) = loader.load(loader, ref.module)
          case target {
            Error(_) -> #(loader, None)
            Ok(target) ->
              case list.contains(pure_packages, target.package) {
                True -> #(loader, None)
                False ->
                  follow(loader, target, ref, depth, set.insert(visited, ref))
              }
          }
        }
      }
    }
  }
}

fn follow(
  loader: Loader,
  target: Module,
  ref: Ref,
  depth: Int,
  visited: Set(Ref),
) -> #(Loader, Option(List(Ref))) {
  let function =
    list.find(target.ast.functions, fn(f) { f.definition.name == ref.name })
  case function {
    Error(Nil) -> #(loader, None)
    Ok(function) ->
      case is_external(function) {
        True -> #(loader, Some([ref]))
        False -> {
          let project = loader.project(loader)
          case target.package == project.name && depth < max_depth {
            False -> #(loader, None)
            True -> {
              // A factory of the project runs its render functions later,
              // not when called: only its factory-level calls are followed.
              let analysis = factories.analyse(target, function.definition)
              let callees = case factories.is_factory(analysis) {
                True -> list.map(analysis.calls, fn(call) { call.callee })
                False -> calls_in(function.definition.body)
              }
              use state, callee <- list.fold_until(callees, #(loader, None))
              let #(loader, chain) =
                impure(state.0, target, callee, depth + 1, visited)
              case chain {
                None -> list.Continue(#(loader, None))
                Some(chain) -> list.Stop(#(loader, Some([ref, ..chain])))
              }
            }
          }
        }
      }
  }
}

fn is_external(function: glance.Definition(glance.Function)) -> Bool {
  use attribute <- list.any(function.attributes)
  case attribute {
    glance.Attribute("external", [glance.Variable(_, "javascript"), ..]) -> True
    _ -> False
  }
}

/// Every callee in a function body, including inside anonymous functions
/// and pipes.
fn calls_in(body: List(glance.Statement)) -> List(glance.Expression) {
  walk.statements(body, [], fn(acc, expression) {
    case expression {
      glance.Call(_, function, _) -> walk.Continue([function, ..acc])
      glance.FnCapture(_, _, function, _, _) -> walk.Continue([function, ..acc])
      glance.BinaryOperator(_, glance.Pipe, _, right) ->
        case right {
          glance.Variable(..) | glance.FieldAccess(..) ->
            walk.Continue([right, ..acc])
          _ -> walk.Continue(acc)
        }
      _ -> walk.Continue(acc)
    }
  })
  |> list.reverse
}

fn message(factory: String, chain: List(Ref)) -> String {
  let described = list.map(chain, fn(ref) { "`" <> scope.describe(ref) <> "`" })
  let #(call, external) = case described {
    [only] -> #(only, only)
    [first, ..] -> #(
      first
        <> ", which reaches "
        <> string.join(list.drop(described, 1), " then "),
      last(described, first),
    )
    [] -> #("", "")
  }
  "The factory `"
  <> factory
  <> "` calls "
  <> call
  <> ", declared with `@external`: factories are re-run on every hot update of their module, so the call runs again, and anything it creates, such as a store, a root or a subscription, is created anew while the previous one lives on. Keep factories pure: `component_`, `compose`, `memoize_`, `create_context_` and plain computations. Create the resource in `main`, which runs once, and pass it through a context or the props."
  <> case external == call {
    True -> ""
    False -> " (external function: " <> external <> ")"
  }
}

fn last(items: List(a), default: a) -> a {
  case items {
    [] -> default
    [item] -> item
    [_, ..rest] -> last(rest, default)
  }
}
