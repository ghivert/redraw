// That file is deprecated, and will be removed in React 20.

import * as $gleam from "../gleam_stdlib/gleam/option.mjs"

export function convertProps(props) {
  const entries = Object.entries(props)
  const converted = entries.map(([k, v]) => [camelize(k), convertOption(v)])
  return Object.fromEntries(converted)
}

function convertOption(value) {
  if ($gleam.Option$isNone(value)) return null
  if ($gleam.Option$isSome(value)) return value[0]
  return value
}

function camelize(key) {
  return key.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase())
}
