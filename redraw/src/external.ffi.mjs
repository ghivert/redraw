import * as option from "../gleam_stdlib/gleam/option.mjs"

function camelize(key) {
  return key.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase())
}

function convertOption(value) {
  if (value instanceof option.None) return null
  if (value instanceof option.Some) return value[0]
  return value
}

export function convertProps(props) {
  return Object.fromEntries(
    Object.entries(props).map(([key, value]) => [
      camelize(key),
      convertOption(value),
    ]),
  )
}
