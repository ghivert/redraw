import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
    <Test />
    <Test21 />
  </React.StrictMode>,
);

export function Test() {
  return (
    <div>
      <a>Muf</a>
      <a>Muf</a>
      <a>Muf</a>
      <a>Muf</a>
    </div>
  );
}

export function Test21() {
  return (
    <div>
      {new Array(5).fill(0).map(() => (
        <a>Mumuf</a>
      ))}
    </div>
  );
}
