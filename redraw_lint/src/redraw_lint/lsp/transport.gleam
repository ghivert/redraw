//// JSON-RPC over stdin and stdout, as the Language Server Protocol frames
//// it.

import gleam/javascript/promise.{type Promise}

pub type Incoming {
  Message(String)
  /// No message arrived in time.
  Timeout
  /// The client closed stdin.
  Closed
}

/// Starts listening on stdin. Messages are queued until read.
@external(javascript, "./transport.ffi.mjs", "start")
pub fn start() -> Nil

/// The next message. With a non-negative `timeout`, in milliseconds,
/// resolves to `Timeout` when no message arrives in time.
@external(javascript, "./transport.ffi.mjs", "read")
pub fn read(timeout: Int) -> Promise(Incoming)

@external(javascript, "./transport.ffi.mjs", "send")
pub fn send(message: String) -> Nil

@external(javascript, "./transport.ffi.mjs", "uriToPath")
pub fn uri_to_path(uri: String) -> Result(String, Nil)

@external(javascript, "./transport.ffi.mjs", "pathToUri")
pub fn path_to_uri(path: String) -> String
