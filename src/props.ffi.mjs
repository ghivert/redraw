import * as gleam from "./gleam.mjs"

export function propsToGleamProps(props, originalProps) {
  switch (props.__propsType) {
    case "List": {
      let list = new gleam.Empty()
      for (let i = props.__length; i > 0; i--)
        list = new gleam.NonEmpty(props[i - 1], list)
      return list
    }
    case "Tuple": {
      const tuple = new Array(props.__length)
      for (let i = 0; i < props.__length; i++) tuple[i] = props[i]
      return tuple
    }
    default: {
      const [Prototype, firstProps] = originalProps.current[props.__propsType]
      const values = Object.keys(firstProps).map((key) => props[key])
      return new Prototype.constructor(...values)
    }
  }
}

export function gleamPropsToProps(props_, originalProps, ref) {
  if (props_ instanceof gleam.CustomType) {
    const prototype = Object.getPrototypeOf(props_)
    const name = prototype.constructor.name
    originalProps.current[name] ??= [prototype, props_]
    const props = { ...props_, __propsType: name }
    if (ref) props.ref = ref
    return props
  } else if (props_ instanceof gleam.List) {
    const props = { __propsType: "List" }
    let index = 0
    for (const item of props_) props[index++] = item
    props.__length = index
    if (ref) props.ref = ref
    return props
  } else if (Array.isArray(props_)) {
    const props = { __propsType: "Tuple" }
    let index = 0
    for (const item of props_) props[index++] = item
    props.__length = index
    if (ref) props.ref = ref
    return props
  } else {
    console.warn(
      `redraw only support custom types, list or tuples as props.
      ${Component.displayName} received ${props_} as props.`.replace(
        /\n( )*/g,
        "\n",
      ),
    )
    return null
  }
}
