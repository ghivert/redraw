import react.{type Component}
import react/internals/attribute.{to_props}

pub fn a(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("a", attrs, children)
}

pub fn animate(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("animate", attrs, children)
}

pub fn animate_motion(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("animateMotion", attrs, children)
}

pub fn animate_transform(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("animateTransform", attrs, children)
}

pub fn circle(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("circle", attrs, children)
}

pub fn clip_path(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("clipPath", attrs, children)
}

pub fn defs(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("defs", attrs, children)
}

pub fn desc(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("desc", attrs, children)
}

pub fn discard(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("discard", attrs, children)
}

pub fn ellipse(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("ellipse", attrs, children)
}

pub fn fe_blend(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feBlend", attrs, children)
}

pub fn fe_color_matrix(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feColorMatrix", attrs, children)
}

pub fn fe_component_transfer(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feComponentTransfer", attrs, children)
}

pub fn fe_composite(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feComposite", attrs, children)
}

pub fn fe_convolve_matrix(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feConvolveMatrix", attrs, children)
}

pub fn fe_diffuse_lighting(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feDiffuseLighting", attrs, children)
}

pub fn fe_displacement_map(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feDisplacementMap", attrs, children)
}

pub fn fe_distant_light(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feDistantLight", attrs, children)
}

pub fn fe_drop_shadow(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feDropShadow", attrs, children)
}

pub fn fe_flood(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feFlood", attrs, children)
}

pub fn fe_func_a(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feFuncA", attrs, children)
}

pub fn fe_func_b(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feFuncB", attrs, children)
}

pub fn fe_func_g(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feFuncG", attrs, children)
}

pub fn fe_func_r(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feFuncR", attrs, children)
}

pub fn fe_gaussian_blur(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feGaussianBlur", attrs, children)
}

pub fn fe_image(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feImage", attrs, children)
}

pub fn fe_merge(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feMerge", attrs, children)
}

pub fn fe_merge_node(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feMergeNode", attrs, children)
}

pub fn fe_morphology(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feMorphology", attrs, children)
}

pub fn fe_offset(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feOffset", attrs, children)
}

pub fn fe_point_light(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("fePointLight", attrs, children)
}

pub fn fe_specular_lighting(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feSpecularLighting", attrs, children)
}

pub fn fe_spot_light(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feSpotLight", attrs, children)
}

pub fn fe_tile(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feTile", attrs, children)
}

pub fn fe_turbulence(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("feTurbulence", attrs, children)
}

pub fn filter(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("filter", attrs, children)
}

pub fn foreign_object(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("foreignObject", attrs, children)
}

pub fn g(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("g", attrs, children)
}

pub fn hatch(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("hatch", attrs, children)
}

pub fn hatchpath(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("hatchpath", attrs, children)
}

pub fn image(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("image", attrs, children)
}

pub fn line(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("line", attrs, children)
}

pub fn linear_gradient(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("linearGradient", attrs, children)
}

pub fn marker(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("marker", attrs, children)
}

pub fn mask(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("mask", attrs, children)
}

pub fn metadata(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("metadata", attrs, children)
}

pub fn mpath(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("mpath", attrs, children)
}

pub fn path(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("path", attrs, children)
}

pub fn pattern(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("pattern", attrs, children)
}

pub fn polygon(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("polygon", attrs, children)
}

pub fn polyline(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("polyline", attrs, children)
}

pub fn radial_gradient(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("radialGradient", attrs, children)
}

pub fn rect(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("rect", attrs, children)
}

pub fn script(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("script", attrs, children)
}

pub fn set(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("set", attrs, children)
}

pub fn stop(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("stop", attrs, children)
}

pub fn style(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("style", attrs, children)
}

pub fn svg(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("svg", attrs, children)
}

pub fn switch(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("switch", attrs, children)
}

pub fn symbol(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("symbol", attrs, children)
}

pub fn text(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("text", attrs, children)
}

pub fn text_path(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("textPath", attrs, children)
}

pub fn title(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("title", attrs, children)
}

pub fn tspan(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("tspan", attrs, children)
}

pub fn use_(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("use", attrs, children)
}

pub fn view(attrs, children) {
  let attrs = to_props(attrs)
  react.jsx("view", attrs, children)
}
