import { List, Empty, NonEmpty, CustomType } from "./gleam.mjs"

export function propsToGleamProps(props, originalProps) {
  switch (props.__propsType) {
    case "List": {
      let list = new Empty()
      for (let i = props.__length; i > 0; i--)
        list = new NonEmpty(props[i - 1], list)
      return list
    }
    case "Tuple": {
      const tuple = new Array(props.__length)
      for (let i = 0; i < props.__length; i++) tuple[i] = props[i]
      return tuple
    }
    case "Nil": {
      return undefined
    }
    default: {
      const [Prototype, firstProps] = originalProps.current[props.__propsType]
      const values = Object.keys(firstProps).map((key) => props[key])
      return new Prototype.constructor(...values)
    }
  }
}

export function gleamPropsToProps(props_, originalProps) {
  if (props_ instanceof CustomType) {
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name }
    return props
  } else if (props_ instanceof List) {
    const props = { __propsType: "List" }
    let index = 0
    for (const item of props_) props[index++] = item
    props.__length = index
    return props
  } else if (Array.isArray(props_)) {
    const props = { __propsType: "Tuple" }
    let index = 0
    for (const item of props_) props[index++] = item
    props.__length = index
    return props
  } else if (props_ === undefined) {
    const props = { __propsType: "Nil" }
    return props
  } else {
    const msg = `redraw only support custom types, list, tuples or Nil as props.
      Received ${props_} as props.`
    const msg_ = msg.replace(/\n( )*/g, "\n")
    console.warn(msg_)
    return null
  }
}

// Add some Redraw helpers directly on `window` to simplify
// development of Redraw Refresh.
if (typeof window !== "undefined") {
  window.redraw = {
    props: {
      toGleam: propsToGleamProps,
      fromGleam: gleamPropsToProps,
    },
  }
}
