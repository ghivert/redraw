import redraw.{type Component}

/// Root to display React DOM.
///
/// [Documentation](https://react.dev/reference/react-dom/client/createRoot#createroot)
pub type Root

/// Let you create a root to display React components inside a browser DOM node.
///
/// [Documentation](https://react.dev/reference/react-dom/client/createRoot)
@external(javascript, "../redraw_dom.ffi.mjs", "createRoot")
pub fn create_root(root: String) -> Root

/// Let you display React components inside a browser DOM node whose HTML content
/// was previously generated by `react-dom/server`.
///
/// [Documentation](https://react.dev/reference/react-dom/client/hydrateRoot)
@external(javascript, "../redraw_dom.ffi.mjs", "hydrateRoot")
pub fn hydrate_root(root: String, node: Component) -> Root

/// Call `render(root)` to display a piece of JSX (“React node”) into the React
/// root’s browser DOM node.
///
/// [Documentation](https://react.dev/reference/react-dom/client/createRoot#root-render)
@external(javascript, "../redraw_dom.ffi.mjs", "render")
pub fn render(root: Root, child: Component) -> Nil

/// Let you render some children into a different part of the DOM.
///
/// [Documentation](https://react.dev/reference/react-dom/createPortal)
@external(javascript, "../redraw_dom.ffi.mjs", "createPortal")
pub fn create_portal(children: Component, root: String) -> Component
