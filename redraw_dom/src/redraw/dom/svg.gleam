//// All built-in browser components, such as `<svg>`, `<g>`, etc. support
//// common props and events. \
//// To stay compatible with the Lustre API, Redraw defines the entire set of
//// SVG elements. They're instantiated with JSX under-the-hood, and requires
//// a modern runtime to get them working.
////
//// [Find detailed documentation on MDN](https://developer.mozilla.org/docs/Web/SVG/Element).

import redraw.{type Component}
import redraw/dom/attribute.{type Attribute}

const convert_children = True

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/a)
pub fn a(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "a", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animate)
pub fn animate(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "animate", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion)
pub fn animate_motion(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "animateMotion", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform)
pub fn animate_transform(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "animateTransform", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/circle)
pub fn circle(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "circle", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/clipPath)
pub fn clip_path(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "clipPath", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/defs)
pub fn defs(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "defs", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/desc)
pub fn desc(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "desc", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/discard)
pub fn discard(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "discard", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/ellipse)
pub fn ellipse(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "ellipse", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feBlend)
pub fn fe_blend(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feBlend", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix)
pub fn fe_color_matrix(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feColorMatrix", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer)
pub fn fe_component_transfer(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feComponentTransfer", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feComposite)
pub fn fe_composite(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feComposite", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix)
pub fn fe_convolve_matrix(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feConvolveMatrix", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting)
pub fn fe_diffuse_lighting(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feDiffuseLighting", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap)
pub fn fe_displacement_map(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feDisplacementMap", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight)
pub fn fe_distant_light(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feDistantLight", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow)
pub fn fe_drop_shadow(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feDropShadow", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFlood)
pub fn fe_flood(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feFlood", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA)
pub fn fe_func_a(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feFuncA", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB)
pub fn fe_func_b(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feFuncB", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG)
pub fn fe_func_g(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feFuncG", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR)
pub fn fe_func_r(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feFuncR", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur)
pub fn fe_gaussian_blur(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feGaussianBlur", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feImage)
pub fn fe_image(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feImage", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMerge)
pub fn fe_merge(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feMerge", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode)
pub fn fe_merge_node(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feMergeNode", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology)
pub fn fe_morphology(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feMorphology", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feOffset)
pub fn fe_offset(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feOffset", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight)
pub fn fe_point_light(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "fePointLight", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting)
pub fn fe_specular_lighting(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feSpecularLighting", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight)
pub fn fe_spot_light(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feSpotLight", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feTile)
pub fn fe_tile(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feTile", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence)
pub fn fe_turbulence(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "feTurbulence", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/filter)
pub fn filter(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "filter", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject)
pub fn foreign_object(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "foreignObject", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/g)
pub fn g(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "g", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/hatch)
pub fn hatch(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "hatch", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/hatchpath)
pub fn hatchpath(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "hatchpath", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/image)
pub fn image(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "image", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/line)
pub fn line(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "line", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient)
pub fn linear_gradient(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "linearGradient", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/marker)
pub fn marker(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "marker", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/mask)
pub fn mask(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "mask", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/metadata)
pub fn metadata(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "metadata", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/mpath)
pub fn mpath(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "mpath", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/path)
pub fn path(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "path", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/pattern)
pub fn pattern(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "pattern", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/polygon)
pub fn polygon(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "polygon", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/polyline)
pub fn polyline(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "polyline", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient)
pub fn radial_gradient(
  attrs: List(Attribute),
  children: List(Component),
) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "radialGradient", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/rect)
pub fn rect(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "rect", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/script)
pub fn script(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "script", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/set)
pub fn set(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "set", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/stop)
pub fn stop(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "stop", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/style)
pub fn style(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "style", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/svg)
pub fn svg(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "svg", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/switch)
pub fn switch(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "switch", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/symbol)
pub fn symbol(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "symbol", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/text)
pub fn text(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "text", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/textPath)
pub fn text_path(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "textPath", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/title)
pub fn title(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "title", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/tspan)
pub fn tspan(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "tspan", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/use)
pub fn use_(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "use", props:, children:, convert_children:)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/view)
pub fn view(attrs: List(Attribute), children: List(Component)) -> Component {
  let props = to_props(attrs)
  redraw.jsx(type_: "view", props:, children:, convert_children:)
}

@external(javascript, "./html.ffi.mjs", "toProps")
fn to_props(attrs: List(Attribute)) -> b
