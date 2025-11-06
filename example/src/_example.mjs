import * as $int from "../gleam_stdlib/gleam/int.mjs"
import * as $list from "../gleam_stdlib/gleam/list.mjs"
import * as $redraw from "../redraw/redraw.mjs"
import * as $a from "../redraw_dom/redraw/dom/attribute.mjs"
import * as $client from "../redraw_dom/redraw/dom/client.mjs"
import * as $events from "../redraw_dom/redraw/dom/events.mjs"
import * as $html from "../redraw_dom/redraw/dom/html.mjs"
import { Ok, toList, CustomType as $CustomType, makeError } from "./gleam.mjs"

const FILEPATH = "src/example.gleam"

export class CounterProps extends $CustomType {
  constructor(count, set_count) {
    super()
    this.count = count
    this.set_count = set_count
  }
}

const counter = $props.propsToGleamProps((props) => {
  return $html.button(
    toList([
      $events.on_click((_) => {
        return props.set_count((count) => {
          return count + 1
        })
      }),
    ]),
    $list.map(toList([props.count]), (count) => {
      return $html.text("count is " + $int.to_string(count))
    }),
  )
})
counter.displayName = "Counter"

function nav_links() {
  return $html.div(
    toList([]),
    toList([
      $html.a(
        toList([$a.href("https://vitejs.dev"), $a.target("_blank")]),
        toList([
          $html.img(
            toList([
              $a.src("/vite.svg"),
              $a.class$("logo"),
              $a.alt("Vite logo"),
            ]),
          ),
        ]),
      ),
      $html.a(
        toList([$a.href("https://gleam.run"), $a.target("_blank")]),
        toList([
          $html.img(
            toList([
              $a.src("/lucy.svg"),
              $a.class$("logo lucy"),
              $a.alt("Gleam logo"),
            ]),
          ),
        ]),
      ),
      $html.a(
        toList([$a.href("https://react.dev"), $a.target("_blank")]),
        toList([
          $html.img(
            toList([
              $a.src("/react.svg"),
              $a.class$("logo react"),
              $a.alt("React logo"),
            ]),
          ),
        ]),
      ),
    ]),
  )
}

function use_counter() {
  let $ = $redraw.use_state_(0)
  let count
  let set_count
  count = $[0]
  set_count = $[1]
  return [count, set_count]
}

const app = $props.propsToGleamProps((_) => {
  const counter_ = jsxify(counter)
  let $ = use_counter()
  let count
  let set_count
  count = $[0]
  set_count = $[1]
  return $redraw.fragment(
    toList([
      nav_links(),
      $html.h1(toList([]), toList([$html.text("Vite + Gleam + React")])),
      $html.div(
        toList([$a.class$("card")]),
        toList([
          counter_(new CounterProps(count, set_count)),
          $html.p(
            toList([]),
            toList([
              $html.text("Edit "),
              $html.code(toList([]), toList([$html.text("src/main.gleam")])),
              $html.text(" and save to test HMR"),
            ]),
          ),
        ]),
      ),
      $html.p(
        toList([$a.class$("read-the-docs")]),
        toList([
          $html.text("Click on the Vite, Gleam and React logos to learn more"),
        ]),
      ),
    ]),
  )
})
app.displayName = "App"

export const root = $props.propsToGleamProps((_) => {
  const app_ = jsxify(app)
  return app(undefined)
})
root.displayName = "Root"

export function main() {
  let $ = $client.create_root("root")
  let node
  if ($ instanceof Ok) {
    node = $[0]
  } else {
    throw makeError(
      "let_assert",
      FILEPATH,
      "example",
      10,
      "main",
      "Pattern match failed, no pattern matched the value.",
      { value: $, start: 174, end: 222, pattern_start: 185, pattern_end: 193 },
    )
  }
  const root_ = jsxify(root)
  return $client.render(node, () => {
    return $redraw.strict_mode(toList([root_(undefined)]))
  })
}

const jsxify = (component) => {
  return (props) => {
    props = $props.gleamPropsToProps(props)
    return $redraw.jsx(root, props)
  }
}
