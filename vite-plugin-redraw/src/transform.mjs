import { template, types as t } from "@babel/core"

/** Matches the compiled `redraw` module, as imported from Gleam output:
 * `../redraw/redraw.mjs`, `../../redraw/redraw.mjs`, etc. */
const REDRAW_SOURCE = /(^|\/)redraw\/redraw\.mjs$/
const HOOK_NAME = /^use_/
/** Hooks whose initial value is part of the signature, like `useState` and
 * `useReducer` in React Refresh: changing the initial value of a state
 * remounts the component instead of keeping a value of the previous type. */
const STATE_HOOKS = new Set([
  "use_state",
  "use_state_",
  "use_reducer",
  "use_reducer_",
  "use_ref",
  "use_ref_",
])
const HOT_NAMESPACE = "$redraw_hot"
const ARGS_NAME = "$redraw_args"
const STALE_NAME = "$redraw_stale"

/** Babel plugin applied to the compiled modules of the local Gleam packages
 * in development.
 *
 * For every module:
 * - Registers every custom type class with `$redraw_hot.type`, so that
 *   values created before a hot update still match the new classes, and
 *   lists them with `$redraw_hot.types`, so that a removed variant is
 *   detected.
 * - Registers a hash of `main` with `$redraw_hot.bootstrap`, so that a
 *   change in the bootstrap is detected.
 *
 * For modules using `redraw`:
 * - Wraps every render function passed to `redraw.component_` in
 *   `$redraw_hot.tag(moduleId, hooksSignature, customHooks, render, args)`,
 *   where `args` are the arguments of the enclosing factory when it has
 *   parameters.
 * - Records the arguments of every call to a parameterized factory, so that
 *   the factory can be replayed after a hot update.
 * - Replaces `redraw.create_context_(default)` by
 *   `$redraw_hot.context("moduleId#n", default)` to keep context identities
 *   stable across factory re-runs.
 * - Registers the hooks signature of module-level custom hooks (`use_*`).
 * - Registers a hash of the module and of every export that is not a
 *   factory (helpers, custom hooks, constants) with `$redraw_hot.exports`:
 *   importers hold those through ESM bindings to the previous module
 *   instance, so when one of them changed, or when the module was
 *   re-executed because a dependency changed, the update must propagate to
 *   the importers.
 * - Appends an `import.meta.hot` trailer that self-accepts the module,
 *   re-runs its component factories after a hot update, and invalidates the
 *   module when a non-factory export changed.
 *
 * A factory is a top-level function building a component: it calls
 * `component_` with a function literal, `compose` or `memoize_`.
 * Zero-argument factories are re-run as is. Parameterized factories are
 * replayed with their recorded arguments, provided they call `component_`
 * themselves and only take plain parameters.
 */
export function redrawRefresh(_babel, { moduleId, hotImport }) {
  return {
    name: "redraw-refresh",
    visitor: {
      Program: {
        enter(path, state) {
          state.code = state.file.code
          state.redraw = findRedrawBindings(path)
          state.factories = state.redraw
            ? findFactories(path, state.redraw, moduleId)
            : new Map()
          state.classes = []
          state.customHooks = []
          state.contexts = 0
        },
        exit(path, state) {
          const statements = []
          for (const fn of state.customHooks) {
            statements.push(
              hotCall("hook", [
                t.identifier(fn.name),
                t.stringLiteral(fn.signature),
                fn.customHooks,
              ]),
            )
          }
          statements.push(
            hotCall("types", [
              t.stringLiteral(moduleId),
              t.arrayExpression(state.classes.map((name) => t.stringLiteral(name))),
            ]),
          )
          const main = findMain(path)
          if (main) {
            statements.push(
              hotCall("bootstrap", [
                t.stringLiteral(moduleId),
                t.stringLiteral(hashSource(state.code, main.node)),
              ]),
            )
          }
          path.pushContainer(
            "body",
            statements.map((call) => t.expressionStatement(call)),
          )
          const factories = [...state.factories.values()]
          const plain = factories.filter((f) => f.kind === "plain")
          const parameterized = factories.filter((f) => f.kind === "parameterized")
          if (plain.length > 0 || parameterized.length > 0) {
            path.pushContainer("body", [
              staleDeclaration(
                moduleId,
                hashSource(state.code, path.node),
                exportsHashes(path, state),
              ),
              trailer(moduleId, plain, parameterized),
            ])
          }
          path.unshiftContainer(
            "body",
            t.importDeclaration(
              [t.importNamespaceSpecifier(t.identifier(HOT_NAMESPACE))],
              t.stringLiteral(hotImport),
            ),
          )
        },
      },

      ClassDeclaration(path, state) {
        if (!isTopLevel(path) || !path.node.id) return
        const name = path.node.id.name
        // Classes generated for the module's own needs, like the inspector
        // of `echo`, contain a `$`, which a Gleam type name cannot: they
        // appear and disappear with the code using them.
        if (name.includes("$")) return
        state.classes.push(name)
        const statement = path.parentPath.isExportNamedDeclaration()
          ? path.parentPath
          : path
        statement.insertAfter(
          t.expressionStatement(
            hotCall("type", [
              t.stringLiteral(`${moduleId} ${name}`),
              t.identifier(name),
            ]),
          ),
        )
      },

      FunctionDeclaration(path, state) {
        if (!state.redraw) return
        if (!isTopLevel(path)) return
        const name = path.node.id?.name
        if (!name || !HOOK_NAME.test(name)) return
        const { signature, customHooks } = hooksSignature(path, state)
        state.customHooks.push({ name, signature, customHooks })
      },

      CallExpression(path, state) {
        if (!state.redraw) return
        const called = redrawFunction(path.node.callee, state.redraw)
        if (!called) return
        switch (called) {
          case "component_": {
            const render = path.get("arguments.1")
            // A render that is not a function literal comes from a wrapper
            // around `component_`, which a syntactic transform cannot
            // attribute to the right module: left alone.
            if (!render.node || !render.isFunction()) return
            const { signature, customHooks } = hooksSignature(render, state)
            const args = [
              t.stringLiteral(moduleId),
              t.stringLiteral(signature),
              customHooks,
              render.node,
            ]
            const factory = enclosingFactory(path, state)
            if (factory?.kind === "parameterized") {
              args.push(t.identifier(ARGS_NAME))
            }
            render.replaceWith(hotCall("tag", args))
            return
          }
          case "create_context_": {
            const key = `${moduleId}#${state.contexts++}`
            path.replaceWith(
              hotCall("context", [t.stringLiteral(key), ...path.node.arguments]),
            )
            return
          }
        }
      },
    },
  }
}

/** Finds how the compiled module refers to `redraw`: a namespace import
 * (`import * as $react from "../redraw/redraw.mjs"`) and/or named imports
 * (`import { component_ } from "../redraw/redraw.mjs"`). */
function findRedrawBindings(program) {
  const namespaces = new Set()
  const named = new Map()
  for (const statement of program.node.body) {
    if (!t.isImportDeclaration(statement)) continue
    if (!REDRAW_SOURCE.test(statement.source.value)) continue
    for (const specifier of statement.specifiers) {
      if (t.isImportNamespaceSpecifier(specifier)) {
        namespaces.add(specifier.local.name)
      } else if (t.isImportSpecifier(specifier)) {
        const imported = t.isIdentifier(specifier.imported)
          ? specifier.imported.name
          : specifier.imported.value
        named.set(specifier.local.name, imported)
      }
    }
  }
  if (namespaces.size === 0 && named.size === 0) return null
  return { namespaces, named }
}

/** Returns the name of the `redraw` function called by `callee`, if any. */
function redrawFunction(callee, redraw) {
  if (t.isIdentifier(callee)) return redraw.named.get(callee.name) ?? null
  if (
    t.isMemberExpression(callee) &&
    !callee.computed &&
    t.isIdentifier(callee.object) &&
    t.isIdentifier(callee.property) &&
    redraw.namespaces.has(callee.object.name)
  ) {
    return callee.property.name
  }
  return null
}

function isTopLevel(path) {
  const parent = path.parentPath
  if (parent.isProgram()) return true
  return parent.isExportNamedDeclaration() && parent.parentPath.isProgram()
}

function topLevelFunctions(program) {
  const functions = []
  for (const statement of program.get("body")) {
    const fn = statement.isExportNamedDeclaration()
      ? statement.get("declaration")
      : statement
    if (fn.isFunctionDeclaration() && fn.node.id) functions.push(fn)
  }
  return functions
}

function findMain(program) {
  return topLevelFunctions(program).find((fn) => fn.node.id.name === "main")
}

/** Finds the component factories of the module, and instruments the
 * parameterized ones: their arguments are captured at the start of the body
 * (which avoids any shadowing issue in nested `use` callbacks) and recorded
 * for replay. */
function findFactories(program, redraw, moduleId) {
  const factories = new Map()
  for (const fn of topLevelFunctions(program)) {
    let creates = false
    let composes = false
    fn.traverse({
      CallExpression(call) {
        const called = redrawFunction(call.node.callee, redraw)
        if (called === "component_") {
          if (t.isFunction(call.node.arguments[1])) creates = true
        } else if (called === "compose" || called === "memoize_") {
          composes = true
        }
      },
    })
    if (!creates && !composes) continue
    const name = fn.node.id.name
    const params = fn.node.params
    if (params.length === 0) {
      factories.set(name, { name, kind: "plain" })
      continue
    }
    // A parameterized function calling `compose` or `memoize_` without
    // `component_` is a helper receiving a component created elsewhere, like
    // `fn memo(c) { memoize_(c) }` or `render_` in `redraw_dom`. It holds no
    // render code, so there is nothing to replay. A function with
    // destructured or rest parameters is not produced by Gleam, so it is left
    // alone too.
    if (!creates || !params.every((param) => t.isIdentifier(param))) {
      factories.set(name, { name, kind: "skip" })
      continue
    }
    const key = `${moduleId} ${name}`
    factories.set(name, { name, kind: "parameterized", key })
    fn.get("body").unshiftContainer("body", [
      t.variableDeclaration("const", [
        t.variableDeclarator(
          t.identifier(ARGS_NAME),
          t.arrayExpression(params.map((param) => t.identifier(param.name))),
        ),
      ]),
      t.expressionStatement(
        hotCall("invoked", [t.stringLiteral(key), t.identifier(ARGS_NAME)]),
      ),
    ])
  }
  return factories
}

function enclosingFactory(path, state) {
  const fn = path.findParent((p) => p.isFunctionDeclaration() && isTopLevel(p))
  if (!fn || !fn.node.id) return null
  return state.factories.get(fn.node.id.name) ?? null
}

/** Hashes of the exports importers may hold through ESM bindings: every
 * exported function that is not a factory (helpers, custom hooks, wrappers)
 * except `main`, which has its own hash, and every exported constant written
 * by the user. The generated accessors of custom types contain a `$` and
 * build the current classes, and classes themselves are reconciled: both are
 * left out. */
function exportsHashes(program, state) {
  const hashes = []
  for (const statement of program.get("body")) {
    if (!statement.isExportNamedDeclaration()) continue
    const declaration = statement.node.declaration
    if (t.isFunctionDeclaration(declaration) && declaration.id) {
      const name = declaration.id.name
      if (name === "main") continue
      const kind = state.factories.get(name)?.kind
      if (kind === "plain" || kind === "parameterized") continue
      hashes.push([name, hashSource(state.code, declaration)])
    } else if (t.isVariableDeclaration(declaration)) {
      for (const declarator of declaration.declarations) {
        if (!t.isIdentifier(declarator.id)) continue
        const name = declarator.id.name
        if (name.includes("$")) continue
        hashes.push([name, hashSource(state.code, declarator)])
      }
    }
  }
  return hashes
}

/** Collects every `use_*` call inside `path`, in source order, to build the
 * hooks signature React Refresh compares between two versions of a component.
 * The initial value of state hooks is part of the signature. Calls to
 * module-level functions and namespace members are also returned as
 * expressions, so React Refresh can follow custom hooks signatures. */
function hooksSignature(path, state) {
  const names = []
  const custom = []
  const seen = new Set()
  const visit = (call, scope) => {
    const callee = call.callee
    if (t.isIdentifier(callee) && HOOK_NAME.test(callee.name)) {
      names.push(callee.name + initialValue(callee.name, call, state))
      const binding = scope.getBinding(callee.name)
      if (binding && binding.scope.path.isProgram() && !seen.has(callee.name)) {
        seen.add(callee.name)
        custom.push(t.identifier(callee.name))
      }
    } else if (
      t.isMemberExpression(callee) &&
      !callee.computed &&
      t.isIdentifier(callee.object) &&
      t.isIdentifier(callee.property) &&
      HOOK_NAME.test(callee.property.name)
    ) {
      const key = `${callee.object.name}.${callee.property.name}`
      names.push(key + initialValue(callee.property.name, call, state))
      const binding = scope.getBinding(callee.object.name)
      const isNamespace =
        binding &&
        binding.kind === "module" &&
        !state.redraw.namespaces.has(callee.object.name)
      if (isNamespace && !seen.has(key)) {
        seen.add(key)
        custom.push(t.cloneNode(callee))
      }
    }
  }
  const visitor = {
    CallExpression(call) {
      visit(call.node, call.scope)
    },
  }
  if (path.isFunction()) path.get("body").traverse(visitor)
  else path.traverse(visitor)
  return {
    signature: names.join("\n"),
    customHooks: t.arrowFunctionExpression([], t.arrayExpression(custom)),
  }
}

/** Source of the arguments of a state hook call, as written in the compiled
 * module, so that a change in the initial value changes the signature. */
function initialValue(name, call, state) {
  if (!STATE_HOOKS.has(name)) return ""
  const args = call.arguments.map((arg) =>
    arg.start == null ? "?" : state.code.slice(arg.start, arg.end),
  )
  return "(" + args.join(", ") + ")"
}

/** Hash of the source of a node, with the source positions Gleam embeds in
 * `let assert`, `assert`, `panic`, `todo` and `echo` neutralized: they move
 * with every edit above the node, and must not count as a change. */
export function hashSource(code, node) {
  return hash(stableSource(code.slice(node.start, node.end)))
}

export function stableSource(source) {
  return source
    .replace(
      /(makeError\(\s*"[^"]*",\s*FILEPATH,\s*"[^"]*",\s*)\d+/g,
      (_, prefix) => prefix + "0",
    )
    .replace(
      /\b(start|end|pattern_start|pattern_end|expression_start)\s*:\s*\d+/g,
      (_, key) => key + ":0",
    )
    .replace(/("[^"]*\.gleam",\s*)\d+\)/g, (_, prefix) => prefix + "0)")
}

function hotCall(name, args) {
  return t.callExpression(
    t.memberExpression(t.identifier(HOT_NAMESPACE), t.identifier(name)),
    args,
  )
}

function staleDeclaration(moduleId, moduleHash, hashes) {
  return t.variableDeclaration("const", [
    t.variableDeclarator(
      t.identifier(STALE_NAME),
      hotCall("exports", [
        t.stringLiteral(moduleId),
        t.stringLiteral(moduleHash),
        t.objectExpression(
          hashes.map(([name, value]) =>
            t.objectProperty(t.stringLiteral(name), t.stringLiteral(value)),
          ),
        ),
      ]),
    ),
  ])
}

const buildTrailer = template.statement(
  `
if (import.meta.hot) {
  import.meta.hot.accept();
  if (import.meta.hot.data.redraw) {
    HOT.rerun(MODULE, FACTORIES, PARAMETERIZED);
    if (STALE) import.meta.hot.invalidate("an export used by importers changed");
  }
  import.meta.hot.data.redraw = true;
}
`,
  { placeholderPattern: /^(HOT|MODULE|FACTORIES|PARAMETERIZED|STALE)$/ },
)

function trailer(moduleId, plain, parameterized) {
  return buildTrailer({
    HOT: t.identifier(HOT_NAMESPACE),
    MODULE: t.stringLiteral(moduleId),
    FACTORIES: t.arrayExpression(plain.map((f) => t.identifier(f.name))),
    PARAMETERIZED: t.objectExpression(
      parameterized.map((f) =>
        t.objectProperty(t.stringLiteral(f.key), t.identifier(f.name)),
      ),
    ),
    STALE: t.identifier(STALE_NAME),
  })
}

function hash(input) {
  let h = 5381
  for (let i = 0; i < input.length; i++) h = ((h << 5) + h + input.charCodeAt(i)) | 0
  return (h >>> 0).toString(36)
}
