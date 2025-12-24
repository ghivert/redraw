import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import gleam from "vite-gleam"
import redraw from "./src/redraw.plugin"

const reactPlugin = react({
  babel: {
    // plugins: [redraw],
  },
})

const g: any = gleam()

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [g, reactPlugin],
})
