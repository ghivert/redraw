@external(javascript, "./attributes.ffi.mjs", "toProps")
pub fn to_props(attributes: List(a)) -> b

@external(javascript, "./attributes.ffi.mjs", "merge")
pub fn merge(a: a, b: b) -> c

@external(javascript, "./attributes.ffi.mjs", "toMaintainVisibleContentPosition")
pub fn to_maintain_visible_content_position(a: Int, b: Int) -> b

@external(javascript, "./attributes.ffi.mjs", "toArray")
pub fn to_array(a: List(a)) -> b

@external(javascript, "./attributes.ffi.mjs", "toOffset")
pub fn to_offset(width: Int, height: Int) -> b

@external(javascript, "./attributes.ffi.mjs", "rippleConfig")
pub fn ripple_config(config: a) -> b

@external(javascript, "./attributes.ffi.mjs", "toRect")
pub fn to_rect(
  bottom bottom: Int,
  top top: Int,
  right right: Int,
  left left: Int,
) -> b

@external(javascript, "./attributes.ffi.mjs", "toTrackColor")
pub fn to_track_color(false false: String, true true: String) -> b

@external(javascript, "./attributes.ffi.mjs", "toSelection")
pub fn to_selection(start start: Int, end end: Int) -> b
