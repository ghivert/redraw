//// A Redraw project to lint: the sources of its own modules, which are
//// linted, and the sources of the modules of its dependencies, which are
//// only parsed when a type or a function of theirs must be resolved.
////
//// Every source is read once, up front, so that the analysis itself is
//// synchronous: `gleam.toml` gives the package name, `manifest.toml` lists
//// the dependencies, found under `build/packages` for Hex packages and at
//// their path for path dependencies.

import gleam/dict.{type Dict}
import gleam/javascript/promise.{type Promise}
import gleam/list
import gleam/result
import gleam/string
import redraw_lint/fs
import tom

pub type Project {
  Project(
    /// Name of the root package.
    name: String,
    /// Source directory of the root package, absolute when loaded from disk.
    src: String,
    /// Every module known to the project, by module name.
    modules: Dict(String, Source),
  )
}

pub type Source {
  Source(package: String, path: String, content: String)
}

pub type Error {
  MissingFile(path: String, reason: String)
  InvalidToml(path: String)
  MissingField(path: String, field: String)
}

/// Loads the project at `root`, a directory containing `gleam.toml` and
/// `manifest.toml`. Dependencies listed in the manifest but absent from
/// `build/packages` are skipped: their types are then left unchecked.
pub fn load(root: String) -> Promise(Result(Project, Error)) {
  let root = fs.resolve(root)
  let toml_path = join(root, "gleam.toml")
  use toml <- promise.try_await(read_toml(toml_path))
  let name = tom.get_string(toml, ["name"])
  use name <- result_try(result.replace_error(
    name,
    MissingField(toml_path, "name"),
  ))
  let manifest_path = join(root, "manifest.toml")
  use manifest <- promise.try_await(read_toml(manifest_path))
  let packages =
    tom.get_array(manifest, ["packages"])
    |> result.unwrap([])
    |> list.filter_map(fn(package) {
      use package <- result.try(tom.as_table(package))
      use package_name <- result.try(tom.get_string(package, ["name"]))
      let source = tom.get_string(package, ["source"])
      let path = tom.get_string(package, ["path"])
      case source, path {
        Ok("local"), Ok(path) ->
          Ok(#(package_name, fs.resolve(join(join(root, path), "src"))))
        _, _ ->
          Ok(#(
            package_name,
            join(root, "build/packages/" <> package_name <> "/src"),
          ))
      }
    })
  from_directories(name, join(root, "src"), packages)
}

/// Builds a project from a source directory and the source directories of
/// its dependencies, given as `#(package_name, directory)` pairs. Missing
/// directories are skipped.
pub fn from_directories(
  name: String,
  src: String,
  packages: List(#(String, String)),
) -> Promise(Result(Project, Error)) {
  let src = fs.resolve(src)
  use root_modules <- promise.try_await(read_package(name, src))
  use dependencies <- promise.await(
    list.map(packages, fn(package) {
      let directory = fs.resolve(package.1)
      use exists <- promise.await(fs.is_directory(directory))
      case exists {
        False -> promise.resolve(Ok([]))
        True -> read_package(package.0, directory)
      }
    })
    |> promise.await_list,
  )
  use dependencies <- result_try(result.all(dependencies))
  let modules =
    list.flatten([root_modules, ..dependencies])
    |> dict.from_list
  promise.resolve(Ok(Project(name:, src:, modules:)))
}

/// Builds a project from in-memory sources, as `#(module_name, source)`
/// pairs, for the root package and for the dependencies.
pub fn from_sources(
  name: String,
  modules: List(#(String, String)),
  packages: List(#(String, List(#(String, String)))),
) -> Project {
  let sources =
    list.flat_map([#(name, modules), ..packages], fn(package) {
      use #(module, content) <- list.map(package.1)
      #(module, Source(package: package.0, path: module <> ".gleam", content:))
    })
  Project(name:, src: "", modules: dict.from_list(sources))
}

/// Names of the modules of the root package, sorted.
pub fn root_modules(project: Project) -> List(String) {
  project.modules
  |> dict.to_list
  |> list.filter_map(fn(entry) {
    case { entry.1 }.package == project.name {
      True -> Ok(entry.0)
      False -> Error(Nil)
    }
  })
  |> list.sort(string.compare)
}

/// Whether the project at `root` lists `package` in its dependencies or dev
/// dependencies.
pub fn depends_on(root: String, package: String) -> Promise(Bool) {
  use toml <- promise.map(read_toml(join(root, "gleam.toml")))
  case toml {
    Error(_) -> False
    Ok(toml) ->
      list.any(
        ["dependencies", "dev-dependencies", "dev_dependencies"],
        fn(key) {
          case tom.get_table(toml, [key]) {
            Ok(table) -> dict.has_key(table, package)
            Error(_) -> False
          }
        },
      )
  }
}

/// Replaces the source of the module at `path`, as an editor buffer would.
/// A file of the root source directory unknown to the project, like a new
/// module, is added to it. Other files are ignored.
pub fn update_file(project: Project, path: String, content: String) -> Project {
  let existing =
    dict.to_list(project.modules)
    |> list.find(fn(entry) { { entry.1 }.path == path })
  case existing {
    Ok(#(module, source)) -> {
      let modules =
        dict.insert(project.modules, module, Source(..source, content:))
      Project(..project, modules:)
    }
    Error(Nil) ->
      case module_name(project, path) {
        Ok(module) -> {
          let source = Source(package: project.name, path:, content:)
          Project(
            ..project,
            modules: dict.insert(project.modules, module, source),
          )
        }
        Error(Nil) -> project
      }
  }
}

/// Whether the file at `path` is one of the sources of the project, of the
/// root package or of a dependency.
pub fn has_file(project: Project, path: String) -> Bool {
  dict.values(project.modules) |> list.any(fn(source) { source.path == path })
}

/// Name of the module of the root package at `path`.
pub fn module_name(project: Project, path: String) -> Result(String, Nil) {
  let prefix = project.src <> "/"
  case
    project.src != ""
    && string.starts_with(path, prefix)
    && string.ends_with(path, ".gleam")
  {
    True ->
      path
      |> string.drop_start(string.length(prefix))
      |> string.drop_end(string.length(".gleam"))
      |> Ok
    False -> Error(Nil)
  }
}

fn read_package(
  package: String,
  src: String,
) -> Promise(Result(List(#(String, Source)), Error)) {
  use files <- promise.try_await(
    fs.list_files(src)
    |> promise.map(result.map_error(_, MissingFile(src, _))),
  )
  files
  |> list.filter(string.ends_with(_, ".gleam"))
  |> list.map(fn(file) {
    let path = join(src, file)
    use content <- promise.map(fs.read_file(path))
    use content <- result.map(result.map_error(content, MissingFile(path, _)))
    let module = string.drop_end(file, string.length(".gleam"))
    #(module, Source(package:, path:, content:))
  })
  |> promise.await_list
  |> promise.map(result.all)
}

fn read_toml(path: String) -> Promise(Result(Dict(String, tom.Toml), Error)) {
  use content <- promise.map(fs.read_file(path))
  use content <- result.try(result.map_error(content, MissingFile(path, _)))
  tom.parse(content) |> result.replace_error(InvalidToml(path))
}

fn result_try(
  value: Result(a, e),
  next: fn(a) -> Promise(Result(b, e)),
) -> Promise(Result(b, e)) {
  case value {
    Ok(value) -> next(value)
    Error(error) -> promise.resolve(Error(error))
  }
}

fn join(directory: String, path: String) -> String {
  case string.ends_with(directory, "/"), string.starts_with(path, "/") {
    _, True -> path
    True, False -> directory <> path
    False, False -> directory <> "/" <> path
  }
}

pub fn describe_error(error: Error) -> String {
  case error {
    MissingFile(path, reason) -> "Cannot read " <> path <> ": " <> reason
    InvalidToml(path) -> "Cannot parse " <> path
    MissingField(path, field) -> path <> " has no `" <> field <> "` field"
  }
}
