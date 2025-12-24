import * as React from "react"
import { jsx } from "./redraw.ffi.mjs"

export function contextProvider(context, value, children) {
  const props = { value }
  const shouldConvertChildren = true
  return jsx(context, props, children, shouldConvertChildren)
}

// That part of the file is deprecated, named contexts have been removed
// from Redraw. Will be removed in Redraw 20.
import * as $gleam from "./gleam.mjs"
import * as $redraw from "./redraw.mjs"

const contexts = {}

export function createContext(name, defaultValue) {
  if (contexts[name])
    return $gleam.Result$Error($redraw.Error$ExistingContext(name))
  contexts[name] = React.createContext(defaultValue)
  return $gleam.Result$Ok(contexts[name])
}

export function getContext(name) {
  const context = contexts[name]
  if (context) return $gleam.Result$Ok(context)
  const error = $redraw.Error$UnknownContext(name)
  return $gleam.Result$Error(error)
}
