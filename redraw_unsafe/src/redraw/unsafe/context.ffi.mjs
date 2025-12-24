import * as React from "react"
import * as $gleam from "../../gleam.mjs"
import * as $context from "./context.mjs"

const contexts = {}

export function createContext(name, defaultValue) {
  if (contexts[name])
    return $gleam.Result$Error($context.Error$ExistingContext(name))
  contexts[name] = React.createContext(defaultValue)
  return $gleam.Result$Ok(contexts[name])
}

export function getContext(name) {
  const context = contexts[name]
  if (context) return $gleam.Result$Ok(context)
  const error = $context.Error$UnknownContext(name)
  return $gleam.Result$Error(error)
}
