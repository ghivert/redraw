import * as $gleam from "./gleam.mjs"

const type$ = Symbol.for("Redraw:Gleam:Type")
const prototype$ = Symbol.for("Redraw:Gleam:Prototype")
const length$ = Symbol.for("Redraw:Gleam:Length")
const original$ = Symbol.for("Redraw:Gleam:Original")

const list$ = Symbol.for("Redraw:Gleam:List")
const tuple$ = Symbol.for("Redraw:Gleam:Tuple")
const number$ = Symbol.for("Redraw:Gleam:Number")
const string$ = Symbol.for("Redraw:Gleam:String")
const function$ = Symbol.for("Redraw:Gleam:Function")
const bitArray$ = Symbol.for("Redraw:Gleam:BitArray")
const unknown$ = Symbol.for("Redraw:Gleam:Unknown")
const boolean$ = Symbol.for("Redraw:Gleam:Boolean")
const nil$ = Symbol.for("Redraw:Gleam:Nil")
const customType$ = Symbol.for("Redraw:Gleam:CustomType")

export function areEqual(before, after) {
  if (before[type$] !== after[type$]) return false
  switch (after[type$]) {
    case nil$:
      return true
    case tuple$:
    case list$: {
      if (before[length$] !== after[length$]) return false
      for (let i = after[length$]; i > 0; i--)
        if (!$gleam.isEqual(before[i], after[i])) return false
      return true
    }
    case string$:
    case function$:
    case bitArray$:
    case unknown$:
    case boolean$:
    case number$: {
      return Object.is(before.value, after.value)
    }
    case customType$: {
      return $gleam.isEqual(before[original$], after[original$])
    }
  }
}

export function propsToGleamProps(props) {
  switch (props[type$]) {
    case list$: {
      let list = $gleam.List$Empty()
      for (let i = props[length$]; i > 0; i--)
        list = $gleam.List$NonEmpty(props[i - 1], list)
      return list
    }
    case tuple$: {
      const tuple = new Array(props[length$])
      for (let i = 0; i < props[length$]; i++) tuple[i] = props[i]
      return tuple
    }
    case nil$: {
      return undefined
    }
    case string$:
    case function$:
    case bitArray$:
    case unknown$:
    case boolean$:
    case number$: {
      return props.value
    }
    case customType$: {
      const Prototype = props[prototype$]
      const firstProps = props[original$]
      const values = Object.keys(firstProps).map((key) => props[key])
      return new Prototype.constructor(...values)
    }
  }
}

export function gleamPropsToProps(props_) {
  if (props_ instanceof $gleam.CustomType) {
    const prototype = Object.getPrototypeOf(props_)
    const props = { ...props_, [type$]: customType$ }
    Object.defineProperties(props, {
      [prototype$]: { enumerable: true, value: prototype, writable: false },
      [original$]: { enumerable: true, value: props_, writable: false },
    })
    return props
  } else if (props_ instanceof $gleam.List) {
    const props = { [type$]: list$ }
    let index = 0
    for (const item of props_) props[index++] = item
    props[length$] = index
    return props
  } else if (props_ instanceof $gleam.BitArray) {
    return { [type$]: bitArray$, value: props_ }
  } else if (Array.isArray(props_)) {
    const props = { [type$]: tuple$ }
    let index = 0
    for (const item of props_) props[index++] = item
    props[length$] = index
    return props
  } else if (props_ === undefined) {
    return { [type$]: nil$ }
  } else if (typeof props_ === "number") {
    return { [type$]: number$, value: props_ }
  } else if (typeof props_ === "string") {
    return { [type$]: string$, value: props_ }
  } else if (typeof props_ === "function") {
    return { [type$]: function$, value: props_ }
  } else if (typeof props_ === "boolean") {
    return { [type$]: boolean$, value: props_ }
  } else {
    return { [type$]: unknown$, value: props_ }
  }
}

// Add some Redraw helpers directly on `window` to simplify
// development of Redraw Refresh.
if (typeof window !== "undefined") {
  window.redraw = {
    props: {
      toGleam: propsToGleamProps,
      fromGleam: gleamPropsToProps,
      areEqual,
    },
  }
}
