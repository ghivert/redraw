import redraw.{type Element}

/// Renders a React tree to an HTML string.
///
/// [Documentation](https://react.dev/reference/react-dom/server/renderToString)
@external(javascript, "react-dom/server", "renderToString")
pub fn render_to_string(component: Element) -> String

/// Renders a non-interactive React tree to an HTML string.
///
/// [Documentation](https://react.dev/reference/react-dom/server/renderToStaticMarkup)
@external(javascript, "react-dom/server", "renderToStaticMarkup")
pub fn render_to_static_markup(component: Element) -> String
