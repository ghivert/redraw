import * as React from "react"
import { jsx } from "./redraw.ffi.mjs"
import { Error, Ok } from "./gleam.mjs"
import { UnknownContext, ExistingContext } from "./redraw/error.mjs"

const contexts = {}

export function contextProvider(context, value, children) {
  const props = { value }
  const shouldConvertChildren = true
  return jsx(context.Provider, props, children, shouldConvertChildren)
}

export function createContext(name, defaultValue) {
  if (contexts[name]) return new Error(new ExistingContext(name))
  contexts[name] = React.createContext(defaultValue)
  return new Ok(contexts[name])
}

export function getContext(name) {
  const context = contexts[name]
  if (context) return new Ok(context)
  const error = new UnknownContext(name)
  return new Error(error)
}
