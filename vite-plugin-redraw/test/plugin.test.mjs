import { test } from "node:test"
import assert from "node:assert/strict"
import path from "node:path"
import { fileURLToPath } from "node:url"
import { utimesSync, statSync } from "node:fs"
import redraw from "../src/index.mjs"

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../example")
const build = path.join(root, "build/dev/javascript")

function plugin() {
  const [, refresh] = redraw()
  const [resolve] = redraw()
  const config = {
    root,
    base: "/",
    command: "serve",
    isProduction: false,
    plugins: [{ name: "vite:react-babel" }],
    logger: { warn() {}, info() {} },
  }
  resolve.configResolved(config)
  refresh.configResolved(config)
  return redraw().map((p) => (p.configResolved(config), p))
}

async function transform(code, file) {
  const [, refresh] = plugin()
  const warnings = []
  const result = await refresh.transform.call({ warn: (m) => warnings.push(m) }, code, file)
  return { result, warnings }
}

test("only the modules of local packages are transformed", async () => {
  const code = `export function f() {}`
  const local = await transform(code, path.join(build, "example/x.mjs"))
  assert.ok(local.result?.code.includes("$redraw_hot.types"))
  const dependency = await transform(code, path.join(build, "redraw_dom/redraw/dom/html.mjs"))
  assert.ok(dependency.result?.code.includes("$redraw_hot.types"))
  const hex = await transform(code, path.join(build, "gleam_stdlib/gleam/list.mjs"))
  assert.equal(hex.result, undefined)
  const prelude = await transform(code, path.join(build, "example/gleam.mjs"))
  assert.equal(prelude.result, undefined)
  const hot = await transform(code, path.join(build, "redraw/redraw/internal/hot.ffi.mjs"))
  assert.equal(hot.result, undefined)
})

test("compiled files changes are ignored and gleam sources map to their module", (t) => {
  const [, refresh] = plugin()
  const compiled = path.join(build, "example/example.mjs")
  const source = path.join(root, "src/example.gleam")
  const module = { id: compiled }
  const server = { moduleGraph: { getModulesByFile: (f) => (f === compiled ? new Set([module]) : undefined) } }
  // The build succeeded: the compiled output is newer than the source.
  const { atime, mtime } = statSync(compiled)
  t.after(() => utimesSync(compiled, atime, mtime))
  utimesSync(compiled, new Date(), new Date(Date.now() + 1000))
  assert.deepEqual(refresh.handleHotUpdate({ file: source, modules: [], server }), [module])
  // The build failed: the compiled output predates the edit, and the module
  // is not added to what the loader decided.
  utimesSync(compiled, new Date(), new Date(statSync(source).mtimeMs - 1000))
  assert.equal(refresh.handleHotUpdate({ file: source, modules: [], server }), undefined)
  assert.deepEqual(refresh.handleHotUpdate({ file: path.join(build, "example/example.mjs"), modules: [module], server }), [])
  assert.equal(refresh.handleHotUpdate({ file: path.join(root, "src/App.css"), modules: [], server }), undefined)
})

test("a module Babel cannot parse is served as is, with a warning", async () => {
  const { result, warnings } = await transform(`export const = ;`, path.join(build, "example/broken.ffi.mjs"))
  assert.equal(result, undefined)
  assert.equal(warnings.length, 1)
  assert.match(warnings[0], /src\/broken\.ffi\.mjs could not be transformed/)
})

test("module ids are the paths of the Gleam sources", async () => {
  const [, refresh] = plugin()
  const code = `export function f() {}`
  const id = async (file) => {
    const { code: out } = await refresh.transform.call({ warn() {} }, code, file)
    return out.match(/\$redraw_hot\.types\("([^"]+)"/)[1]
  }
  assert.equal(await id(path.join(build, "example/button.mjs")), "src/button.gleam")
  assert.equal(await id(path.join(build, "example/dom/foo.ffi.mjs")), "src/dom/foo.ffi.mjs")
  assert.equal(await id(path.join(build, "redraw_dom/redraw/dom/html.mjs")), "redraw_dom/src/redraw/dom/html.gleam")
})
