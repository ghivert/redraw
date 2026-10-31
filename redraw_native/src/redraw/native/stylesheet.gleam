import redraw/native/style.{type Style}

pub type StyleSheet

pub type Styles

@external(javascript, "./stylesheet.ffi.mjs", "create")
pub fn create(list: List(#(String, List(Style)))) -> StyleSheet

@external(javascript, "./stylesheet.ffi.mjs", "get")
pub fn get(stylesheet: StyleSheet, name: String) -> Result(Styles, Nil)

@external(javascript, "./stylesheet.ffi.mjs", "compile")
@internal
pub fn compile(styles: List(Style)) -> Styles
