export function toProps(attributes) {
  const props = {}
  for (const item of attributes) {
    props[item.key] = item.content
  }
  return props
}
