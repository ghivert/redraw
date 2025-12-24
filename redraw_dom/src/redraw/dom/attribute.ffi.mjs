import ReactDOM from "react-dom/client"
import * as $gleam from "../../gleam.mjs"

export function createPortal(children, root) {
  const node = document.getElementById(root)
  if (!node) return $gleam.Result$Error()
  const portal = ReactDOM.createPortal(children, node)
  return $gleam.Result$Ok(portal)
}

/** Turns a `List(#(String, String))` into an object `{ [key: string]: string }`
 * to conform with the React `style` API. */
export function convertStyle(styles) {
  const styles_ = {}
  for (const style of styles) {
    styles_[camelize(style[0])] = style[1]
  }
  return styles_
}

/** Used to camelize CSS property names. */
function camelize(key) {
  return key.replace(/-([a-z])/g, (_, letter) => letter.toUpperCase())
}

export function innerHTML(html) {
  return { __html: html }
}
