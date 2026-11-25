// Drives the language server as an editor would, over stdin and stdout, on
// the `example/` project of the repository. Buffers are changed in memory
// only: nothing is written to disk. Run `gleam build` first.

import { test } from "node:test"
import assert from "node:assert/strict"
import { spawn } from "node:child_process"
import { readFileSync } from "node:fs"
import { dirname, join, resolve } from "node:path"
import { fileURLToPath, pathToFileURL } from "node:url"

const here = dirname(fileURLToPath(import.meta.url))
const server = join(here, "../build/dev/javascript/redraw_lint/redraw_lint/lsp.mjs")
const example = resolve(here, "../../example")
const buttonPath = join(example, "src/button.gleam")
const buttonUri = pathToFileURL(buttonPath).href
const button = readFileSync(buttonPath, "utf-8")

class Client {
  constructor() {
    this.process = spawn(
      process.execPath,
      ["--input-type=module", "-e", `import { main } from ${JSON.stringify(pathToFileURL(server).href)}; main()`],
      { stdio: ["pipe", "pipe", "inherit"] },
    )
    this.messages = []
    this.waiters = []
    this.buffer = Buffer.alloc(0)
    this.nextId = 1
    this.process.stdout.on("data", (chunk) => {
      this.buffer = Buffer.concat([this.buffer, chunk])
      while (true) {
        const separator = this.buffer.indexOf("\r\n\r\n")
        if (separator === -1) return
        const length = Number(/Content-Length: (\d+)/.exec(this.buffer.subarray(0, separator).toString())[1])
        if (this.buffer.length < separator + 4 + length) return
        const body = this.buffer.subarray(separator + 4, separator + 4 + length).toString()
        this.buffer = this.buffer.subarray(separator + 4 + length)
        this.messages.push(JSON.parse(body))
        for (const waiter of [...this.waiters]) waiter()
      }
    })
    this.exited = new Promise((resolve) => this.process.on("exit", resolve))
  }

  send(message) {
    const body = JSON.stringify({ jsonrpc: "2.0", ...message })
    this.process.stdin.write(`Content-Length: ${Buffer.byteLength(body)}\r\n\r\n${body}`)
  }

  request(method, params) {
    const id = this.nextId++
    this.send({ id, method, params })
    return this.waitFor((m) => m.id === id)
  }

  notify(method, params) {
    this.send({ method, params })
  }

  /** The first message received from now on matching `predicate`, or null
   * after `timeout` milliseconds. */
  waitFor(predicate, timeout = 3000) {
    const start = this.messages.length
    return new Promise((resolve) => {
      const check = () => {
        const found = this.messages.slice(start).find(predicate)
        if (found) {
          this.waiters = this.waiters.filter((w) => w !== check)
          clearTimeout(timer)
          resolve(found)
        }
      }
      const timer = setTimeout(() => {
        this.waiters = this.waiters.filter((w) => w !== check)
        resolve(null)
      }, timeout)
      this.waiters.push(check)
    })
  }

  diagnosticsFor(uri, timeout) {
    return this.waitFor(
      (m) => m.method === "textDocument/publishDiagnostics" && m.params.uri === uri,
      timeout,
    )
  }
}

const withCallback = button.replace(
  "pub fn button(variant: Variant) {",
  "pub fn button(variant: Variant, on_click: fn() -> Nil) {",
)

test("publishes, keeps and clears the warnings of a buffer", async () => {
  const client = new Client()
  const initialized = await client.request("initialize", {
    processId: null,
    rootUri: pathToFileURL(example).href,
    capabilities: {},
  })
  assert.equal(initialized.result.capabilities.textDocumentSync.change, 1)
  assert.equal(initialized.result.serverInfo.name, "redraw_lint")
  client.notify("initialized", {})

  // The example has no warning: nothing is published for it.
  assert.equal(await client.diagnosticsFor(buttonUri, 500), null)

  // A callback added to the factory parameters, in an unsaved buffer.
  client.notify("textDocument/didOpen", {
    textDocument: { uri: buttonUri, languageId: "gleam", version: 1, text: withCallback },
  })
  const published = await client.diagnosticsFor(buttonUri)
  assert.ok(published, "diagnostics are published")
  const [diagnostic, ...others] = published.params.diagnostics
  assert.equal(others.length, 0)
  assert.equal(diagnostic.code, "factory-function-argument")
  assert.equal(diagnostic.severity, 2)
  assert.equal(diagnostic.source, "redraw_lint")
  const line = withCallback.split("\n").findIndex((l) => l.startsWith("pub fn button("))
  const character = withCallback.split("\n")[line].indexOf("fn() -> Nil")
  assert.deepEqual(diagnostic.range, {
    start: { line, character },
    end: { line, character: character + "fn() -> Nil".length },
  })

  // While the buffer does not parse, its warnings are kept.
  client.notify("textDocument/didChange", {
    textDocument: { uri: buttonUri, version: 2 },
    contentChanges: [{ text: withCallback.replace("pub fn button(", "pub fn button((") }],
  })
  assert.equal(await client.diagnosticsFor(buttonUri, 600), null)

  // Fixed: the warnings are cleared.
  client.notify("textDocument/didChange", {
    textDocument: { uri: buttonUri, version: 3 },
    contentChanges: [{ text: button }],
  })
  const cleared = await client.diagnosticsFor(buttonUri)
  assert.ok(cleared, "diagnostics are cleared")
  assert.deepEqual(cleared.params.diagnostics, [])

  // A Gleam project without the linter, here a dependency, is left alone.
  const redraw = pathToFileURL(resolve(example, "../redraw/src/redraw.gleam")).href
  client.notify("textDocument/didOpen", {
    textDocument: { uri: redraw, languageId: "gleam", version: 1, text: "pub fn broken(" },
  })
  assert.equal(await client.diagnosticsFor(redraw, 500), null)

  // Unknown requests get an error, the server keeps running.
  const unknown = await client.request("textDocument/hover", {})
  assert.equal(unknown.error.code, -32601)

  const shutdown = await client.request("shutdown", null)
  assert.equal(shutdown.result, null)
  client.notify("exit", null)
  assert.equal(await client.exited, 0)
})

test("a change in another module reaches the module using its type", async () => {
  const client = new Client()
  await client.request("initialize", { processId: null, rootUri: null, capabilities: {} })
  // `filter` defines a type used by `example`: turning it into an external
  // type is not a warning in `filter`, but in the factory using it.
  const filterPath = join(example, "src/filter.gleam")
  const filterUri = pathToFileURL(filterPath).href
  const examplePath = join(example, "src/example.gleam")
  const exampleUri = pathToFileURL(examplePath).href
  const exampleSource = readFileSync(examplePath, "utf-8").replace(
    "fn counter() {",
    "fn counter(filter: filter.Filter) {\n  let _ = filter",
  )
  client.notify("textDocument/didOpen", {
    textDocument: { uri: exampleUri, languageId: "gleam", version: 1, text: exampleSource },
  })
  assert.equal(await client.diagnosticsFor(exampleUri, 600), null)
  const filterSource = readFileSync(filterPath, "utf-8").replace(
    /pub type Filter \{[^}]*\}/,
    "pub type Filter",
  )
  client.notify("textDocument/didOpen", {
    textDocument: { uri: filterUri, languageId: "gleam", version: 1, text: filterSource },
  })
  const published = await client.diagnosticsFor(exampleUri)
  assert.ok(published, "the importing module gets the warning")
  assert.deepEqual(
    published.params.diagnostics.map((d) => d.code),
    ["factory-external-argument"],
  )
  client.notify("exit", null)
  await client.exited
})
