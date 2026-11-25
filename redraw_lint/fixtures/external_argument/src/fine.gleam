import gleam/dict.{type Dict}
import gleam/option.{type Option}
import redraw as react
import redraw/dom/html

pub type Variant {
  Primary
  Secondary
}

pub type Tree(a) {
  Leaf(a)
  Node(List(Tree(a)))
}

pub type Settings {
  Settings(variant: Variant, sizes: Dict(String, Int), extra: Option(#(Int, String)))
}

/// Data of every allowed kind.
pub fn button(
  variant: Variant,
  size: Int,
  label: String,
  flags: List(Bool),
  pair: #(Float, Result(Int, Nil)),
  settings: Settings,
  tree: Tree(Int),
  theme: react.Context(String),
  child: react.ReactComponent(Nil),
) {
  let _ = #(variant, size, label, flags, pair, settings, tree)
  use child <- react.compose(child)
  use Nil <- react.component_("Button")
  let _ = react.use_context(theme)
  html.div([], [child(Nil)])
}

/// A type variable cannot be checked, and is left alone.
pub fn generic(value: a) {
  let _ = value
  use Nil <- react.component_("Generic")
  html.text("generic")
}
