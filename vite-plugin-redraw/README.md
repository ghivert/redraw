# vite-plugin-redraw

React Fast Refresh for [Redraw](https://hexdocs.pm/redraw) components. Edit a
Gleam component, save, and see the change in the browser while mounted
components keep their state.

## Setup

The plugin works on the compiled Gleam output, so a loader compiling Gleam
in Vite is needed. Both
[`@chouquette/gleam-vite-loader`](https://www.npmjs.com/package/@chouquette/gleam-vite-loader)
and [`vite-gleam`](https://www.npmjs.com/package/vite-gleam) are supported.
It also needs a version of `redraw` that includes Fast Refresh support, see
the `redraw` changelog.

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
  plugins: [gleam(), react(), redraw()],
})
```

The order of the plugins does not matter: `redraw()` always runs after the
loader. At startup, the dev server logs the Gleam packages Fast Refresh is
enabled for, and every page reload decided by the plugin is explained in the
browser console, with the Gleam source involved.

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
  matching and equality keep working across generations. This applies to
  every module of the root package and of its path dependencies, including
  modules that only define types. Whether editing a path dependency triggers
  an update at all depends on the Gleam loader watching its sources: Vite
  only watches the project root by default.
- When the hooks of a component change, or the initial value of a state,
  React remounts the component, as it does for JSX components.
- A module is updated in place when only its components changed. When an
  export that importers may hold through an ESM binding changed, a helper, a
  custom hook or a constant, the update propagates to the importers, which
  re-run their own factories with the new bindings. A module re-executed
  because one of its dependencies changed propagates too when it has such
  exports, since importers reach the previous dependency through them.
  Modules without components, such as modules defining only types, always
  propagate. The entry module should export `main` and factories only: an
  update reaching it through a helper export reloads the page.
- When a factory throws while re-running, the error is reported, the
  application keeps the previous code, and the next save tries again.

## When the page is reloaded

Some edits cannot be applied to a running application. They are detected
when the updated module re-evaluates, and the page is reloaded, with the
reason printed in the console:

- A variant removed or renamed: values of that variant may still be held
  in a state, and no class can take them over.
- A record whose fields changed, a field added to a props type included:
  existing values keep their old shape.
- A component removed, renamed, or moved to another module: its mounted
  instances could not be refreshed.
- A change in `main`, which runs once.
- A change in the default value of a context.

As in Vite, a change in a module that no component module imports, such as
the entry script, reloads the page too.

## Rules and limitations

- Factories run once at startup, then once per hot update of their module.
  Anything that must exist once, such as a store, belongs in `main`, and
  reaches components through props or a context.
- Factory arguments should be static configuration: a variant, a size, a
  child component, some data. They are compared structurally, named
  functions by their name, and anonymous functions by a hash of their source
  code. A callback varying per instance belongs in the props, not in the
  factory arguments: two closures with the same code capturing different
  values, such as two results of `fn on_toggle(side) { fn(v) { ... } }`,
  share the same identity, and both instances would end up calling the last
  one after a refresh.
- Two components with the same display name in the same module, built with
  the same factory arguments, share the same Fast Refresh identity. Give
  them distinct names.
- Call `component_` directly in the factory, with the render function
  written inline. A wrapper such as `fn my_component(name, render)` calling
  `component_` for its callers cannot be attributed to the right module by
  the transform: components built through it are left out of Fast Refresh.
- Helpers receiving a component and returning it, such as
  `fn memo(c) { memoize_(c) }`, are not replayed after a hot update: all the
  render code lives in functions calling `component_`, which are replayed.
  A change in such a helper propagates to its importers like any other
  helper change.
- The type of a state is erased at runtime. Changing the initial value of a
  `use_state_` remounts the component, but if the initial value is a call
  whose return type changed elsewhere, the state keeps a value of the
  previous type, as in React.
- Rebuilding on a change in a handwritten FFI file, in `gleam.toml` or in
  `manifest.toml` is the loader's job. `@chouquette/gleam-vite-loader` from
  1.1.0 rebuilds on all of them, updates the FFI module and reloads the page
  on a configuration change; `vite-gleam` only rebuilds on `.gleam` files.
  Changes under `build/` are ignored by this plugin, since every save
  rewrites it: after a manual `gleam build` or `gleam add`, restart the dev
  server.
- A handwritten FFI file Babel cannot parse is served without Fast Refresh,
  with a warning.
- When the Gleam build fails, nothing is updated: the application keeps the
  previous code until the next successful build. Showing the compiler error
  in the browser is the loader's job.
- Only `@vitejs/plugin-react` is supported. If the installed runtime lacks
  one of the functions Redraw relies on, Fast Refresh is disabled with a
  warning naming it.
- Pass `ignore: ["some_package/"]` to skip compiled packages that should
  not be transformed.
