import redraw.{type Component}
import redraw/native/activity_indicator
import redraw/native/button
import redraw/native/drawer_layout
import redraw/native/image
import redraw/native/input_accessory
import redraw/native/internal/attributes
import redraw/native/keyboard_avoiding_view
import redraw/native/modal
import redraw/native/pressable
import redraw/native/refresh_control
import redraw/native/scroll_view
import redraw/native/status_bar
import redraw/native/switch
import redraw/native/text
import redraw/native/text_input
import redraw/native/view

const convert_children = True

pub fn activity_indicator(
  props: List(activity_indicator.Attribute),
) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(
    type_: do_activity_indicator,
    props:,
    children: Nil,
    convert_children:,
  )
}

pub fn button(props: List(button.Attribute)) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(type_: do_button, props:, children: Nil, convert_children:)
}

pub fn drawer_layout_android(
  view_props: List(view.Attribute),
  drawer_props: List(drawer_layout.Attribute),
  children: List(Component),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let drawer_props = attributes.to_props(drawer_props)
  let props = attributes.merge(view_props, drawer_props)
  redraw.jsx(
    type_: do_drawer_layout_android,
    props:,
    children:,
    convert_children:,
  )
}

pub fn image(
  view_props: List(view.Attribute),
  image_props: List(image.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let image_props = attributes.to_props(image_props)
  let props = attributes.merge(view_props, image_props)
  redraw.jsx(type_: do_image, props:, children: Nil, convert_children:)
}

pub fn image_background(
  view_props: List(view.Attribute),
  image_props: List(image.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let image_props = attributes.to_props(image_props)
  let props = attributes.merge(view_props, image_props)
  redraw.jsx(
    type_: do_image_background,
    props:,
    children: Nil,
    convert_children:,
  )
}

pub fn input_accessory_view(props: List(input_accessory.Attribute)) {
  let props = attributes.to_props(props)
  redraw.jsx(
    type_: do_input_accessory_view,
    props:,
    children: Nil,
    convert_children:,
  )
}

pub fn keyboard_avoiding_view(
  view_props: List(view.Attribute),
  keyboard_avoiding_view_props: List(keyboard_avoiding_view.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let keyboard_avoiding_view_props =
    attributes.to_props(keyboard_avoiding_view_props)
  let props = attributes.merge(view_props, keyboard_avoiding_view_props)
  redraw.jsx(
    type_: do_keyboard_avoiding_view,
    props:,
    children: Nil,
    convert_children:,
  )
}

pub fn modal(
  view_props: List(view.Attribute),
  modal_props: List(modal.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let modal_props = attributes.to_props(modal_props)
  let props = attributes.merge(view_props, modal_props)
  redraw.jsx(type_: do_modal, props:, children: Nil, convert_children:)
}

pub fn pressable(
  props: List(pressable.Attribute),
  children: List(Component),
) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(type_: do_pressable, props:, children:, convert_children:)
}

pub fn refresh_control(
  view_props: List(view.Attribute),
  refresh_props: List(refresh_control.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let refresh_props = attributes.to_props(refresh_props)
  let props = attributes.merge(view_props, refresh_props)
  redraw.jsx(
    type_: do_refresh_control,
    props:,
    children: Nil,
    convert_children:,
  )
}

pub fn scroll_view(
  view_props: List(view.Attribute),
  scroll_props: List(scroll_view.Attribute),
  children: List(Component),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let scroll_props = attributes.to_props(scroll_props)
  let props = attributes.merge(view_props, scroll_props)
  redraw.jsx(type_: do_scroll_view, props:, children:, convert_children:)
}

pub fn status_bar(props: List(status_bar.Attribute)) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(type_: do_status_bar, props:, children: Nil, convert_children:)
}

pub fn switch(
  view_props: List(view.Attribute),
  switch_props: List(switch.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let switch_props = attributes.to_props(switch_props)
  let props = attributes.merge(view_props, switch_props)
  redraw.jsx(type_: do_switch, props:, children: Nil, convert_children:)
}

pub fn text(props: List(text.Attribute), children: List(Component)) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(type_: do_text, props:, children:, convert_children:)
}

pub fn t(content: String) -> Component {
  redraw.jsx(type_: "text_", props: Nil, children: content, convert_children:)
}

pub fn text_input(
  view_props: List(view.Attribute),
  text_input_props: List(text_input.Attribute),
) -> Component {
  let view_props = attributes.to_props(view_props)
  let text_input_props = attributes.to_props(text_input_props)
  let props = attributes.merge(view_props, text_input_props)
  redraw.jsx(type_: do_text_input, props:, children: Nil, convert_children:)
}

pub fn view(props: List(view.Attribute), children: List(Component)) -> Component {
  let props = attributes.to_props(props)
  redraw.jsx(type_: do_view, props:, children:, convert_children:)
}

@external(javascript, "react-native", "ActivityIndicator")
fn do_activity_indicator(props: props) -> Component

@external(javascript, "react-native", "Button")
fn do_button(props: props) -> Component

@external(javascript, "react-native", "DrawerLayoutAndroid")
fn do_drawer_layout_android(props: props) -> Component

@external(javascript, "react-native", "Image")
fn do_image(props: props) -> Component

@external(javascript, "react-native", "InputAccessoryView")
fn do_input_accessory_view(props: props) -> Component

@external(javascript, "react-native", "ImageBackground")
fn do_image_background(props: props) -> Component

@external(javascript, "react-native", "KeyboardAvoidingView")
fn do_keyboard_avoiding_view(props: props) -> Component

@external(javascript, "react-native", "Modal")
fn do_modal(props: props) -> Component

@external(javascript, "react-native", "Pressable")
fn do_pressable(props: props) -> Component

@external(javascript, "react-native", "RefreshControl")
fn do_refresh_control(props: props) -> Component

@external(javascript, "react-native", "ScrollView")
fn do_scroll_view(props: props) -> Component

@external(javascript, "react-native", "StatusBar")
fn do_status_bar(props: props) -> Component

@external(javascript, "react-native", "Switch")
fn do_switch(props: props) -> Component

@external(javascript, "react-native", "Text")
fn do_text(props: props) -> Component

@external(javascript, "react-native", "TextInput")
fn do_text_input(props: props) -> Component

@external(javascript, "react-native", "View")
fn do_view(props: props) -> Component
