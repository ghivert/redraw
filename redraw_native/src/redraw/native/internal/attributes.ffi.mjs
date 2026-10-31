export function toProps(attributes) {
  const props = {}
  for (const item of attributes) {
    switch (item.key) {
      case 'style': {
        props.style = [...(props.style ?? []), item.content]
        break
      }
      case 'none_':
        break
      default: {
        props[item.key] = item.content
        break
      }
    }
  }
  return props
}

export function merge(a, b) {
  return { ...a, ...b }
}

export function toMaintainVisibleContentPosition(a, b) {
  return { minIndexForVisible: a, autoscrollToTopThreshold: b }
}

export function toArray(a) {
  return a.toArray()
}

export function toOffset(width, height) {
  return { width, height }
}

export function rippleConfig(config) {
  const res = {}
  if (config.color[0]) res.color = config.color[0]
  if (config.borderless[0]) res.borderless = config.borderless[0]
  if (config.radius[0]) res.radius = config.radius[0]
  if (config.foreground[0]) res.foreground = config.foreground[0]
  return res
}

export function toRect(bottom, top, right, left) {
  return { bottom, top, right, left }
}

export function toTrackColor(false_, true_) {
  return { false: false_, true: true_ }
}

export function toSelection(start, end) {
  return { start, end }
}
