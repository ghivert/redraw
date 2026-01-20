## v19.2.2 - 2025-01-20

- Improves interoperability between different Redraw packages.

## v19.2.1 - 2025-12-26

- Fix broken backwards-compatibility. Deprecated 19.2.0.

## v19.2.0 - 2025-12-24

Redraw underwent a major rethought, to improve type-safety, and simplify
developer experience. In earlier versions of Redraw, you had to write component
factory functions behaving like standard functions. Those factory functions
could lead to interrogations and confusion in the code. For example, it was
usual for a newcomer to write something like:

```gleam
fn counter() {
  use <- redraw.standalone("Counter")
  html.div([], [
    // Some code here.
  ])
}

fn app() {
  use <- redraw.standalone("App")
  html.div([], [
    counter()()
  ])
}
```

While the compiler infer correct type-checking, a subtle error has been
introduced here: the `Counter` component gets regenerated every time `App` gets
repaint. When a new function is generated like that, the runtime will consider
that new function as a whole different component. Which is clearly not the
behaviour needed.

To fix those issues, a new way to write components have been introduced:
`redraw.component_`, and its best friend `redraw.compose`. Every component have
now _one and only one_ way to be written, using `redraw.component_`. That
function will create a proper component, which can not be used outside of
`redraw.compose`. And due to how `redraw.compose` is working, your only choice
when calling that function is to return another component. Let's take an
example.

```gleam
fn counter() -> redraw.ReactComponent(Nil) {
  use _ <- redraw.component_("Counter")
  html.div([], [
    // Some code here.
  ])
}

fn app() -> redraw.ReactComponent(Nil) {
  // `counter` does not return a function anymore, but a `ReactComponent`.
  let my_counter: redraw.ReactComponent(Nil) = counter()

  // `redraw.compose` unwraps the `ReactComponent` to a usable function.
  use my_counter: fn (Nil) -> Element <- redraw.compose(my_counter)

  // `redraw.compose` requires a `ReactComponent` as return value.
  // With that mechanism, it's impossible to unwrap a component outside of
  // the bootstrap phase of Redraw.
  use _ <- redraw.component_("App")

  // Usual body of a Redraw component. It's now impossible to end up in a
  // similar situation as above: `my_counter` is not callable anymore, and can
  // only be used in conjuction with `compose`.
  html.div([], [
    my_counter(Nil)
  ])
}
```

To help you transition to the new API, Redraw provides some help:

- `Element` has now been introduced, as the correct way to type HTML Elements
  and the result of Component execution. It conforms to the usual `JSX.Element`
  which can be found in TypeScript for example.
- `ReactComponent` is a new type introduced to replace `Component` in long-term.
  To ease the transition, Redraw does not force you to use the new API yet, and
  while completely transition to the new API after React 20 will be released.

### New features

- Introducing `redraw.compose` and `redraw.component_`, in order to avoid
  confusion on function calling.
- Introduce `Element` type, describing correctly the old `Component` type.
- Introduce `ReactComponent` while transitioning to React 20.

### Bugfixes

- Add support for every type of props. Redraw will not reject you if you pass
  props that were previously not compatible with the runtime. Redraw serialize
  and unserialize every type of props properly, while trying to keep the
  devtools clean.

### Deprecations

- Deprecate `Component` in favour of `Element`.
- Deprecate `redraw.component`, `redraw.element` and `redraw.standalone` in
  favour of `redraw.component_` and `redraw.compose`.
- Deprecate context-related functions & types in favour of `redraw_unsafe`.
- Deprecate ref-related functions in favour of `redraw/ref`. While it was
  perfectly working before, Redraw tries to improve namespacing, and tries to
  reduce the scope of functions accessible directly from the main `redraw`
  module.
- Deprecate `to_element` & `to_component` functions. FFI should now be done by
  hand. More documentation and packages to come to help on that subject.

## v19.1.1 - 2025-11-06

- No changes, keep in sync with `redraw_dom`.

## v19.1.0 - 2025-11-06

- Fix `keyed` children.

## v19.0.6 - 2025-09-17

- Add `use_layout_effect_` to be able to return a cleanup function.

## v19.0.5 - 2025-09-15

- No changes, keep in sync with `redraw_dom`.

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
