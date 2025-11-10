import * as React from "react"
import { Error, Ok } from "../../gleam.mjs"
import { UnknownContext, ExistingContext } from "./context.mjs"

const contexts = {}

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
