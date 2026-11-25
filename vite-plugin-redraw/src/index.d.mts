import type { Plugin } from "vite"

export interface RedrawOptions {
  /** Prefixes of compiled packages, relative to `build/dev/javascript`, that
   * should not be transformed. Example: `["some_package/"]`. */
  ignore?: string[]
}

/** Vite plugin enabling React Fast Refresh for Redraw components. */
export default function redraw(options?: RedrawOptions): Plugin[]
