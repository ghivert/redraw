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
 */
export default function redraw(options = {}) {
  const ignore = options.ignore ?? []
  let root = process.cwd()
  let base = "/"
  let packageName = null
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

  const isCompiledModule = (id) => {
    const [file] = id.split("?")
    if (file.endsWith(".gleam")) return true
    if (!file.endsWith(".mjs")) return false
    const relative = path.relative(buildDir(), file)
    if (relative.startsWith("..") || path.isAbsolute(relative)) return false
    // Redraw itself does not need to be transformed, only its users.
    if (relative.startsWith(`redraw${path.sep}`)) return false
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
    configResolved() {
      packageName = readPackageName(root)
    },
    async transform(code, id, options) {
      if (!enabled || options?.ssr) return
      if (!isCompiledModule(id)) return
      // Fast path: modules not importing `redraw` have nothing to refresh.
      if (!code.includes("redraw.mjs")) return
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

function normalize(file) {
  return file.split(path.sep).join("/")
}
