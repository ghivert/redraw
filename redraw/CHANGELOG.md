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
