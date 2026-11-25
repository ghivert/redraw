import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import { gleamImportPlugin as gleam } from "@chouquette/gleam-vite-loader"
import redraw from "vite-plugin-redraw"

// https://vitejs.dev/config/
export default defineConfig({
  // The order does not matter: `redraw()` runs after the Gleam loader.
  plugins: [gleam(), react(), redraw()],
})
