import gleam/option.{type Option}
import redraw as react
import redraw/dom/html
import store.{type Store}

pub type Deps {
  Deps(name: String, store: store.Store)
}

pub type Alias =
  Store

pub type Boxed(a) {
  Boxed(inner: a)
}

/// An FFI handle: compared by its fields.
pub fn counter(store: Store) {
  use Nil <- react.component_("Counter")
  html.text(string_of(store.get(store)))
}

/// The same, as a record field.
pub fn with_deps(deps: Deps) {
  use Nil <- react.component_("WithDeps")
  html.text(deps.name)
}

/// The same, behind an alias.
pub fn aliased(store: Alias) {
  use Nil <- react.component_("Aliased")
  html.text(string_of(store.get(store)))
}

/// The same, as the argument of a generic type.
pub fn boxed(store: Boxed(Option(Store))) {
  let _ = store
  use Nil <- react.component_("Boxed")
  html.text("boxed")
}

fn string_of(_n: Int) -> String {
  "n"
}
