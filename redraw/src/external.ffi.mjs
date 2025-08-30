import { None, Some } from "../gleam_stdlib/gleam/option.mjs"

function camelize(key) {
  return key.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase())
}

function convertOption(value) {
  if (value instanceof None) return null
  if (value instanceof Some) return value[0]
  return value
}

export function convertProps(props) {
  const entries = Object.entries(props)
  const converted = entries.map(([k, v]) => [camelize(k), convertOption(v)])
  return Object.fromEntries(converted)
}
