## v19.0.4 - 2025-09-11

- No changes, keep in sync with `redraw_dom`.

## v19.0.3 - 2025-09-11

- No changes, keep in sync with `redraw_dom`.

## v19.0.2 - 2025-09-05

- Avoid passing `children` to props when `children` is an empty `List`. This
  make sure to not mess with `dangerouslySetInnerHTML`.

## v19.0.1 - 2025-09-02

- No changes, keep in sync with `redraw_dom`.

## v19.0.0 - 2025-08-31

- Upgrade Redraw to React 19.
- Integrates latest hooks from React 19.
- Integrates latest API changes from React 19.
- Rename `component_` to `element` and `component__` to `standalone`.
- Changes `use_context` from `useContext` to `use`.
- Add better errors.

## v2.0.3 - 2025-08-27

- Bump `gleam_javascript` dependency.

## v2.0.2 - 2025-04-16

- Fix FFI `suspense` external.

## v2.0.1 - 2025-03-14

- Add support for `Nil` as props, instead of panicking.
- Adapt to latest stdlib version (remove `function.flip`).

## v2.0.0 - 2024-12-24

- Remove DOM attributes and elements in favour of `redraw_dom`. Keep only React
  core to simplify support for all flavours of React (DOM, Native, etc.). This
  decrease package size when DOM is unused.

## v1.1.1 - 2024-12-23

- Add documentation for every functions.
- Bump minimal required versions.
- Add `offset_x`, `offset_y`, `altitude_angle` & `azimuth_angle`.

## v1.1.0 - 2024-21-08

- Documentation improvements.
- `html.none` added to `redraw/element/html`.
- `Context` usage has been improved. In JavaScript, contexts are usually
  instantiated as top level side-effects. Because Gleam does not accepts any
  top-level code execution, contexts now have proper helpers to mitigate the
  issue.
- `use_callback` and `use_effect_` now have proper types.

## v1.0.0 - 2024-07-21

- First release of Redraw! 🎉
- Redraw implements a subset of React, and starts at React 18. Previous versions
  are not guaranteed to work. Under-the-hood, Redraw uses `react/jsx-runtime`,
  and as such, requires a modern toolchain installed, whether it's Next.js or
  Vite.
