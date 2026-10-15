# vite-plugin-redraw

React Fast Refresh for [Redraw](https://hexdocs.pm/redraw) components. Edit a
Gleam component, save, and see the change in the browser while mounted
components keep their state.

## Setup

The plugin works on the compiled Gleam output, so a loader compiling Gleam
in Vite is needed, placed before it. Both
[`@chouquette/gleam-vite-loader`](https://www.npmjs.com/package/@chouquette/gleam-vite-loader)
and [`vite-gleam`](https://www.npmjs.com/package/vite-gleam) are supported.

```sh
yarn add --dev vite-plugin-redraw @chouquette/gleam-vite-loader @vitejs/plugin-react
```

```ts
// vite.config.ts
import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import { gleamImportPlugin as gleam } from "@chouquette/gleam-vite-loader"
import redraw from "vite-plugin-redraw"

export default defineConfig({
  // `gleam()` must come before `redraw()`.
  plugins: [gleam(), react(), redraw()],
})
```

With `vite-gleam`, replace the loader import by `import gleam from "vite-gleam"`.

The plugin is development-only: production builds are left untouched.

## How it works

Gleam cannot run code at module level, so Redraw components are only created
when their factory is called, inside the `compose` chain. React Fast Refresh
cannot find them by itself. The plugin bridges the gap:

- A Babel transform on the compiled Gleam output tags every render function
  passed to `redraw.component_` with its module path and hooks signature.
  Redraw uses the tag to register each component under a stable id.
- When a module is hot updated, the transform re-runs its component
  factories, which register the new render functions under the same ids,
  then asks React to refresh. Mounted components are updated in place.
- Parameterized factories, such as `fn button(variant: Variant)`, build one
  component per set of arguments. The arguments are part of the component
  id, and every call is recorded, so the factory is replayed with the same
  arguments after a hot update.
- Every Gleam value is an instance of a class, matched with `instanceof` by
  the compiled code. After a hot update, values built before the update, or
  kept in hooks state, are reconciled with the new classes, so pattern
  matching and equality keep working across generations.
- When the hooks of a component change, React remounts it, as it does for
  JSX components.

## Limitations

- Two components with the same display name in the same module, built with
  the same factory arguments, share the same Fast Refresh identity. Give
  them distinct names.
- Factory arguments should be static configuration: a variant, a size, a
  child component, some data. They are compared structurally, named
  functions by their name, and anonymous functions by a hash of their source
  code. A callback varying per instance belongs in the props, not in the
  factory arguments: two closures with the same code capturing different
  values, such as two results of `fn on_toggle(side) { fn(v) { ... } }`,
  share the same identity, and both instances would end up calling the last
  one after a refresh.
- Helpers receiving a component and returning it, such as
  `fn memo(c) { memoize_(c) }`, are not replayed after a hot update. All the
  render code lives in functions calling `component_`, which are replayed,
  so a helper has nothing to refresh. The only effect is that a change in the
  helper itself, like memoizing or not, waits for a full reload when its
  module self-accepts the update.
- Contexts created with `create_context_` are kept by call site, so a new
  default value is not applied until a full reload.
- Pass `ignore: ["some_package/"]` to skip compiled dependencies that
  should not be transformed.
