import React, { useEffect } from "react";
import runtime from "react/jsx-runtime";
import ReactDOM from "react-dom/client";

export function createRoot(value) {
  const node = document.getElementById(value);
  return ReactDOM.createRoot(node);
}

export function render(root, children) {
  return root.render(children);
}

export function jsx(value, props_, children_) {
  if (value === "text_") return children_;
  let children = children_?.toArray() ?? [];
  let isStatic = true;
  if (Array.isArray(children[0])) {
    children = children.map((c) => {
      const [key, node] = c;
      if ("key" in node) return React.cloneElement(node, { key });
      return node;
    });
    isStatic = false;
  }
  const props = {};
  Object.assign(props, props_);
  if (children.length > 0) props.children = children;
  if (isStatic) return runtime.jsxs(value, props);
  else return runtime.jsx(value, props);
}

export function setFunctionName(val, name) {
  val.displayName = name;
  return val;
}

export function useTimeout(setter) {
  useEffect(() => {
    setInterval(() => setter(), 1000);
  }, []);
}

export function useHelloEffect(deps) {
  useEffect(() => {
    console.log("hello");
    console.log("");
  }, deps.toArray());
}

export function strictMode(children) {
  return jsx(React.StrictMode, { children: children.toArray() });
}
