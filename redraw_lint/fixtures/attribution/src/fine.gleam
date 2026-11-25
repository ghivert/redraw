import redraw as react
import redraw/dom/html

pub fn with_use() {
  use Nil <- react.component_("WithUse")
  html.text("use")
}

pub fn with_inline() {
  react.component_("Inline", fn(_: Nil) { html.text("inline") })
}

pub fn with_labels() {
  react.component_(render: fn(_: Nil) { html.text("labels") }, name: "Labels")
}

pub fn memoized() {
  react.component_("Memoized", fn(_: Nil) { html.text("memo") })
  |> react.memoize_
}

/// `use` chains inside a factory are not anonymous functions for the
/// transform: they run while the factory runs.
pub fn composed() {
  use memoized <- react.compose(memoized())
  use with_use <- react.compose(with_use())
  use Nil <- react.component_("Composed")
  html.div([], [memoized(Nil), with_use(Nil)])
}
