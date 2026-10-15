import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import { gleamImportPlugin as gleam } from "@chouquette/gleam-vite-loader"
import redraw from "vite-plugin-redraw"

// https://vitejs.dev/config/
export default defineConfig({
  // `gleam()` must come before `redraw()`: the refresh transform runs on the
  // compiled output produced by `@chouquette/gleam-vite-loader`.
  plugins: [gleam(), react(), redraw()],
})
