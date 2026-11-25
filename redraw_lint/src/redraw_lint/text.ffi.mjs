// Offsets produced by glance on the JavaScript target are UTF-16 code unit
// indices, which is how JavaScript indexes strings.

export function prefix(source, offset) {
  return source.slice(0, offset)
}

/** Zero-based line and UTF-16 character of an offset, as LSP expects. */
export function utf16Position(source, offset) {
  const before = source.slice(0, offset)
  const line = before.split("\n").length - 1
  const character = before.length - (before.lastIndexOf("\n") + 1)
  return [line, character]
}

/** Offset of the end of the line containing `offset`. */
export function lineEnd(source, offset) {
  const end = source.indexOf("\n", offset)
  return end === -1 ? source.length : end
}

export function length(text) {
  return text.length
}
