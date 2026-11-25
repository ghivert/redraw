import redraw as react
import redraw/dom/html
import store

/// A store created in a factory: created anew at every re-run.
pub fn counter() {
  let store = store.create()
  use Nil <- react.component_("Counter")
  let _ = store
  html.text("counter")
}

/// The same, through a wrapper of the project.
pub fn wrapped_counter() {
  let store = store.wrapped()
  use Nil <- react.component_("WrappedCounter")
  let _ = store
  html.text("wrapped")
}

/// The same, through a pipe, in a parameterized factory.
pub fn piped(label: String) {
  let _ = label |> make_store
  use Nil <- react.component_("Piped")
  html.text(label)
}

fn make_store(_label: String) -> store.Store {
  store.create()
}
