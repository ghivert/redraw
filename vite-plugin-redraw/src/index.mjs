import { readFileSync } from "node:fs"
import path from "node:path"
import { transformAsync } from "@babel/core"
import { redrawRefresh } from "./transform.mjs"

const HOT_IMPORT = "virtual:redraw/hot"
const HOT_FILE = "build/dev/javascript/redraw/redraw/internal/hot.ffi.mjs"
const BUILD_DIR = "build/dev/javascript"

/** Vite plugin enabling React Fast Refresh for Redraw components.
 *
 * Requirements:
 * - A Gleam loader placed before this plugin, to compile Gleam modules:
 *   `@chouquette/gleam-vite-loader` or `vite-gleam`.
 * - `@vitejs/plugin-react`, which ships and installs the React Refresh runtime.
 *
 * The plugin is development-only. In production builds, no transform is
 * applied and Redraw's hot module is inert.
 *
 * Only the modules of the root package and of the local path dependencies
 * are transformed: they are the ones that can change during a session. Hex
 * packages are left alone.
 */
export default function redraw(options = {}) {
  const ignore = options.ignore ?? []
  let root = process.cwd()
  let base = "/"
  let packageName = null
  let localPackages = new Set()
  let enabled = false

  const hotFile = () => path.join(root, HOT_FILE)
  const buildDir = () => path.join(root, BUILD_DIR)

  /** Vite module id of the compiled output of a Gleam source file. */
  const compiledPath = (file) => {
    if (!packageName) return null
    const relative = path.relative(root, file)
    if (!relative.startsWith(`src${path.sep}`)) return null
    const module = relative.slice(4).replace(/\.gleam$/, ".mjs")
    return path.join(buildDir(), packageName, module)
  }

  /** Human readable, unique id for a module. Used in Fast Refresh ids and
   * in context keys. */
  const moduleId = (id) => {
    const [file] = id.split("?")
    if (file.endsWith(".gleam")) return normalize(path.relative(root, file))
    return normalize(path.relative(buildDir(), file))
  }

  const isLocalModule = (id) => {
    const [file] = id.split("?")
    if (file.endsWith(".gleam")) return true
    if (!file.endsWith(".mjs")) return false
    if (file === hotFile()) return false
    const relative = path.relative(buildDir(), file)
    if (relative.startsWith("..") || path.isAbsolute(relative)) return false
    const [pkg, ...rest] = relative.split(path.sep)
    if (!localPackages.has(pkg)) return false
    // `gleam.mjs` re-exports the prelude for each package, and the hot module
    // imports it: transforming it would create an import cycle.
    if (rest.length === 1 && rest[0] === "gleam.mjs") return false
    return !ignore.some((prefix) => relative.startsWith(prefix))
  }

  const resolvePlugin = {
    name: "redraw:resolve",
    enforce: "pre",
    configResolved(config) {
      root = config.root
      base = config.base
      enabled = config.command === "serve" && !config.isProduction
    },
    resolveId(source) {
      if (source === HOT_IMPORT) return hotFile()
    },
    transformIndexHtml() {
      if (!enabled) return
      // Expose the React Refresh runtime installed by `@vitejs/plugin-react`
      // to Redraw. The runtime is a singleton: registering families in a
      // separate copy would make them invisible to React.
      return [
        {
          tag: "script",
          attrs: { type: "module" },
          injectTo: "head",
          children: `import * as RefreshRuntime from "${base}@react-refresh";
globalThis.__REDRAW_REFRESH__ = RefreshRuntime;`,
        },
      ]
    },
  }

  const refreshPlugin = {
    name: "redraw:refresh",
    enforce: "post",
    apply: "serve",
    configResolved(config) {
      packageName = readPackageName(root)
      localPackages = readLocalPackages(root)
      if (packageName) localPackages.add(packageName)
      if (!enabled) return
      const names = config.plugins.map((plugin) => plugin.name)
      if (!names.some((name) => name.startsWith("vite:react"))) {
        config.logger.warn(
          "[vite-plugin-redraw] @vitejs/plugin-react is not configured: it ships the React Refresh runtime, nothing will be refreshed.",
        )
      }
    },
    buildStart() {
      if (!enabled) return
      try {
        readFileSync(hotFile())
      } catch {
        this.warn(
          `[vite-plugin-redraw] ${HOT_FILE} is missing: the installed version of redraw does not support Fast Refresh.`,
        )
      }
    },
    async transform(code, id, options) {
      if (!enabled || options?.ssr) return
      if (!isLocalModule(id)) return
      const result = await transformAsync(code, {
        configFile: false,
        babelrc: false,
        filename: id,
        sourceFileName: id,
        sourceMaps: true,
        parserOpts: { sourceType: "module" },
        plugins: [[redrawRefresh, { moduleId: moduleId(id), hotImport: HOT_IMPORT }]],
      })
      if (!result) return
      return { code: result.code, map: result.map }
    },
    handleHotUpdate({ file, modules, server }) {
      if (!enabled) return
      if (file.endsWith(".gleam")) {
        // The Gleam loader has already rebuilt the project at this point.
        // The changed source may not be in the module graph (`vite-gleam`
        // imports the entry `.gleam` directly, `@chouquette/gleam-vite-loader`
        // resolves `gleam:` ids to compiled files), but its compiled output
        // is.
        const compiled = compiledPath(file)
        if (!compiled) return
        const extra = server.moduleGraph.getModulesByFile(compiled)
        if (!extra) return
        return [...new Set([...modules, ...extra])]
      }
      // Compiled files change on every `gleam build`. Their updates are
      // handled when the Gleam source changes, so ignore them here to avoid
      // a second refresh.
      if (file.startsWith(buildDir())) return []
    },
  }

  return [resolvePlugin, refreshPlugin]
}

function readPackageName(root) {
  try {
    const toml = readFileSync(path.join(root, "gleam.toml"), "utf8")
    const match = toml.match(/^\s*name\s*=\s*"([^"]+)"/m)
    return match ? match[1] : null
  } catch {
    return null
  }
}

/** Names of the path dependencies listed in `manifest.toml`. */
function readLocalPackages(root) {
  const packages = new Set()
  try {
    const toml = readFileSync(path.join(root, "manifest.toml"), "utf8")
    const entries = toml.matchAll(/\{\s*name\s*=\s*"([^"]+)"[^}]*source\s*=\s*"local"/g)
    for (const [, name] of entries) packages.add(name)
  } catch {
    // No manifest: only the root package is transformed.
  }
  return packages
}

function normalize(file) {
  return file.split(path.sep).join("/")
}
