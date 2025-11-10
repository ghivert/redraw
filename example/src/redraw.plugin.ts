import fs from "node:fs"
import path from "node:path"
import parser from "@babel/parser"
import babel from "@babel/core"
import generate from "@babel/generator"
import { type PluginItem, type PluginObj } from "@babel/core"

export default function redraw(babel: any): PluginObj {
  return {
    // visitor: {
    //   FunctionDeclaration(path) {
    //     console.log(path.node.id?.name)
    //   },
    //   Identifier(path, state) {},
    // },
  }
}

function main() {
  const p = path.resolve("../build/dev/javascript/example/example.mjs")
  const code = fs.readFileSync(p, "utf-8")
  const result = babel.transform(code, { plugins: [redraw] })
}
main()
