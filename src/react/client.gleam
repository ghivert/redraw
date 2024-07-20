import react.{type Component}

pub type Root

@external(javascript, "../react.ffi.mjs", "createRoot")
pub fn create_root(root: String) -> Root

@external(javascript, "../react.ffi.mjs", "hydrateRoot")
pub fn hydrate_root(root: String, node: Component) -> Root

@external(javascript, "../react.ffi.mjs", "render")
pub fn render(root: Root, child: Component) -> Nil

@external(javascript, "../react.ffi.mjs", "createPortal")
pub fn create_portal(children: Component, root: String) -> Component
