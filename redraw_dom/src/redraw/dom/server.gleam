import redraw.{type Component}

/// Renders a React tree to an HTML string.
///
/// [Documentation](https://react.dev/reference/react-dom/server/renderToString)
@external(javascript, "./server.ffi.mjs", "renderToString")
pub fn render_to_string(component: Component) -> String

/// Renders a non-interactive React tree to an HTML string.
///
/// [Documentation](https://react.dev/reference/react-dom/server/renderToStaticMarkup)
@external(javascript, "./server.ffi.mjs", "renderToStaticMarkup")
pub fn render_to_static_markup(component: Component) -> String
