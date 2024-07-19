import React from "react";
import ReactDOM from "react-dom/client";
import runtime from "react/jsx-runtime";
import * as gleam from "./gleam.mjs";

export function createRoot(value) {
  const node = document.getElementById(value);
  return ReactDOM.createRoot(node);
}

export function render(root, children) {
  return root.render(children);
}

export function withChildren(Component) {
  return new Proxy(Component, {
    apply(target, _, argumentsList) {
      const props = argumentsList[0];
      const children = gleam.List.fromArray(props.children);
      return target(props, children);
    },
  });
}

// Extract children from props to give it to function.
// This exist because `component` has shape `fn(props, children) -> Component`.
export function addChildrenProxy(Component) {
  return new Proxy(Component, {
    apply(target, _this, argumentsList) {
      const props = argumentsList[0];
      const children = argumentsList[1];
      return jsx(withChildren(target), props, children);
    },
  });
}

export function addEmptyProxy(Component) {
  return new Proxy(Component, {
    apply(target) {
      const props = {};
      return jsx(target, props);
    },
  });
}

export function addProxy(Component) {
  return new Proxy(Component, {
    apply(target, _, argumentsList) {
      const props = argumentsList[0];
      return jsx(target, props);
    },
  });
}

// Generate JSX using the JSX factory.
// jsx is for dynamic components, while jsxs is for static components.
export function jsx(value, props_, children_) {
  if (value === "text_") return children_;
  let children = children_?.toArray?.();
  let isStatic = true;

  // Handle keyed elements like lustre does.
  // This allow to have a similar interface between lustre and greact.
  if (Array.isArray(children?.[0])) {
    children = children.map((c) => {
      const [key, node] = c;
      if ("key" in node) return React.cloneElement(node, { key });
      return node;
    });
    isStatic = false;
  }

  // Props creation.
  // Uses the existing props, and add children if needed.
  const props = {};
  Object.assign(props, props_);
  if (children?.length > 0) props.children = children;

  if (isStatic) {
    return runtime.jsxs(value, props);
  } else {
    return runtime.jsx(value, props);
  }
}

// Set the display name function. Essential to display the correct name in
// the devtools.
export function setFunctionName(component, name) {
  component.displayName = name;
  return component;
}

export function strictMode(children) {
  return jsx(React.StrictMode, {}, children);
}

export function fragment(children) {
  return jsx(React.Fragment, {}, children);
}

export function profiler(children) {
  return jsx(React.Profiler, {}, children);
}

export function suspense(props, children) {
  return jsx(React.Suspense, props, children);
}

export function coerce(value) {
  return value;
}

export function contextProvider(context, value, children) {
  return jsx(context.Provider, { value }, children);
}

export function setCurrent(ref, value) {
  ref.current = value;
}

export function getCurrent(ref) {
  return ref.current;
}

export function toProps(attributes) {
  const props = {};
  for (const item of attributes) {
    props[item.key] = item.content;
  }
  return props;
}
