import { readFile as nodeReadFile, readdir, stat } from "node:fs/promises"
import { dirname, join, resolve as resolvePath } from "node:path"
import { Ok, Error, toList } from "../gleam.mjs"

export function readFile(path) {
  return nodeReadFile(path, "utf-8").then(
    (content) => new Ok(content),
    (error) => new Error(String(error.message ?? error)),
  )
}

/** Lists the files under `directory`, recursively, as paths relative to it. */
export function listFiles(directory) {
  return walk(directory, "").then(
    (files) => new Ok(toList(files)),
    (error) => new Error(String(error.message ?? error)),
  )
}

async function walk(root, prefix) {
  const entries = await readdir(join(root, prefix), { withFileTypes: true })
  const files = []
  for (const entry of entries) {
    const relative = prefix ? prefix + "/" + entry.name : entry.name
    if (entry.isDirectory()) files.push(...(await walk(root, relative)))
    else if (entry.isFile()) files.push(relative)
  }
  return files
}

export function isDirectory(path) {
  return stat(path).then(
    (info) => info.isDirectory(),
    () => false,
  )
}

export function cwd() {
  return process.cwd()
}

export function exit(code) {
  process.exit(code)
}

export function resolve(path) {
  return resolvePath(path)
}

/** Finds the closest directory containing `gleam.toml`, from the directory
 * of `path` up to the filesystem root. */
export async function findProjectRoot(path) {
  let directory = dirname(resolvePath(path))
  while (true) {
    try {
      const info = await stat(join(directory, "gleam.toml"))
      if (info.isFile()) return new Ok(directory)
    } catch {}
    const parent = dirname(directory)
    if (parent === directory) return new Error(undefined)
    directory = parent
  }
}
