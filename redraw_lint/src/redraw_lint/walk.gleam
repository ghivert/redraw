//// A fold over every expression of a statement list, in source order. The
//// visitor decides whether the children of an expression are visited.

import glance.{type Expression, type Statement}
import gleam/list
import gleam/option.{type Option, None, Some}

pub type Step(acc) {
  Continue(acc)
  Skip(acc)
}

pub fn statements(
  statements: List(Statement),
  acc: acc,
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  list.fold(statements, acc, fn(acc, statement) {
    case statement {
      glance.Use(_, _, function) -> expression(function, acc, visit)
      glance.Assignment(value:, ..) -> expression(value, acc, visit)
      glance.Assert(expression: e, message:, ..) ->
        expression(e, acc, visit) |> optional(message, visit)
      glance.Expression(e) -> expression(e, acc, visit)
    }
  })
}

pub fn expression(
  expr: Expression,
  acc: acc,
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  case visit(acc, expr) {
    Skip(acc) -> acc
    Continue(acc) -> children(expr, acc, visit)
  }
}

/// Applies `visit` to the direct children of an expression.
pub fn children(
  expr: Expression,
  acc: acc,
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  case expr {
    glance.Int(..)
    | glance.Float(..)
    | glance.String(..)
    | glance.Variable(..) -> acc
    glance.NegateInt(_, value) | glance.NegateBool(_, value) ->
      expression(value, acc, visit)
    glance.Block(_, body) -> statements(body, acc, visit)
    glance.Panic(_, message) | glance.Todo(_, message) ->
      optional(acc, message, visit)
    glance.Tuple(_, elements) -> many(elements, acc, visit)
    glance.List(_, elements, rest) ->
      many(elements, acc, visit) |> optional(rest, visit)
    glance.Fn(_, _, _, body) -> statements(body, acc, visit)
    glance.RecordUpdate(_, _, _, record, fields) -> {
      let acc = expression(record, acc, visit)
      list.fold(fields, acc, fn(acc, field) { optional(acc, field.item, visit) })
    }
    glance.FieldAccess(_, container, _) -> expression(container, acc, visit)
    glance.Call(_, function, arguments) ->
      expression(function, acc, visit) |> fields(arguments, visit)
    glance.TupleIndex(_, tuple, _) -> expression(tuple, acc, visit)
    glance.FnCapture(_, _, function, before, after) ->
      expression(function, acc, visit)
      |> fields(before, visit)
      |> fields(after, visit)
    glance.BitString(_, segments) ->
      list.fold(segments, acc, fn(acc, segment) {
        let acc = expression(segment.0, acc, visit)
        list.fold(segment.1, acc, fn(acc, opt) {
          case opt {
            glance.SizeValueOption(e) -> expression(e, acc, visit)
            _ -> acc
          }
        })
      })
    glance.Case(_, subjects, clauses) -> {
      let acc = many(subjects, acc, visit)
      list.fold(clauses, acc, fn(acc, clause) {
        optional(acc, clause.guard, visit) |> expression(clause.body, _, visit)
      })
    }
    glance.BinaryOperator(_, _, left, right) ->
      expression(left, acc, visit) |> expression(right, _, visit)
    glance.Echo(_, e, message) ->
      optional(acc, e, visit) |> optional(message, visit)
  }
}

fn many(
  exprs: List(Expression),
  acc: acc,
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  list.fold(exprs, acc, fn(acc, e) { expression(e, acc, visit) })
}

fn optional(
  acc: acc,
  expr: Option(Expression),
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  case expr {
    Some(e) -> expression(e, acc, visit)
    None -> acc
  }
}

pub fn fields(
  acc: acc,
  fields: List(glance.Field(Expression)),
  visit: fn(acc, Expression) -> Step(acc),
) -> acc {
  list.fold(fields, acc, fn(acc, field) {
    optional(acc, field_item(field), visit)
  })
}

pub fn field_item(field: glance.Field(a)) -> Option(a) {
  case field {
    glance.LabelledField(item:, ..) | glance.UnlabelledField(item:) ->
      Some(item)
    glance.ShorthandField(..) -> None
  }
}
