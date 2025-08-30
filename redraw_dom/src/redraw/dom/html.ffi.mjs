export function toProps(attributes) {
  const props = {}
  for (const item of attributes)
    if (item.key !== "none_") props[item.key] = item.content
  return props
}
