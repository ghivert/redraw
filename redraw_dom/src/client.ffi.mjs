import ReactDOM from "react-dom/client"
import * as gleam from "./gleam.mjs"

export function createRoot(value) {
  const node = document.getElementById(value)
  if (!node) return new gleam.Error()
  return new gleam.Ok(ReactDOM.createRoot(node))
}

export function hydrateRoot(value, content) {
  const node = document.getElementById(value)
  if (!node) return new gleam.Error()
  return new gleam.Ok(ReactDOM.hydrateRoot(node, content))
}

export function createPortal(children, root) {
  const node = document.getElementById(root)
  if (!node) return new gleam.Error()
  return new gleam.Ok(ReactDOM.createPortal(children, node))
}

export function render(root, children) {
  return root.render(children)
}
