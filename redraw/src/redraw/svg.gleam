//// All built-in browser components, such as `<svg>`, `<g>`, etc. support
//// common props and events. \
//// To stay compatible with the Lustre API, Redraw defines the entire set of
//// SVG elements. They're instantiated with JSX under-the-hood, and requires
//// a modern runtime to get them working.
////
//// [Find detailed documentation on MDN](https://developer.mozilla.org/docs/Web/SVG/Element).

import redraw.{type Component}
import redraw/internals/attribute.{to_props}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/a)
pub fn a(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("a", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animate)
pub fn animate(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("animate", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion)
pub fn animate_motion(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("animateMotion", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform)
pub fn animate_transform(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("animateTransform", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/circle)
pub fn circle(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("circle", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/clipPath)
pub fn clip_path(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("clipPath", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/defs)
pub fn defs(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("defs", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/desc)
pub fn desc(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("desc", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/discard)
pub fn discard(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("discard", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/ellipse)
pub fn ellipse(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("ellipse", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feBlend)
pub fn fe_blend(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feBlend", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix)
pub fn fe_color_matrix(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feColorMatrix", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer)
pub fn fe_component_transfer(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feComponentTransfer", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feComposite)
pub fn fe_composite(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feComposite", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix)
pub fn fe_convolve_matrix(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feConvolveMatrix", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting)
pub fn fe_diffuse_lighting(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feDiffuseLighting", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap)
pub fn fe_displacement_map(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feDisplacementMap", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight)
pub fn fe_distant_light(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feDistantLight", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow)
pub fn fe_drop_shadow(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feDropShadow", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFlood)
pub fn fe_flood(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feFlood", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA)
pub fn fe_func_a(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feFuncA", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB)
pub fn fe_func_b(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feFuncB", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG)
pub fn fe_func_g(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feFuncG", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR)
pub fn fe_func_r(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feFuncR", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur)
pub fn fe_gaussian_blur(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feGaussianBlur", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feImage)
pub fn fe_image(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feImage", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMerge)
pub fn fe_merge(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feMerge", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode)
pub fn fe_merge_node(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feMergeNode", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology)
pub fn fe_morphology(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feMorphology", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feOffset)
pub fn fe_offset(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feOffset", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight)
pub fn fe_point_light(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("fePointLight", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting)
pub fn fe_specular_lighting(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feSpecularLighting", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight)
pub fn fe_spot_light(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feSpotLight", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feTile)
pub fn fe_tile(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feTile", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence)
pub fn fe_turbulence(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("feTurbulence", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/filter)
pub fn filter(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("filter", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject)
pub fn foreign_object(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("foreignObject", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/g)
pub fn g(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("g", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/hatch)
pub fn hatch(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("hatch", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/hatchpath)
pub fn hatchpath(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("hatchpath", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/image)
pub fn image(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("image", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/line)
pub fn line(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("line", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient)
pub fn linear_gradient(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("linearGradient", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/marker)
pub fn marker(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("marker", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/mask)
pub fn mask(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("mask", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/metadata)
pub fn metadata(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("metadata", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/mpath)
pub fn mpath(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("mpath", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/path)
pub fn path(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("path", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/pattern)
pub fn pattern(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("pattern", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/polygon)
pub fn polygon(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("polygon", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/polyline)
pub fn polyline(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("polyline", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient)
pub fn radial_gradient(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("radialGradient", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/rect)
pub fn rect(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("rect", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/script)
pub fn script(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("script", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/set)
pub fn set(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("set", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/stop)
pub fn stop(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("stop", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/style)
pub fn style(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("style", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/svg)
pub fn svg(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("svg", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/switch)
pub fn switch(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("switch", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/symbol)
pub fn symbol(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("symbol", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/text)
pub fn text(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("text", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/textPath)
pub fn text_path(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("textPath", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/title)
pub fn title(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("title", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/tspan)
pub fn tspan(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("tspan", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/use)
pub fn use_(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("use", attrs, children)
}

/// [Documentation](https://developer.mozilla.org/docs/Web/SVG/Element/view)
pub fn view(attrs, children: List(Component)) {
  let attrs = to_props(attrs)
  redraw.jsx("view", attrs, children)
}
