## v19.2.1 - 2025-12-26

- Fix broken backwards-compatibility. Deprecated 19.2.0.

## v19.2.0 - 2025-12-24

Redraw transitioned its API, from `redraw.component` to a more composable API,
using `redraw.component_` and `redraw.compose`. It requires some changes from
`redraw_dom`, mainly being able to run a `ReactComponent` with `render` instead
of the old way of simply calling a component. `render` is now deprecated in
favour of `render_`.

## v19.1.1 - 2025-11-06

- Add missing `on_drag_leave` event handler.

## v19.1.0 - 2025-11-06

- Add `key` attribute to simplify using keys in lists.

## v19.0.6 - 2025-09-17

- No changes, keep in sync with `redraw`.

## v19.0.5 - 2025-09-15

- Fix `input.data` and add `input.value`.

## v19.0.4 - 2025-09-11

- Add missing attributes.

## v19.0.3 - 2025-09-11

- Fix `class`. `class` was destructive rather than additive. To make sure
  everything stay 100% compatible with Lustre, `class` is now additive.

## v19.0.2 - 2025-09-05

- Fix `create_portal`.
- Fix invalid FFI code.

## v19.0.1 - 2025-09-02

- Fix wrong external link.

## v19.0.0 - 2025-08-31

- Integrates latest changes from React 19.
- Integrates latest hooks from React 19.

## v2.1.0 - 2025-08-28

- Add `html.element` function to support arbitrary HTML elements.
- Add `attribute.none` function to support none attributes.
- Add `events.none` an alias to `attribute.none` (to help development and
  simplify imports.)
- Add documentation for `attribute.attribute` function.

## v2.0.1 - 2025-08-09

- Update everything to handle removal of `dynamic.from`.

## v2.0.0 - 2024-12-24

- Bump dependencies versions requirements.
- Change `create_root`, `hydrate_root` & `create_portal` to return
  `Result(a, Nil)` instead of `a`. Those functions are now nicer to use, and can
  easily be overriden using `let assert`.
- Rename modules to improve namespacing. `create_root`, `hydrate_root` &
  `render` now belongs to `redraw/dom/client`. `create_portal` & `flush_sync`
  belongs to `redraw/dom`.
- Add DOM elements, attributes and events handling in `react/dom` namespace from
  `redraw`.

## v1.1.0 - 2024-08-12

- Improve documentation.
- Stay in sync with `redraw` core package.

## v1.0.0 - 2024-07-21

- First release of `redraw_dom`! 🎉
- Redraw DOM allows a simple access to browsers DOM, and provides
  browser-relative components.
