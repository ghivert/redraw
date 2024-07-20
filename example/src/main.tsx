import { useState, useEffect } from "react"
import { createRoot } from "react-dom/client"

const Counter = ({ count, setCount }) => {
  return (
    <button onClick={() => setCount((state) => state + 1)}>
      count is {count}
    </button>
  )
}

const App = () => {
  const [count, setCount] = useState(0)
  return (
    <div>
      <Counter count={0} setCount={setCount} />
      <Counter count={count} setCount={setCount} />
    </div>
  )
}

const node = document.getElementById("root")
if (node) {
  createRoot(node).render(<App />)
}
