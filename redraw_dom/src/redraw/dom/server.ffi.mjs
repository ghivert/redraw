import ReactDOM from "react-dom/server"

export function renderToString(component) {
  return ReactDOM.renderToString(component)
}

export function renderToStaticMarkup(component) {
  return ReactDOM.renderToStaticMarkup(component)
}
