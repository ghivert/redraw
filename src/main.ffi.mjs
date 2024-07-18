import React, { useEffect } from "react";
import * as gleam from "./gleam.mjs";
import ReactDOM from "react-dom/client";
import runtime from "react/jsx-runtime";

export function createRoot(value) {
  const node = document.getElementById(value);
  return ReactDOM.createRoot(node);
}

export function render(root, children) {
  return root.render(children);
}

// Extract children from props to give it to function.
export function addProxy(val) {
  return new Proxy(val, {
    apply(target, thisArg, argumentsList) {
      const props = argumentsList[0];
      return target(props, gleam.List.fromArray(props.children));
    },
  });
}

// Generate JSX
export function jsx(value, props_, children_) {
  if (value === "text_") return children_;
  let children = children_?.toArray() ?? [];
  let isStatic = true;

  // Keyed elements
  if (Array.isArray(children[0])) {
    children = children.map((c) => {
      const [key, node] = c;
      if ("key" in node) return React.cloneElement(node, { key });
      return node;
    });
    isStatic = false;
  }

  // Generate correct props
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

export function useHelloEffect(deps, content) {
  useEffect(() => {
    console.log("hello", content);
  }, deps.toArray());
}

export function strictMode(children) {
  return jsx(React.StrictMode, {}, children);
}

export function fragment(children) {
  return jsx(React.Fragment, {}, children);
}
