import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import gleam from "vite-gleam"

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), gleam()],
  build: {
    minify: false,
  },
})
