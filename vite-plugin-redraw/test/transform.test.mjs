import { test } from "node:test"
import assert from "node:assert/strict"
import { transformAsync } from "@babel/core"
import { redrawRefresh, stableSource } from "../src/transform.mjs"

async function transform(code, moduleId = "pkg/mod.mjs") {
  const result = await transformAsync(code, {
    configFile: false,
    babelrc: false,
    parserOpts: { sourceType: "module" },
    plugins: [[redrawRefresh, { moduleId, hotImport: "virtual:redraw/hot" }]],
  })
  return result.code
}

const REDRAW = `import * as $react from "../redraw/redraw.mjs";\n`

test("a data-only module registers its classes and does not self-accept", async () => {
  const code = await transform(`
import { CustomType as $CustomType } from "./gleam.mjs";
export class All extends $CustomType {}
export class Done extends $CustomType {}
export class Props extends $CustomType {
  constructor(label) { super(); this.label = label; }
}
export function name(filter) { return filter instanceof All ? "all" : "done"; }
`)
  assert.match(code, /^import \* as \$redraw_hot from "virtual:redraw\/hot";/m)
  assert.match(code, /\$redraw_hot\.type\("pkg\/mod\.mjs All", All\);/)
  assert.match(code, /\$redraw_hot\.type\("pkg\/mod\.mjs Props", Props\);/)
  assert.match(code, /\$redraw_hot\.types\("pkg\/mod\.mjs", \["All", "Done", "Props"\]\);/)
  assert.doesNotMatch(code, /import\.meta\.hot/)
  assert.doesNotMatch(code, /\$redraw_hot\.(tag|rerun|invoked)/)
})

test("a component module tags renders, hooks and main, and self-accepts", async () => {
  const code = await transform(REDRAW + `
function use_counter() {
  let $ = $react.use_state_(0);
  return [$[0], $[1]];
}
function counter() {
  return $react.component_("Counter", (props) => {
    let $ = use_counter();
    let other = $react.use_state_(toList([]));
    return $html.text("x");
  });
}
export function root() {
  return $react.compose(counter(), (counter) => {
    return $react.component_("Root", (_) => counter(undefined));
  });
}
export function main() {
  return $client.render_(node, root(), (root) => root(undefined));
}
`)
  assert.match(
    code,
    /\$react\.component_\("Counter", \$redraw_hot\.tag\("pkg\/mod\.mjs", "use_counter\\n\$react\.use_state_\(toList\(\[\]\)\)", \(\) => \[use_counter\], props => \{/,
  )
  assert.match(code, /\$redraw_hot\.hook\(use_counter, "\$react\.use_state_\(0\)", \(\) => \[\]\);/)
  assert.match(code, /\$redraw_hot\.bootstrap\("pkg\/mod\.mjs", "[a-z0-9]+"\);/)
  assert.match(code, /import\.meta\.hot\.accept\(\);/)
  assert.match(code, /\$redraw_hot\.rerun\("pkg\/mod\.mjs", \[counter, root\], \{\}\);/)
})

test("the signature changes with the initial value of a state", async () => {
  const before = await transform(REDRAW + `
function c() { return $react.component_("C", (p) => { let $ = $react.use_state_(0); return $html.text(""); }); }`)
  const after = await transform(REDRAW + `
function c() { return $react.component_("C", (p) => { let $ = $react.use_state_(""); return $html.text(""); }); }`)
  assert.match(before, /"\$react\.use_state_\(0\)"/)
  assert.match(after, /"\$react\.use_state_\(\\"\\"\)"/)
})

test("a parameterized factory captures and records its arguments", async () => {
  const code = await transform(REDRAW + `
export function button(variant, size) {
  return $react.component_("Button", (props) => $html.text(""));
}
export function memo(component) {
  return $react.memoize_(component);
}
`)
  assert.match(code, /function button\(variant, size\) \{\n  const \$redraw_args = \[variant, size\];\n  \$redraw_hot\.invoked\("pkg\/mod\.mjs button", \$redraw_args\);/)
  assert.match(code, /\$redraw_hot\.tag\("pkg\/mod\.mjs", "", \(\) => \[\], props => \$html\.text\(""\), \$redraw_args\)/)
  assert.doesNotMatch(code, /invoked\("pkg\/mod\.mjs memo"/)
  assert.match(code, /\$redraw_hot\.rerun\("pkg\/mod\.mjs", \[\], \{\n\s*"pkg\/mod\.mjs button": button\n\s*\}\);/)
})

test("contexts are keyed by call site and named imports are supported", async () => {
  const code = await transform(`
import { component_, create_context_ } from "../redraw/redraw.mjs";
export function theme() { return create_context_("light"); }
function app() { return component_("App", (_) => $html.text("")); }
`)
  assert.match(code, /\$redraw_hot\.context\("pkg\/mod\.mjs#0", "light"\)/)
  assert.match(code, /component_\("App", \$redraw_hot\.tag\(/)
  assert.match(code, /\$redraw_hot\.rerun\("pkg\/mod\.mjs", \[app\], \{\}\);/)
})

test("hashes ignore the source positions Gleam embeds", async () => {
  const before = `throw makeError("let_assert", FILEPATH, "m", 10, "main", "msg", { value: $, start: 183, end: 231, pattern_start: 194, pattern_end: 202 });
echo(y, undefined, "src/m.gleam", 4);
throw makeError("assert", FILEPATH, "m", 3, "f", "Assertion failed.", { kind: "binary_operator", left: { start: 66, end: 67 }, start: 59, end: 71, expression_start: 66 })`
  const after = before.replace(/\b(\d+)\b/g, (n) => String(Number(n) + 7))
  assert.notEqual(before, after)
  assert.equal(stableSource(before), stableSource(after))
  const main = (line) => REDRAW + `
function app() { return $react.component_("App", (p) => $html.text("")); }
export function main() {
  let $ = f();
  if (!($ instanceof Ok)) throw makeError("let_assert", FILEPATH, "m", ${line}, "main", "msg", { value: $, start: ${line * 20}, end: ${line * 21}, pattern_start: 1, pattern_end: 2 });
  return app();
}`
  const hashOf = (code) => code.match(/bootstrap\("pkg\/mod\.mjs", "([a-z0-9]+)"\)/)[1]
  assert.equal(hashOf(await transform(main(10))), hashOf(await transform(main(12))))
})

test("a component_ call whose render is not a function literal is left alone", async () => {
  const code = await transform(REDRAW + `
export function wrapper(name, render) { return $react.component_(name, render); }
`)
  assert.doesNotMatch(code, /\$redraw_hot\.tag\(/)
  assert.doesNotMatch(code, /\$redraw_hot\.invoked\(/)
  assert.doesNotMatch(code, /import\.meta\.hot/)
})

test("non-factory exports are hashed, factories, main, classes and accessors are not", async () => {
  const code = await transform(REDRAW + `
import { CustomType as $CustomType } from "./gleam.mjs";
export class Props extends $CustomType {}
export const Props$Props = () => new Props();
export const limit = 3;
export function label(x) { return "" + x; }
export function use_thing() { return $react.use_state_(0); }
export function memo(c) { return $react.memoize_(c); }
export function button(v) { return $react.component_("Button", (p) => $html.text("")); }
export function root() { return $react.component_("Root", (p) => $html.text("")); }
export function main() { return root(); }
`)
  const match = code.match(/const \$redraw_stale = \$redraw_hot\.exports\("pkg\/mod\.mjs", "[a-z0-9]+", \{([^}]*)\}\)/)
  assert.ok(match, code)
  const names = [...match[1].matchAll(/"([^"]+)": "[a-z0-9]+"/g)].map((m) => m[1])
  assert.deepEqual(names, ["limit", "label", "use_thing", "memo"])
  assert.match(code, /if \(\$redraw_stale\) import\.meta\.hot\.invalidate\(/)
})

test("the module hash ignores positions, and generated classes are not listed", async () => {
  const module = (line) => REDRAW + `
import { CustomType as $CustomType } from "./gleam.mjs";
export class Props extends $CustomType {}
class Echo$Inspector {}
function app() { return $react.component_("App", (p) => { echo(1, undefined, "src/m.gleam", ${line}); return $html.text(""); }); }
`
  const moduleHash = (code) => code.match(/\$redraw_hot\.exports\("pkg\/mod\.mjs", "([a-z0-9]+)"/)[1]
  const a = await transform(module(3))
  const b = await transform(module(9))
  assert.equal(moduleHash(a), moduleHash(b))
  assert.match(a, /\$redraw_hot\.types\("pkg\/mod\.mjs", \["Props"\]\)/)
  assert.doesNotMatch(a, /type\("pkg\/mod\.mjs Echo\$Inspector"/)
})
