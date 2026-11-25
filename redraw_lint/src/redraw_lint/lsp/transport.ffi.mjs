// JSON-RPC over stdin and stdout, with the `Content-Length` framing of the
// Language Server Protocol. Incoming messages are queued until the server
// asks for the next one.

import { fileURLToPath, pathToFileURL } from "node:url"
import { Ok, Error } from "../../gleam.mjs"
import { Message, Timeout, Closed } from "./transport.mjs"

const queue = []
let waiter = null
let closed = false
let buffer = Buffer.alloc(0)
let started = false

export function start() {
  if (started) return
  started = true
  process.stdin.on("data", (chunk) => {
    buffer = Buffer.concat([buffer, chunk])
    let message
    while ((message = nextFrame()) !== null) deliver(new Message(message))
  })
  process.stdin.on("end", () => {
    closed = true
    deliver(new Closed())
  })
}

function nextFrame() {
  const separator = buffer.indexOf("\r\n\r\n")
  if (separator === -1) return null
  const header = buffer.subarray(0, separator).toString("ascii")
  const match = /content-length:\s*(\d+)/i.exec(header)
  if (!match) {
    // Not a valid header: drop it, and resynchronize on the next one.
    buffer = buffer.subarray(separator + 4)
    return nextFrame()
  }
  const length = Number(match[1])
  const start = separator + 4
  if (buffer.length < start + length) return null
  const body = buffer.subarray(start, start + length).toString("utf-8")
  buffer = buffer.subarray(start + length)
  return body
}

function deliver(incoming) {
  if (waiter) {
    const resolve = waiter
    waiter = null
    resolve(incoming)
  } else {
    queue.push(incoming)
  }
}

/** The next message, or `Timeout` after `timeout` milliseconds when it is
 * not negative, or `Closed` once stdin ends. */
export function read(timeout) {
  if (queue.length > 0) return Promise.resolve(queue.shift())
  if (closed) return Promise.resolve(new Closed())
  return new Promise((resolve) => {
    let timer = null
    waiter = (incoming) => {
      if (timer) clearTimeout(timer)
      resolve(incoming)
    }
    if (timeout >= 0) {
      timer = setTimeout(() => {
        waiter = null
        resolve(new Timeout())
      }, timeout)
    }
  })
}

export function send(message) {
  const length = Buffer.byteLength(message, "utf-8")
  process.stdout.write(`Content-Length: ${length}\r\n\r\n${message}`)
}

export function uriToPath(uri) {
  try {
    return new Ok(fileURLToPath(uri))
  } catch {
    return new Error(undefined)
  }
}

export function pathToUri(path) {
  return pathToFileURL(path).href
}
