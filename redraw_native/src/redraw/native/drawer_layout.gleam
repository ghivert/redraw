import gleam/dynamic.{type Dynamic}
import redraw.{type Component}
import redraw/internals/unsafe

pub opaque type Attribute {
  Attribute(key: String, content: Dynamic)
}

fn attribute(key: String, content: a) -> Attribute {
  let content = unsafe.coerce(content)
  Attribute(key:, content:)
}

pub fn drawer_background_color(value: String) {
  attribute("drawerBackgroundColor", value)
}

pub fn drawer_lock_mode(value: String) {
  attribute("drawerLockMode", value)
}

pub fn drawer_position(value: String) {
  attribute("drawerPosition", value)
}

pub fn drawer_width(value: Int) {
  attribute("drawerWidth", value)
}

pub fn keyboard_dismiss_mode(value: String) {
  attribute("keyboardDismissMode", value)
}

pub fn on_drawer_close(value: fn() -> Nil) {
  attribute("onDrawerClose", value)
}

pub fn on_drawer_open(value: fn() -> Nil) {
  attribute("onDrawerOpen", value)
}

pub fn on_drawer_slide(value: fn() -> Nil) {
  attribute("onDrawerSlide", value)
}

pub fn on_drawer_state_changed(value: fn() -> Nil) {
  attribute("onDrawerStateChanged", value)
}

pub fn render_navigation_view(value: fn() -> Component) {
  attribute("renderNavigationView", value)
}

pub fn status_bar_background_color(value: String) {
  attribute("statusBarBackgroundColor", value)
}

pub fn none() {
  attribute("none_", Nil)
}
