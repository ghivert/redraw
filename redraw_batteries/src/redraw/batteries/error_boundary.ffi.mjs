import * as React from "react"
import { jsxs } from "react/jsx-runtime"
import * as $option from "../../../gleam_stdlib/gleam/option.mjs"
import * as $errorBoundary from "./error_boundary.mjs"

class ErrorBoundary extends React.Component {
  /** @param {any} props */
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }

  /** Update state so the next render will show the fallback UI.
   * @param {any} _error */
  static getDerivedStateFromError(_error) {
    return { hasError: true }
  }

  /** Catch errors, and forward it to the error handler provided in props.
   * @param {Error} error
   * @param {React.ErrorInfo} info */
  componentDidCatch(error, info) {
    const name = error.name
    const message = error.message
    const cause = toOption(error.cause)
    const stack = toOption(error.stack)
    const componentStack = info.componentStack
      ? $option.Option$Some(info.componentStack)
      : $option.Option$None()
    const capturedOwnerStack = captureOwnerStack()
    const ownerStack = capturedOwnerStack
      ? $option.Option$Some(capturedOwnerStack)
      : $option.Option$None()
    const err = $errorBoundary.Error$Error(name, message, cause, stack)
    const errInfo = $errorBoundary.Error$ErrorInfo(componentStack, ownerStack)
    this.props.onError(err, errInfo)
    this.props.onRawError(error, info)
  }

  render() {
    if (this.state.hasError) return this.props.fallback ?? null
    return this.props.children
  }
}

/** @param {any} props */
export function errorBoundary(props) {
  return jsxs(ErrorBoundary, {
    children: props.children,
    fallback: props.fallback,
    onError: props.on_error,
    onRawError: props.on_raw_error,
  })
}

function toOption(value) {
  if (value === undefined) return $option.Option$None()
  return $option.Option$Some(value)
}

function captureOwnerStack() {
  if (!("captureOwnerStack" in React)) return null
  return React.captureOwnerStack()
}
