## Unreleased

- Bump dependencies versions requirements.
- Change `create_root`, `hydrate_root` & `create_portal` to return
  `Result(a, Nil)` instead of `a`. Those functions are now nicer to use, and can
  easily be overriden using `let assert`.

## v1.1.0 - 2024-08-12

- Improve documentation.
- Stay in sync with `redraw` core package.

## v1.0.0 - 2024-07-21

- First release of `redraw_dom`! 🎉
- Redraw DOM allows a simple access to browsers DOM, and provides
  browser-relative components.
