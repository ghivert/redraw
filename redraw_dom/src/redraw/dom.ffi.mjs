import * as ReactDOM from "react-dom"
import * as $dom from "./dom.mjs"
import * as $gleam from "../gleam.mjs"
import * as $uri from "../../gleam_stdlib/gleam/uri.mjs"
import * as $option from "../../gleam_stdlib/gleam/option.mjs"

export function createPortal(children, root) {
  const node = document.getElementById(root)
  if (!node) return $gleam.Result$Error($dom.Error$InvalidRoot(root))
  const portal = ReactDOM.createPortal(children, node)
  return $gleam.Result$Ok(portal)
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
    as: $dom.As$isAsScript(as) ? "script" : "style",
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
  return $dom.Status$Status(
    status.pending,
    status.data ? $option.Option$Some(status.data) : $option.Option$None(),
    status.method,
    status.action ? $option.Option$Some(status.action) : $option.Option$None(),
  )
}

function convertCrossOrigin(crossOrigin) {
  if (!crossOrigin) return
  if ($dom.CrossOrigin$isAnonymous(crossOrigin)) return "anonymous"
  if ($dom.CrossOrigin$isUseCredentials(crossOrigin)) return "use-credentials"
}

function convertFetchPriority(fetchPriority) {
  if (!fetchPriority) return
  if ($dom.FetchPriority$isAuto(fetchPriority)) return "auto"
  if ($dom.FetchPriority$isHigh(fetchPriority)) return "high"
  if ($dom.FetchPriority$isLow(fetchPriority)) return "low"
}

function convertReferrerPolicy(referrerPolicy) {
  if (!referrerPolicy) return
  if ($dom.ReferrerPolicy$isNoReferrerWhenDowngrade(referrerPolicy))
    return "no-referrer-when-downgrade"
  if ($dom.ReferrerPolicy$isNoReferrer(referrerPolicy)) return "no-referrer"
  if ($dom.ReferrerPolicy$isOrigin(referrerPolicy)) return "origin"
  if ($dom.ReferrerPolicy$isOriginWhenCrossOrigin(referrerPolicy))
    return "origin-when-cross-origin"
  if ($dom.ReferrerPolicy$isUnsafeUrl(referrerPolicy)) return "unsafe-url"
}

function convertResource(resource) {
  if ($dom.Resource$isAudio(resource)) return "audio"
  if ($dom.Resource$isDocument(resource)) return "document"
  if ($dom.Resource$isEmbed(resource)) return "embed"
  if ($dom.Resource$isFetch(resource)) return "fetch"
  if ($dom.Resource$isFont(resource)) return "font"
  if ($dom.Resource$isImage(resource)) return "image"
  if ($dom.Resource$isObject(resource)) return "object"
  if ($dom.Resource$isScript(resource)) return "script"
  if ($dom.Resource$isStyle(resource)) return "style"
  if ($dom.Resource$isTrack(resource)) return "track"
  if ($dom.Resource$isVideo(resource)) return "video"
  if ($dom.Resource$isWorker(resource)) return "worker"
}
