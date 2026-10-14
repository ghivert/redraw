import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import gleam from "vite-gleam"
import redraw from "vite-plugin-redraw"

// https://vitejs.dev/config/
export default defineConfig({
  // `gleam()` must come before `redraw()`: the refresh transform runs on the
  // compiled output produced by `vite-gleam`.
  plugins: [gleam(), react(), redraw()],
})
