export function toProps(attributes) {
  const props = {}
  const classNames = []
  for (const item of attributes)
    if (item.key === "className") classNames.push(item.content)
    else if (item.key !== "none_") props[item.key] = item.content
  if (classNames.length > 0) props.className = classNames.join(" ")
  return props
}
