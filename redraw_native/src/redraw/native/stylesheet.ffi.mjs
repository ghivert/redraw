import { StyleSheet } from 'react-native'
import * as $gleam from '../../gleam.mjs'

export function create(styles) {
  const stylesheet = {}
  for (const [name, allStyles] of styles) stylesheet[name] = compile(allStyles)
  return StyleSheet.create(stylesheet)
}

export function compile(styles) {
  const class_ = {}
  for (const style of styles) class_[style.key] = style.value
  return class_
}

export function get(stylesheet, name) {
  const styles = stylesheet[name]
  if (styles) return new $gleam.Ok(styles)
  return new $gleam.Error()
}
