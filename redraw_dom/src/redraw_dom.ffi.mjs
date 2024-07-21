import ReactDOM from "react-dom/client"

export function createRoot(value) {
  const node = document.getElementById(value)
  return ReactDOM.createRoot(node)
}

export function hydrateRoot(value, content) {
  const node = document.getElementById(value)
  return ReactDOM.hydrateRoot(node, content)
}

export function createPortal(children, root) {
  const node = document.getElementById(root)
  return ReactDOM.createPortal(children, node)
}

export function render(root, children) {
  return root.render(children)
}
