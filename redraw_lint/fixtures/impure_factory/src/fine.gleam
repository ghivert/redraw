import gleam/int
import redraw as react
import redraw/dom/client
import redraw/dom/html
import store

pub fn main() {
  let store = store.create()
  let context = react.create_context_(store)
  let assert Ok(node) = client.create_root("root")
  use root <- client.render_(node, root(context))
  root(Nil)
}

/// A context created in `main`, the standard library, `create_context_`
/// and externals inside the render are all fine.
pub fn root(context: react.Context(store.Store)) {
  let label = int.to_string(1)
  let theme = react.create_context_("light")
  use Nil <- react.component_("Root")
  let store = react.use_context(context)
  let _ = react.use_context(theme)
  store.subscribe(store, fn(_) { Nil })
  html.text(label)
}

/// An external for the Erlang target only is not reached on JavaScript.
pub fn erlang() {
  store.erlang_only()
  use Nil <- react.component_("Erlang")
  html.text("erlang")
}

/// A helper calling an external is not a factory: not re-run.
fn helper() -> store.Store {
  store.create()
}

/// An external called inside an anonymous function at factory level does
/// not run while the factory runs.
pub fn deferred() {
  let later = fn() { store.create() }
  use Nil <- react.component_("Deferred")
  let _ = later
  html.text("deferred")
}
