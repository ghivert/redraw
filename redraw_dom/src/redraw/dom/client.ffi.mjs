import ReactDOM from "react-dom/client"
import { Error, Ok } from "../../gleam.mjs"

export function createRoot(value) {
  const node = document.getElementById(value)
  if (!node) return new Error()
  const root = ReactDOM.createRoot(node)
  return new Ok(root)
}

export function virtualRoot() {
  const value = document.createElement("div")
  const root = ReactDOM.createRoot(value)
  return [value, root]
}

export function hydrateRoot(value, content) {
  const node = document.getElementById(value)
  if (!node) return new Error()
  const hydration = ReactDOM.hydrateRoot(node, content)
  return new Ok(hydration)
}

export function createPortal(children, root) {
  const node = document.getElementById(root)
  if (!node) return new Error()
  const portal = ReactDOM.createPortal(children, node)
  return new Ok(portal)
}

export function render(root, children) {
  return root.render(children)
}

export function unmount(root) {
  return root.unmount()
}
