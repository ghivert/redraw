pub type Store

@external(javascript, "./store.ffi.mjs", "create")
pub fn create() -> Store

@external(javascript, "./store.ffi.mjs", "get")
pub fn get(store: Store) -> Int
