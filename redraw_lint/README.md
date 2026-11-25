# redraw_lint

Lints the Gleam sources of a [Redraw](https://hexdocs.pm/redraw) project for
the patterns that React Fast Refresh, through
[`vite-plugin-redraw`](../vite-plugin-redraw), cannot handle. The transform
of the plugin works on the compiled output, where the Gleam types are gone:
this linter checks, on the source, what the transform has to assume.

## Usage

Add the package to the dev dependencies of a Redraw project, then run it
from the project root:

```sh
gleam add --dev redraw_lint
gleam run -m redraw_lint
```

Every warning gives the file, the line, the risk and the fix. The exit code
is 1 when there is at least one warning. `--json` prints the warnings as a
JSON array of `{rule, module, path, line, column, message}` objects, for
tools. A directory can be given to lint another project:

```sh
gleam run -m redraw_lint -- --json ../app
```

The project must have been built once (`gleam build`), or at least have its
dependencies downloaded: the types and functions of the dependencies are
resolved from their sources, under `build/packages` for Hex packages and at
their path for path dependencies, as listed in `manifest.toml`.

### From JavaScript

The compiled module exports the same entry points, for a Vite plugin
running the linter at every hot update:

```js
import { lint_directory, to_json } from "./build/dev/javascript/redraw_lint/redraw_lint.mjs"

const result = await lint_directory(root) // Ok(List(Diagnostic)) | Error(...)
if (result.isOk()) console.log(to_json(result[0]))
```

`lint_project` takes a project built with `project.from_sources`, for a
caller keeping the sources in memory.

## Language server

`gleam run -m redraw_lint/lsp` starts a language server on stdin and stdout,
which publishes the warnings while you type, saved or not. It runs next to
the Gleam language server, and only publishes diagnostics.

- Projects are found from the files the editor opens: the closest directory
  with a `gleam.toml` listing `redraw_lint` in its dependencies. Other Gleam
  projects, such as the libraries of the project, are left alone.
- After a change, the whole root package is linted again once the editor has
  been quiet for 150 ms, since a change in a type can raise a warning in
  another module. Only changed modules are parsed again.
- A buffer that does not parse keeps its previous warnings: the Gleam
  language server already reports the syntax error.
- Changes to `gleam.toml` or `manifest.toml` need a restart of the server.

### Zed

The extension in [`zed/`](zed) registers the server for Gleam files. Until
it is published, install it as a dev extension: run `zed: install dev
extension` from the command palette, and select the `zed` directory. Zed
builds it with the Rust toolchain installed by rustup, with the
`wasm32-wasip2` target.

The extension starts the server of the project, so the project must depend
on `redraw_lint`. It runs the compiled server with Node when the project has
been built, which starts at once even when the project does not compile,
and `gleam run -m redraw_lint/lsp` otherwise. When the folder opened in Zed
is not the Gleam project itself, as in a monorepo, set the command in the
settings:

```json
{
  "lsp": {
    "redraw-lint": {
      "binary": {
        "path": "node",
        "arguments": [
          "--input-type=module",
          "-e",
          "import { main } from '/absolute/path/to/app/build/dev/javascript/redraw_lint/redraw_lint/lsp.mjs'; main()"
        ]
      }
    }
  }
}
```

The server logs to the `Redraw Lint` entry of `dev: open language server
logs`. To disable it for a project, add `"!redraw-lint"` to the
`language_servers` of Gleam in the project settings.

## Rules

Each rule reproduces a heuristic of the transform, documented in the
"Rules and limitations" section of the plugin README.

- `factory-function-argument`: a parameter of a parameterized factory, or a
  field of it, is a function. Fast Refresh identifies the components built
  by a parameterized factory by its arguments, and compares anonymous
  functions by their code: two closures with the same code capturing
  different values share an identity. A callback varying per instance
  belongs in the props.
- `factory-external-argument`: a parameter of a parameterized factory, or a
  field of it, has a type declared without constructors, that is a handle
  built in FFI, such as a store. The transform compares it by its fields:
  two handles with the same shape share an identity. Create the value in
  `main` and pass it through a context, which is identified by its own
  identity. Allowed: custom types with constructors whose fields are
  allowed, basic types, `List`, tuples, `Option`, `Result` and `Dict` of
  allowed types, `redraw.Context`, `redraw.ReactComponent`. Type variables
  are left unchecked.
- `factory-unannotated-argument`: a parameter of a parameterized factory
  has no type annotation, so the two rules above cannot check it.
- `component-not-inline`: `component_` is called with a render that is not
  a function literal (through a wrapper, a pipe or a function capture), or
  inside an anonymous function: the component is left out of Fast Refresh.
- `duplicate-component-name`: two components of a module share a name, and
  so a Fast Refresh identity.
- `entry-module-export`: the module defining `main` exports a function that
  is neither `main` nor a factory, or a constant: an update reaching it
  reloads the page.
- `impure-factory`: a factory calls, outside its render functions, a
  function declared with `@external(javascript, ...)`, directly or through
  functions of the project: factories are re-run on every hot update of
  their module, and must be pure. `component_`, `compose`, `memoize_`,
  `create_context_` and the standard library are allowed. Functions of
  dependencies are not followed.
- `unparsable-module`: a module glance cannot parse is not linted.

A factory is, as for the transform, a module-level function calling
`redraw.component_` with a function literal, `redraw.compose` or
`redraw.memoize_`. A parameterized factory is replayed only when it calls
`component_` itself; a parameterized helper that only calls `compose` or
`memoize_`, such as `fn memo(c) { memoize_(c) }`, is not, and its
parameters are not checked.

## Development

```sh
gleam test
gleam build && node --test integration/lsp.test.mjs
gleam format src test
```

The integration test drives the language server over stdin and stdout, as
an editor would, on buffers of `example/` changed in memory.

The fixtures under `fixtures/` are mini projects linted by the tests against
the `redraw` and `redraw_dom` sources of the repository: one per rule, with
the cases that must not be reported. The `example/` project of the
repository is linted too, and must pass without warning.
