import * as React from "react"
import { jsx } from "./redraw.ffi.mjs"
import * as gleam from "./gleam.mjs"
import * as error from "./redraw/error.mjs"

const contexts = {}

export function contextProvider(context, value, children) {
  return jsx(context.Provider, { value }, children)
}

export function createContext(name, defaultValue) {
  if (contexts[name]) return new gleam.Error(new error.ExistingContext(name))
  contexts[name] = React.createContext(defaultValue)
  return new gleam.Ok(contexts[name])
}

export function getContext(name) {
  if (!contexts[name]) return new gleam.Error(new error.UnknownContext(name))
  return new gleam.Ok(contexts[name])
}
