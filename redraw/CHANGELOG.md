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
