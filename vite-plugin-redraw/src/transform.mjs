import { template, types as t } from "@babel/core"

/** Matches the compiled `redraw` module, as imported from Gleam output:
 * `../redraw/redraw.mjs`, `../../redraw/redraw.mjs`, etc. */
const REDRAW_SOURCE = /(^|\/)redraw\/redraw\.mjs$/
const HOOK_NAME = /^use_/
const HOT_NAMESPACE = "$redraw_hot"
const ARGS_NAME = "$redraw_args"

/** Babel plugin applied to compiled Gleam modules in development.
 *
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
 * - Registers every custom type class with `$redraw_hot.type`, so that
 *   values created before a hot update still match the new classes.
 * - Appends an `import.meta.hot` trailer that self-accepts the module and
 *   re-runs its component factories after a hot update.
 *
 * A factory is a top-level function building a component: it calls
 * `component_`, `compose` or `memoize_`. Zero-argument factories are re-run
 * as is. Parameterized factories are replayed with their recorded arguments,
 * provided they call `component_` themselves and only take plain parameters.
 */
export function redrawRefresh(_babel, { moduleId, hotImport }) {
  return {
    name: "redraw-refresh",
    visitor: {
      Program: {
        enter(path, state) {
          state.redraw = findRedrawBindings(path)
          if (!state.redraw) return
          state.factories = findFactories(path, state.redraw, moduleId)
          state.customHooks = []
          state.contexts = 0
          state.touched = false
        },
        exit(path, state) {
          if (!state.redraw) return
          for (const fn of state.customHooks) {
            path.pushContainer(
              "body",
              t.expressionStatement(
                hotCall("hook", [
                  t.identifier(fn.name),
                  t.stringLiteral(fn.signature),
                  fn.customHooks,
                ]),
              ),
            )
          }
          const factories = [...state.factories.values()]
          const plain = factories.filter((f) => f.kind === "plain")
          const parameterized = factories.filter((f) => f.kind === "parameterized")
          if (plain.length > 0 || parameterized.length > 0) {
            path.pushContainer("body", trailer(plain, parameterized))
          }
          if (state.touched || state.customHooks.length || factories.length) {
            path.unshiftContainer(
              "body",
              t.importDeclaration(
                [t.importNamespaceSpecifier(t.identifier(HOT_NAMESPACE))],
                t.stringLiteral(hotImport),
              ),
            )
          }
        },
      },

      ClassDeclaration(path, state) {
        if (!state.redraw) return
        if (!isTopLevel(path) || !path.node.id) return
        const name = path.node.id.name
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
        state.touched = true
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
            if (!render.node) return
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
            state.touched = true
            return
          }
          case "create_context_": {
            const key = `${moduleId}#${state.contexts++}`
            path.replaceWith(
              hotCall("context", [t.stringLiteral(key), ...path.node.arguments]),
            )
            state.touched = true
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

/** Finds the component factories of the module, and instruments the
 * parameterized ones: their arguments are captured at the start of the body
 * (which avoids any shadowing issue in nested `use` callbacks) and recorded
 * for replay. */
function findFactories(program, redraw, moduleId) {
  const factories = new Map()
  for (const statement of program.get("body")) {
    const fn = statement.isExportNamedDeclaration()
      ? statement.get("declaration")
      : statement
    if (!fn.isFunctionDeclaration() || !fn.node.id) continue
    let creates = false
    let composes = false
    fn.traverse({
      CallExpression(call) {
        const called = redrawFunction(call.node.callee, redraw)
        if (called === "component_") creates = true
        else if (called === "compose" || called === "memoize_") composes = true
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

/** Collects every `use_*` call inside `path`, in source order, to build the
 * hooks signature React Refresh compares between two versions of a component.
 * Calls to module-level functions and namespace members are also returned as
 * expressions, so React Refresh can follow custom hooks signatures. */
function hooksSignature(path, state) {
  const names = []
  const custom = []
  const seen = new Set()
  const visit = (callee, scope) => {
    if (t.isIdentifier(callee) && HOOK_NAME.test(callee.name)) {
      names.push(callee.name)
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
      names.push(key)
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
      visit(call.node.callee, call.scope)
    },
  }
  if (path.isFunction()) path.get("body").traverse(visitor)
  else path.traverse(visitor)
  return {
    signature: names.join("\n"),
    customHooks: t.arrowFunctionExpression([], t.arrayExpression(custom)),
  }
}

function hotCall(name, args) {
  return t.callExpression(
    t.memberExpression(t.identifier(HOT_NAMESPACE), t.identifier(name)),
    args,
  )
}

const buildTrailer = template.statement(
  `
if (import.meta.hot) {
  import.meta.hot.accept();
  if (import.meta.hot.data.redraw) HOT.rerun(FACTORIES, PARAMETERIZED);
  import.meta.hot.data.redraw = true;
}
`,
  { placeholderPattern: /^(HOT|FACTORIES|PARAMETERIZED)$/ },
)

function trailer(plain, parameterized) {
  return buildTrailer({
    HOT: t.identifier(HOT_NAMESPACE),
    FACTORIES: t.arrayExpression(plain.map((f) => t.identifier(f.name))),
    PARAMETERIZED: t.objectExpression(
      parameterized.map((f) =>
        t.objectProperty(t.stringLiteral(f.key), t.identifier(f.name)),
      ),
    ),
  })
}
