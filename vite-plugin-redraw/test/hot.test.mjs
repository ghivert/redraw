// Tests of `redraw/internal/hot.ffi.mjs`, run against the copy produced by
// `gleam build` in the example, because the module imports the Gleam prelude
// from the build layout. Build the example first.
import { test } from "node:test"
import assert from "node:assert/strict"
import { existsSync } from "node:fs"
import { fileURLToPath, pathToFileURL } from "node:url"
import path from "node:path"

const build = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)),
  "../../example/build/dev/javascript",
)
const hotFile = path.join(build, "redraw/redraw/internal/hot.ffi.mjs")
const built = existsSync(hotFile)
  ? false
  : "the example is not built: run `gleam build` in example/ first"
const { CustomType, isEqual } = built
  ? {}
  : await import(pathToFileURL(path.join(build, "prelude.mjs")))

let generation = 0

/** Fresh instance of the hot module with a fake refresh runtime. */
async function setup(t) {
  const calls = { ids: [], refreshes: 0, reloads: [] }
  globalThis.__REDRAW_REFRESH__ = {
    register: (_type, id) => calls.ids.push(id),
    createSignatureFunctionForTransform: () => () => {},
    validateRefreshBoundaryAndEnqueueUpdate: () => calls.refreshes++,
  }
  globalThis.location = { reload: () => calls.reloads.push(true) }
  const original = console.warn
  console.warn = (message) => calls.reloads.push(message)
  t.after(() => (console.warn = original))
  const hot = await import(pathToFileURL(hotFile) + "?generation=" + generation++)
  return { hot, calls }
}

function component(hot, name, args) {
  const render = hot.tag("m", "", () => [], (props) => props, args)
  render.displayName = name
  return hot.register(() => {}, render)
}

test("classes are reconciled across generations", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  class V1 extends CustomType { constructor(a) { super(); this.a = a } }
  hot.type("m V", V1)
  const old = new V1(1)
  class V2 extends CustomType { constructor(a) { super(); this.a = a } }
  hot.type("m V", V2)
  class V3 extends CustomType { constructor(a) { super(); this.a = a } }
  hot.type("m V", V3)
  assert.ok(old instanceof V2)
  assert.ok(old instanceof V3)
  assert.ok(new V3(1) instanceof V1)
  assert.ok(isEqual(old, new V3(1)))
  assert.ok(old.withFields({ a: 2 }) instanceof V3)
  assert.equal(calls.reloads.length, 0)
})

test("a change in the fields of a type reloads", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  class V1 extends CustomType { constructor(a) { super(); this.a = a } }
  hot.type("m V", V1)
  class V2 extends CustomType { constructor(a, b) { super(); this.a = a; this.b = b } }
  hot.type("m V", V2)
  assert.equal(calls.reloads.length, 2)
  assert.match(calls.reloads[0], /fields of m V changed/)
})

test("a removed variant reloads", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  hot.types("m", ["All", "Done"])
  hot.types("m", ["All", "Done", "Archived"])
  assert.equal(calls.reloads.length, 0)
  hot.types("m", ["All"])
  assert.match(calls.reloads[0], /Done was removed from m/)
})

test("a change in main reloads", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  hot.bootstrap("m", "abc")
  hot.bootstrap("m", "abc")
  assert.equal(calls.reloads.length, 0)
  hot.bootstrap("m", "abd")
  assert.match(calls.reloads[0], /main changed in m/)
})

test("ids include the factory arguments", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  class Primary extends CustomType {}
  class Secondary extends CustomType {}
  component(hot, "Button", [new Primary(), (x) => x + 1])
  component(hot, "Button", [new Primary(), (x) => x + 1])
  component(hot, "Button", [new Secondary(), (x) => x + 2])
  component(hot, "Button", [function named() {}])
  component(hot, "Plain")
  assert.equal(calls.ids[0], calls.ids[1])
  assert.notEqual(calls.ids[0], calls.ids[2])
  assert.match(calls.ids[0], /^m Button #\(Primary\(\),fn#[a-z0-9]+\)$/)
  assert.equal(calls.ids[3], "m Button #(fn:named)")
  assert.equal(calls.ids[4], "m Plain")
})

test("a re-run replays recorded arguments and refreshes", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  const replayed = []
  const button = (variant) => {
    hot.invoked("m button", [variant])
    replayed.push(variant)
    component(hot, "Button", [variant])
  }
  button("primary")
  button("secondary")
  button("primary")
  replayed.length = 0
  hot.rerun("m", [() => component(hot, "App")], { "m button": button })
  assert.deepEqual(replayed, ["primary", "secondary"])
  assert.equal(calls.refreshes, 1)
  assert.equal(calls.reloads.length, 0)
})

test("a component missing after a re-run reloads", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  hot.rerun("m", [() => component(hot, "App"), () => component(hot, "Old")])
  assert.equal(calls.reloads.length, 0)
  hot.rerun("m", [() => component(hot, "App")])
  assert.match(calls.reloads[0], /"m Old" was removed or renamed/)
})

test("contexts are kept by key and reload on a new default", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  const first = hot.context("m#0", "light")
  assert.equal(hot.context("m#0", "light"), first)
  assert.equal(calls.reloads.length, 0)
  hot.context("m#0", "dark")
  assert.match(calls.reloads[0], /default value of a context changed/)
})

test("the memoized wrapper registered by the parent is not required after a re-run", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  const counter = () => {
    const render = hot.tag("child", "", () => [], (props) => props)
    render.displayName = "Counter"
    const wrapper = hot.register(() => {}, render)
    return wrapper
  }
  // Startup: the parent composes and memoizes the child.
  hot.register({ $$typeof: Symbol.for("react.memo") }, counter(), " memo")
  // The child module alone is updated.
  hot.rerun("child", [counter])
  assert.equal(calls.reloads.length, 0)
  assert.equal(calls.refreshes, 1)
})

test("a factory throwing at re-run keeps the previous code without reloading", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  const original = console.error
  const errors = []
  console.error = (...args) => errors.push(args)
  t.after(() => (console.error = original))
  hot.rerun("m", [() => component(hot, "App"), () => component(hot, "Other")])
  hot.rerun("m", [() => component(hot, "App"), () => { throw new Error("boom") }])
  assert.equal(calls.reloads.length, 0)
  assert.equal(calls.refreshes, 1)
  assert.equal(errors.length, 1)
  // The next successful save still knows every component of the module.
  hot.rerun("m", [() => component(hot, "App")])
  assert.match(calls.reloads[0], /"m Other" was removed or renamed/)
})

test("an unsupported runtime disables Fast Refresh with a warning", { skip: built }, async (t) => {
  const { hot, calls } = await setup(t)
  delete globalThis.__REDRAW_REFRESH__.validateRefreshBoundaryAndEnqueueUpdate
  component(hot, "App")
  assert.equal(calls.ids.length, 0)
  assert.equal(globalThis.__REDRAW_REFRESH__, null)
  assert.match(calls.reloads[0], /does not export validateRefreshBoundaryAndEnqueueUpdate/)
  component(hot, "App")
  assert.equal(calls.reloads.length, 1)
})

test("an edited module propagates only when a non-factory export changed", { skip: built }, async (t) => {
  const { hot } = await setup(t)
  assert.equal(hot.exports("m", "v1", { label: "a", limit: "b" }), false)
  assert.equal(hot.exports("m", "v2", { label: "a", limit: "b" }), false)
  assert.equal(hot.exports("m", "v3", { label: "c", limit: "b" }), true)
  assert.equal(hot.exports("m", "v4", { label: "c" }), true)
  assert.equal(hot.exports("m", "v5", { label: "c" }), false)
})

test("a module re-executed by propagation propagates when it has non-factory exports", { skip: built }, async (t) => {
  const { hot } = await setup(t)
  assert.equal(hot.exports("helpers", "v1", { label: "a" }), false)
  assert.equal(hot.exports("helpers", "v1", { label: "a" }), true)
  assert.equal(hot.exports("components", "v1", {}), false)
  assert.equal(hot.exports("components", "v1", {}), false)
})
