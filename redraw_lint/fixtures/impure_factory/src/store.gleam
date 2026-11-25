pub type Store

@external(javascript, "./store.ffi.mjs", "create")
pub fn create() -> Store

@external(javascript, "./store.ffi.mjs", "subscribe")
pub fn subscribe(store: Store, callback: fn(Int) -> Nil) -> Nil

@external(erlang, "store_ffi", "erlang_only")
pub fn erlang_only() -> Nil

pub fn wrapped() -> Store {
  create()
}
