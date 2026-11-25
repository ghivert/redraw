//// Asynchronous file system access, through `node:fs/promises`.

import gleam/javascript/promise.{type Promise}

@external(javascript, "./fs.ffi.mjs", "readFile")
pub fn read_file(path: String) -> Promise(Result(String, String))

/// Lists the files under a directory, recursively, as paths relative to it.
@external(javascript, "./fs.ffi.mjs", "listFiles")
pub fn list_files(directory: String) -> Promise(Result(List(String), String))

@external(javascript, "./fs.ffi.mjs", "isDirectory")
pub fn is_directory(path: String) -> Promise(Bool)

@external(javascript, "./fs.ffi.mjs", "cwd")
pub fn cwd() -> String

@external(javascript, "./fs.ffi.mjs", "exit")
pub fn exit(code: Int) -> Nil

/// The absolute, normalized form of a path.
@external(javascript, "./fs.ffi.mjs", "resolve")
pub fn resolve(path: String) -> String

/// The closest directory containing `gleam.toml`, from the directory of
/// `path` upwards.
@external(javascript, "./fs.ffi.mjs", "findProjectRoot")
pub fn find_project_root(path: String) -> Promise(Result(String, Nil))
