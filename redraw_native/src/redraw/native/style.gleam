import gleam/dynamic.{type Dynamic}
import gleam/list
import redraw/internals/unsafe
import redraw/native/internal/attributes

pub opaque type Style {
  Style(key: String, value: Dynamic)
}

fn style(key: String, value: a) {
  let value = unsafe.coerce(value)
  Style(key, value)
}

pub fn flex(value: Int) {
  style("flex", value)
}

pub fn flex_direction(value: String) {
  style("flexDirection", value)
}

pub fn direction(value: String) {
  style("direction", value)
}

pub fn background_color(value: String) {
  style("backgroundColor", value)
}

pub fn align_items(value: String) {
  style("alignItems", value)
}

pub fn align_self(value: String) {
  style("alignSelf", value)
}

pub fn align_content(value: String) {
  style("alignContent", value)
}

pub fn flex_wrap(value: String) {
  style("flexWrap", value)
}

pub fn flex_basis(value: String) {
  style("flexBasis", value)
}

pub fn flex_grow(value: Float) {
  style("flexGrow", value)
}

pub fn flex_shrink(value: Float) {
  style("flexShrink", value)
}

pub fn row_gap(value: Int) {
  style("rowGap", value)
}

pub fn column_gap(value: Int) {
  style("columnGap", value)
}

pub fn gap(value: Int) {
  style("gap", value)
}

pub fn width(value: Int) {
  style("width", value)
}

pub fn width_(value: String) {
  style("width", value)
}

pub fn height(value: Int) {
  style("height", value)
}

pub fn height_(value: String) {
  style("height", value)
}

pub fn position(value: String) {
  style("position", value)
}

pub fn top(value: Int) {
  style("top", value)
}

pub fn top_(value: String) {
  style("top", value)
}

pub fn bottom(value: Int) {
  style("bottom", value)
}

pub fn bottom_(value: String) {
  style("bottom", value)
}

pub fn left(value: Int) {
  style("left", value)
}

pub fn left_(value: String) {
  style("left", value)
}

pub fn right(value: Int) {
  style("right", value)
}

pub fn right_(value: String) {
  style("right", value)
}

pub fn justify_content(value: String) {
  style("justifyContent", value)
}

pub fn color(value: String) {
  style("color", value)
}

pub fn font_family(value: String) {
  style("fontFamily", value)
}

pub fn font_size(value: Int) {
  style("fontSize", value)
}

pub type FontStyle {
  Normal
  Italic
}

pub fn font_style(value: FontStyle) {
  let value = case value {
    Italic -> "italic"
    Normal -> "normal"
  }
  style("fontStyle", value)
}

pub fn font_weight(value: String) {
  style("fontWeight", value)
}

pub fn include_font_padding(value: Bool) {
  style("includeFontPadding", value)
}

pub type FontVariant {
  SmallCaps
  OldstyleNums
  LiningNums
  TabularNums
  ProportionalNums
}

pub fn font_variant(value: List(FontVariant)) {
  style("fontVariant", {
    attributes.to_array({
      use value <- list.map(value)
      case value {
        LiningNums -> "lining-nums"
        OldstyleNums -> "oldstyle-nums"
        ProportionalNums -> "proportional-nums"
        SmallCaps -> "small-caps"
        TabularNums -> "tabular-nums"
      }
    })
  })
}

pub fn letter_spacing(value: Int) {
  style("letterSpacing", value)
}

pub fn line_height(value: Int) {
  style("lineHeight", value)
}

pub fn text_align(value: String) {
  style("textAlign", value)
}

pub fn text_align_vertical(value: String) {
  style("textAlignVertical", value)
}

pub fn text_decoration_color(value: String) {
  style("textDecorationColor", value)
}

pub fn text_decoration_line(value: String) {
  style("textDecorationLine", value)
}

pub fn text_decoration_style(value: String) {
  style("textDecorationStyle", value)
}

pub fn text_shadow_color(value: String) {
  style("textShadowColor", value)
}

pub fn text_shadow_offset(width width: Int, height height: Int) {
  let value = attributes.to_offset(width, height)
  style("textShadowOffset", value)
}

pub fn text_shadow_radius(value: Int) {
  style("textShadowRadius", value)
}

pub fn text_transform(value: String) {
  style("textTransform", value)
}

pub fn vertical_align(value: String) {
  style("verticalAlign", value)
}

pub fn writing_direction(value: String) {
  style("writingDirection", value)
}

pub fn user_select(value: String) {
  style("userSelect", value)
}
