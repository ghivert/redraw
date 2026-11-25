//// Rules on the calls to `component_`: the transform tags the render
//// function at the call site, and derives the component identity from the
//// module and the display name.

import glance
import gleam/dict
import gleam/list
import gleam/option.{None, Some}
import redraw_lint/diagnostic.{type Diagnostic}
import redraw_lint/factories.{type Analysis, Component}
import redraw_lint/loader.{type Module}

/// Rule 3: `component_` called with a render that is not a function
/// literal, or outside the body of a module-level function.
pub fn check_attribution(
  module: Module,
  analysis: Analysis,
) -> List(Diagnostic) {
  use component <- list.filter_map(analysis.components)
  case component {
    Component(inline: False, ..) ->
      Ok(at(
        module,
        component.location,
        diagnostic.UnattributedComponent,
        "The render function of this component is not written inline in the call to `component_`: the Fast Refresh transform cannot attribute the component to its module, and it is left out of Fast Refresh. Call `component_` directly in the factory, with `use props <- component_(\"Name\")` or an inline `fn`, rather than through a wrapper, a pipe or a function capture.",
      ))
    Component(nested: True, ..) ->
      Ok(at(
        module,
        component.location,
        diagnostic.UnattributedComponent,
        "`component_` is called inside an anonymous function, not in the body of a module-level function: the component is not re-created when the factory is re-run after a hot update, and it is left out of Fast Refresh. Build every component in a module-level function, with `use props <- component_(\"Name\")` or an inline `fn`, and compose it from the parent with `compose`.",
      ))
    _ -> Error(Nil)
  }
}

/// Rule 4: two components with the same name in the same module.
pub fn check_names(
  module: Module,
  analyses: List(Analysis),
) -> List(Diagnostic) {
  let components = list.flat_map(analyses, fn(analysis) { analysis.components })
  let counts =
    list.fold(components, dict.new(), fn(counts, component) {
      case component.name {
        Some(name) ->
          dict.upsert(counts, name, fn(n) { option.unwrap(n, 0) + 1 })
        None -> counts
      }
    })
  use component <- list.filter_map(components)
  case component.name {
    Some(name) ->
      case dict.get(counts, name) {
        Ok(count) if count > 1 ->
          Ok(at(
            module,
            component.location,
            diagnostic.DuplicateComponentName,
            "Several components are named \""
              <> name
              <> "\" in this module: they share the same Fast Refresh identity, and after a hot update every instance would render with the last one registered. Give each component a distinct name.",
          ))
        _ -> Error(Nil)
      }
    None -> Error(Nil)
  }
}

fn at(
  module: Module,
  location: glance.Span,
  rule: diagnostic.Rule,
  message: String,
) -> Diagnostic {
  diagnostic.new(
    rule:,
    module: module.name,
    path: module.path,
    source: module.source,
    location:,
    message:,
  )
}
