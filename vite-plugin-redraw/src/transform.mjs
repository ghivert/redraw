import { template, types as t } from "@babel/core"

/** Matches the compiled `redraw` module, as imported from Gleam output:
 * `../redraw/redraw.mjs`, `../../redraw/redraw.mjs`, etc. */
const REDRAW_SOURCE = /(^|\/)redraw\/redraw\.mjs$/
const HOOK_NAME = /^use_/
const HOT_NAMESPACE = "$redraw_hot"

/** Babel plugin applied to compiled Gleam modules in development.
 *
 * - Wraps every render function passed to `redraw.component_` in
 *   `$redraw_hot.tag(moduleId, hooksSignature, customHooks, render)`.
 * - Replaces `redraw.create_context_(default)` by
 *   `$redraw_hot.context("moduleId#n", default)` to keep context identities
 *   stable across factory re-runs.
 * - Registers the hooks signature of module-level custom hooks (`use_*`).
 * - Appends an `import.meta.hot` trailer that self-accepts the module and
 *   re-runs its component factories (zero-argument top-level functions
 *   building a component) after a hot update.
 */
export function redrawRefresh(_babel, { moduleId, hotImport }) {
  return {
    name: "redraw-refresh",
    visitor: {
      Program: {
        enter(path, state) {
          state.redraw = findRedrawBindings(path)
          state.factories = new Map()
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
            .filter((f) => f.rerunnable)
            .map((f) => f.name)
          if (factories.length > 0) {
            path.pushContainer("body", trailer(factories))
          }
          if (state.touched || state.customHooks.length || factories.length) {
            path.unshiftContainer(
              "body",
              t.importDeclaration(
                [
                  t.importNamespaceSpecifier(t.identifier(HOT_NAMESPACE)),
                ],
                t.stringLiteral(hotImport),
              ),
            )
          }
        },
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
            markFactory(path, state)
            const render = path.get("arguments.1")
            if (!render.node) return
            const { signature, customHooks } = hooksSignature(render, state)
            render.replaceWith(
              hotCall("tag", [
                t.stringLiteral(moduleId),
                t.stringLiteral(signature),
                customHooks,
                render.node,
              ]),
            )
            state.touched = true
            return
          }
          case "compose":
          case "memoize_":
            markFactory(path, state)
            return
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

/** Records the top-level function enclosing `path` as a component factory.
 * Only zero-argument factories can be re-run blindly after a hot update. */
function markFactory(path, state) {
  const fn = path.findParent((p) => p.isFunctionDeclaration() && isTopLevel(p))
  if (!fn || !fn.node.id) return
  const name = fn.node.id.name
  if (state.factories.has(name)) return
  state.factories.set(name, { name, rerunnable: fn.node.params.length === 0 })
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
  if (path.isFunction()) {
    path.get("body").traverse({
      CallExpression(call) {
        visit(call.node.callee, call.scope)
      },
    })
  } else {
    path.traverse({
      CallExpression(call) {
        visit(call.node.callee, call.scope)
      },
    })
  }
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
  if (import.meta.hot.data.redraw) HOT.rerun(FACTORIES);
  import.meta.hot.data.redraw = true;
}
`,
  { placeholderPattern: /^(HOT|FACTORIES)$/ },
)

function trailer(factories) {
  return buildTrailer({
    HOT: t.identifier(HOT_NAMESPACE),
    FACTORIES: t.arrayExpression(factories.map((name) => t.identifier(name))),
  })
}
