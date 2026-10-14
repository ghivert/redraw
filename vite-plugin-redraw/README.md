# vite-plugin-redraw

React Fast Refresh for [Redraw](https://hexdocs.pm/redraw) components. Edit a
Gleam component, save, and see the change in the browser while mounted
components keep their state.

## Setup

```sh
yarn add --dev vite-plugin-redraw vite-gleam @vitejs/plugin-react
```

```ts
// vite.config.ts
import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import gleam from "vite-gleam"
import redraw from "vite-plugin-redraw"

export default defineConfig({
  // `gleam()` must come before `redraw()`.
  plugins: [gleam(), react(), redraw()],
})
```

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
- When the hooks of a component change, React remounts it, as it does for
  JSX components.

## Limitations

- Only zero-argument factories are re-run after a hot update. A module whose
  components are all built by parameterized factories falls back to a full
  reload.
- Two components with the same display name in the same module share the
  same Fast Refresh identity. Give them distinct names.
- Contexts created with `create_context_` are kept by call site, so a new
  default value is not applied until a full reload.
- Pass `ignore: ["some_package/"]` to skip compiled dependencies that
  should not be transformed.
