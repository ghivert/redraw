import React, { useEffect } from "react";
import ReactDOM from "react-dom/client";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);

export function useHelloEffect(content) {
  useEffect(() => {
    console.log("hello", content);
  }, [content]);
}

export function App() {
  useHelloEffect("app");
  return <Test />;
}

export function Test() {
  useHelloEffect("test");
  return <Test21 />;
  // return (
  //   <div>
  //     <a>Muf</a>
  //     <a>Muf</a>
  //     <a>Muf</a>
  //     <a>Muf</a>
  //   </div>
  // );
}

export function Test21() {
  useHelloEffect("Test21");
  return (
    <div>
      {new Array(5).fill(0).map((_, index) => (
        <a key={index}>Mumuf</a>
      ))}
    </div>
  );
}
