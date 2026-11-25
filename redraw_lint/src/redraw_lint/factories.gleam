//// Finds the component factories of a module, with the same heuristics as
//// the Babel transform of `vite-plugin-redraw` (`findFactories`): a factory
//// is a module-level function calling `redraw.component_` with a function
//// literal, `redraw.compose` or `redraw.memoize_`. A factory without
//// parameters is re-run as is after a hot update. A parameterized factory is
//// replayed with its recorded arguments, provided it calls `component_`
//// itself with a function literal; otherwise it is a helper receiving a
//// component built elsewhere, which is not replayed.
////
//// The analysis also records what the transform needs from the source: the
//// components created, with their name and how the render was passed, and
//// the calls made at factory level, that is outside any render function and
//// any anonymous function, which run again at every re-run of the factory.

import glance.{type Expression, type Span, type Statement}
import gleam/list
import gleam/option.{type Option, None, Some}
import redraw_lint/loader.{type Module}
import redraw_lint/scope.{type Ref, Ref}
import redraw_lint/walk

pub const redraw = "redraw"

pub type Kind {
  /// No parameters: re-run as is.
  Plain
  /// Replayed with its recorded arguments.
  Parameterized
  /// Parameterized helper not calling `component_` itself: not replayed.
  Helper
}

pub type Component {
  Component(
    location: Span,
    /// The name, when given as a string literal.
    name: Option(String),
    /// Whether the render is a function literal, written with `use` or
    /// inline. A render passed by reference, through a pipe or a capture,
    /// cannot be tagged by the transform.
    inline: Bool,
    /// Whether the call is inside an anonymous function or a render.
    nested: Bool,
  )
}

/// A call made at factory level.
pub type Call {
  Call(location: Span, callee: Expression)
}

pub type Analysis {
  Analysis(
    function: glance.Function,
    kind: Option(Kind),
    components: List(Component),
    calls: List(Call),
  )
}

pub fn analyse(module: Module, function: glance.Function) -> Analysis {
  let acc =
    walk_statements(
      module,
      function.body,
      Context(False, False),
      Acc([], False, []),
    )
  let components = list.reverse(acc.components)
  let creates = list.any(components, fn(c) { c.inline })
  let kind = case creates || acc.composes, function.parameters {
    False, _ -> None
    True, [] -> Some(Plain)
    True, _ if creates -> Some(Parameterized)
    True, _ -> Some(Helper)
  }
  Analysis(function:, kind:, components:, calls: list.reverse(acc.calls))
}

pub fn is_factory(analysis: Analysis) -> Bool {
  case analysis.kind {
    Some(Plain) | Some(Parameterized) -> True
    _ -> False
  }
}

type Context {
  Context(in_fn: Bool, in_render: Bool)
}

type Acc {
  Acc(components: List(Component), composes: Bool, calls: List(Call))
}

fn walk_statements(
  module: Module,
  statements: List(Statement),
  ctx: Context,
  acc: Acc,
) -> Acc {
  case statements {
    [] -> acc
    [
      glance.Use(_, _, glance.Call(location, function, arguments) as call),
      ..rest
    ] ->
      case scope.resolve_value(module, function) {
        Some(Ref("redraw", "component_")) -> {
          let component =
            Component(
              location,
              name_argument(arguments),
              inline: True,
              nested: nested(ctx),
            )
          let acc = Acc(..acc, components: [component, ..acc.components])
          let acc = walk_arguments(module, arguments, ctx, acc)
          walk_statements(module, rest, Context(..ctx, in_render: True), acc)
        }
        _ -> {
          let acc = walk_expression(module, call, ctx, acc)
          walk_statements(module, rest, ctx, acc)
        }
      }
    [glance.Use(_, _, function), ..rest] -> {
      let acc = walk_expression(module, function, ctx, acc)
      walk_statements(module, rest, ctx, acc)
    }
    [glance.Assignment(value:, ..), ..rest]
    | [glance.Expression(value), ..rest] ->
      walk_statements(
        module,
        rest,
        ctx,
        walk_expression(module, value, ctx, acc),
      )
    [glance.Assert(expression:, message:, ..), ..rest] -> {
      let acc = walk_expression(module, expression, ctx, acc)
      let acc = walk_optional(module, message, ctx, acc)
      walk_statements(module, rest, ctx, acc)
    }
  }
}

fn walk_expression(
  module: Module,
  expression: Expression,
  ctx: Context,
  acc: Acc,
) -> Acc {
  case expression {
    glance.Call(location, function, arguments) -> {
      let acc = case scope.resolve_value(module, function) {
        Some(Ref("redraw", "component_")) -> {
          let render = render_argument(arguments)
          let inline = case render {
            Some(glance.Fn(..)) -> True
            _ -> False
          }
          let component =
            Component(
              location,
              name_argument(arguments),
              inline:,
              nested: nested(ctx),
            )
          let acc = Acc(..acc, components: [component, ..acc.components])
          case render {
            Some(glance.Fn(_, _, _, body)) -> {
              let others =
                list.filter(arguments, fn(a) { walk.field_item(a) != render })
              let acc = walk_arguments(module, others, ctx, acc)
              walk_statements(
                module,
                body,
                Context(..ctx, in_render: True),
                acc,
              )
            }
            _ -> walk_arguments(module, arguments, ctx, acc)
          }
        }
        Some(Ref("redraw", "compose")) | Some(Ref("redraw", "memoize_")) ->
          Acc(..acc, composes: True)
          |> walk_arguments(module, arguments, ctx, _)
        _ -> walk_arguments(module, arguments, ctx, acc)
      }
      let acc = record_call(location, function, ctx, acc)
      walk_callee(module, function, ctx, acc)
    }
    glance.FnCapture(location, _, function, before, after) -> {
      let acc = note_reference(module, location, function, ctx, acc)
      let acc = walk_arguments(module, before, ctx, acc)
      let acc = walk_arguments(module, after, ctx, acc)
      walk_callee(module, function, ctx, acc)
    }
    glance.Variable(location, _) | glance.FieldAccess(location, _, _) -> {
      let acc = note_reference(module, location, expression, ctx, acc)
      case expression {
        glance.FieldAccess(_, container, _) ->
          walk_expression(module, container, ctx, acc)
        _ -> acc
      }
    }
    glance.BinaryOperator(_, glance.Pipe, left, right) -> {
      let acc = walk_expression(module, left, ctx, acc)
      case right {
        // `x |> f` compiles to `f(x)`: a call at factory level.
        glance.Variable(location, _) | glance.FieldAccess(location, _, _) ->
          walk_expression(module, right, ctx, acc)
          |> record_call(location, right, ctx, _)
        // `x |> f(a, _)` compiles to `f(a, x)` too.
        glance.FnCapture(location, _, function, _, _) ->
          walk_expression(module, right, ctx, acc)
          |> record_call(location, function, ctx, _)
        _ -> walk_expression(module, right, ctx, acc)
      }
    }
    glance.Fn(_, _, _, body) ->
      walk_statements(module, body, Context(..ctx, in_fn: True), acc)
    glance.Block(_, body) -> walk_statements(module, body, ctx, acc)
    _ ->
      // Every other expression has no call of its own: its direct children
      // are walked in turn.
      walk.children(expression, acc, fn(acc, child) {
        walk.Skip(walk_expression(module, child, ctx, acc))
      })
  }
}

/// A callee that is a plain reference is resolved by the call: it is not
/// a reference to `component_` on its own.
fn walk_callee(
  module: Module,
  function: Expression,
  ctx: Context,
  acc: Acc,
) -> Acc {
  case function {
    glance.Variable(..) -> acc
    glance.FieldAccess(_, glance.Variable(..), _) -> acc
    _ -> walk_expression(module, function, ctx, acc)
  }
}

/// A reference to `component_` outside a direct call: the render cannot be
/// a literal at the call site. A reference to `compose` or `memoize_`, as
/// in `|> memoize_`, counts as a call for the transform.
fn note_reference(
  module: Module,
  location: Span,
  function: Expression,
  ctx: Context,
  acc: Acc,
) -> Acc {
  case scope.resolve_value(module, function) {
    Some(Ref("redraw", "component_")) -> {
      let component =
        Component(location, None, inline: False, nested: nested(ctx))
      Acc(..acc, components: [component, ..acc.components])
    }
    Some(Ref("redraw", "compose")) | Some(Ref("redraw", "memoize_")) ->
      Acc(..acc, composes: True)
    _ -> acc
  }
}

fn record_call(
  location: Span,
  callee: Expression,
  ctx: Context,
  acc: Acc,
) -> Acc {
  case nested(ctx) {
    True -> acc
    False -> Acc(..acc, calls: [Call(location, callee), ..acc.calls])
  }
}

fn walk_arguments(
  module: Module,
  arguments: List(glance.Field(Expression)),
  ctx: Context,
  acc: Acc,
) -> Acc {
  list.fold(arguments, acc, fn(acc, argument) {
    walk_optional(module, walk.field_item(argument), ctx, acc)
  })
}

fn walk_optional(
  module: Module,
  expression: Option(Expression),
  ctx: Context,
  acc: Acc,
) -> Acc {
  case expression {
    Some(expression) -> walk_expression(module, expression, ctx, acc)
    None -> acc
  }
}

fn nested(ctx: Context) -> Bool {
  ctx.in_fn || ctx.in_render
}

fn name_argument(arguments: List(glance.Field(Expression))) -> Option(String) {
  case argument(arguments, 0, "name") {
    Some(glance.String(_, name)) -> Some(name)
    _ -> None
  }
}

fn render_argument(
  arguments: List(glance.Field(Expression)),
) -> Option(Expression) {
  argument(arguments, 1, "render")
}

/// The argument given with `label`, or the `index`th positional one.
fn argument(
  arguments: List(glance.Field(Expression)),
  index: Int,
  label: String,
) -> Option(Expression) {
  let labelled =
    list.find_map(arguments, fn(argument) {
      case argument {
        glance.LabelledField(label: l, item:, ..) if l == label -> Ok(item)
        _ -> Error(Nil)
      }
    })
  case labelled {
    Ok(item) -> Some(item)
    Error(Nil) ->
      arguments
      |> list.filter_map(fn(argument) {
        case argument {
          glance.UnlabelledField(item) -> Ok(item)
          _ -> Error(Nil)
        }
      })
      |> list.drop(index)
      |> list.first
      |> option.from_result
  }
}

/// The reference a call may refer to, for messages.
pub fn callee_ref(module: Module, callee: Expression) -> Option(Ref) {
  scope.resolve_value(module, callee)
}
