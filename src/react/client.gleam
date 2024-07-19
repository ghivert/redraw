import react.{type Component}

pub type Root

@external(javascript, "../react.ffi.mjs", "createRoot")
pub fn create_root(root: String) -> Root

@external(javascript, "../react.ffi.mjs", "render")
pub fn render(root: Root, child: Component) -> Nil
