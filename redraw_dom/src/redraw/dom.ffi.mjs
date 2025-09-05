import * as ReactDOM from "react-dom"
import {
  Anonymous,
  Auto,
  High,
  Low,
  AsScript,
  UseCredentials,
  NoReferrerWhenDowngrade,
  NoReferrer,
  Origin,
  OriginWhenCrossOrigin,
  UnsafeUrl,
  Audio,
  Document,
  Embed,
  Fetch,
  Font,
  Image,
  Object,
  Script,
  Style,
  Track,
  Video,
  Worker,
  Status,
  InvalidRoot,
} from "./dom.mjs"
import { Ok, Error } from "../gleam.mjs"
import * as $uri from "../../gleam_stdlib/gleam/uri.mjs"
import { None, Some } from "../../gleam_stdlib/gleam/option.mjs"

export function createPortal(children, root) {
  const node = document.getElementById(root)
  if (!node) return new Error(new InvalidRoot(root))
  const portal = ReactDOM.createPortal(children, node)
  return new Ok(portal)
}

export function preconnect(uri, crossOrigin) {
  const href = $uri.to_string(uri)
  crossOrigin = convertCrossOrigin(crossOrigin[0])
  return ReactDOM.preconnect(href, { crossOrigin })
}

export function prefetchDNS(uri) {
  const href = $uri.to_string(uri)
  return ReactDOM.prefetchDNS(href)
}

export function preinit(
  uri,
  as,
  precedence,
  crossOrigin,
  integrity,
  nonce,
  fetchPriority,
) {
  const href = $uri.to_string(uri)
  return ReactDOM.preinit(href, {
    as: as instanceof AsScript ? "script" : "style",
    precedence: precedence[0],
    crossOrigin: convertCrossOrigin(crossOrigin[0]),
    integrity: integrity[0],
    nonce: nonce[0],
    fetchPriority: convertFetchPriority(fetchPriority[0]),
  })
}

export function preinitModule(uri, crossOrigin, integrity, nonce) {
  const href = $uri.to_string(uri)
  return ReactDOM.preinitModule(href, {
    as: "script",
    crossOrigin: convertCrossOrigin(crossOrigin[0]),
    integrity: integrity[0],
    nonce: nonce[0],
  })
}

export function preload(
  uri,
  as,
  crossOrigin,
  referrerPolicy,
  integrity,
  type,
  nonce,
  fetchPriority,
  imageSrcSet,
  imageSizes,
) {
  const href = $uri.to_string(uri)
  return ReactDOM.preload(href, {
    as: convertResource(as),
    crossOrigin: convertCrossOrigin(crossOrigin[0]),
    referrerPolicy: convertReferrerPolicy(referrerPolicy[0]),
    integrity: integrity[0],
    type: type[0],
    nonce: nonce[0],
    fetchPriority: convertFetchPriority(fetchPriority[0]),
    imageSrcSet: imageSrcSet[0],
    imageSizes: imageSizes[0],
  })
}

export function preloadModule(uri, crossOrigin, integrity, nonce) {
  const href = $uri.to_string(uri)
  return ReactDOM.preloadModule(href, {
    as: "script",
    crossOrigin: convertCrossOrigin(crossOrigin[0]),
    integrity: integrity[0],
    nonce: nonce[0],
  })
}

export function useFormStatus() {
  const status = ReactDOM.useFormStatus()
  return new Status(
    status.pending,
    status.data ? new Some(status.data) : new None(),
    status.method,
    status.action ? new Some(status.action) : new None(),
  )
}

function convertCrossOrigin(crossOrigin) {
  if (!crossOrigin) return
  if (crossOrigin instanceof Anonymous) return "anonymous"
  if (crossOrigin instanceof UseCredentials) return "use-credentials"
}

function convertFetchPriority(fetchPriority) {
  if (!fetchPriority) return
  if (fetchPriority instanceof Auto) return "auto"
  if (fetchPriority instanceof High) return "high"
  if (fetchPriority instanceof Low) return "low"
}

function convertReferrerPolicy(referrerPolicy) {
  if (!referrerPolicy) return
  if (referrerPolicy instanceof NoReferrerWhenDowngrade)
    return "no-referrer-when-downgrade"
  if (referrerPolicy instanceof NoReferrer) return "no-referrer"
  if (referrerPolicy instanceof Origin) return "origin"
  if (referrerPolicy instanceof OriginWhenCrossOrigin)
    return "origin-when-cross-origin"
  if (referrerPolicy instanceof UnsafeUrl) return "unsafe-url"
}

function convertResource(resource) {
  if (resource instanceof Audio) return "audio"
  if (resource instanceof Document) return "document"
  if (resource instanceof Embed) return "embed"
  if (resource instanceof Fetch) return "fetch"
  if (resource instanceof Font) return "font"
  if (resource instanceof Image) return "image"
  if (resource instanceof Object) return "object"
  if (resource instanceof Script) return "script"
  if (resource instanceof Style) return "style"
  if (resource instanceof Track) return "track"
  if (resource instanceof Video) return "video"
  if (resource instanceof Worker) return "worker"
}
