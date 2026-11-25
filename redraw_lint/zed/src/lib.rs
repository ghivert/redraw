//! Starts the `redraw_lint` language server for the Gleam files of a
//! project depending on `redraw_lint`, next to the Gleam language server.
//!
//! The server comes from the project itself, as a dev dependency, so that
//! its version is the one of the project. In order:
//!
//! 1. The command set in the settings, under `lsp.redraw-lint.binary`.
//! 2. The compiled server, run with Node, when the project has been built:
//!    it starts at once, even when the project itself does not compile.
//! 3. `gleam run -m redraw_lint/lsp`, which builds the project first.

use zed_extension_api::{self as zed, settings::LspSettings, LanguageServerId, Result};

const COMPILED: &str = "build/dev/javascript/redraw_lint/redraw_lint/lsp.mjs";

struct RedrawLint;

impl zed::Extension for RedrawLint {
    fn new() -> Self {
        RedrawLint
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let env = worktree.shell_env();
        let binary = LspSettings::for_worktree(language_server_id.as_ref(), worktree)
            .ok()
            .and_then(|settings| settings.binary);
        if let Some(binary) = binary {
            if let Some(path) = binary.path {
                return Ok(zed::Command {
                    command: path,
                    args: binary.arguments.unwrap_or_default(),
                    env,
                });
            }
        }

        let manifest = worktree.read_text_file("gleam.toml").map_err(|_| {
            "redraw_lint: the folder opened in Zed has no gleam.toml. Open the Gleam project, \
             or set lsp.redraw-lint.binary in the settings."
                .to_string()
        })?;
        if !manifest.contains("redraw_lint") {
            return Err("redraw_lint: this project does not depend on redraw_lint. \
                 Run `gleam add --dev redraw_lint` to enable it."
                .to_string());
        }

        if worktree.read_text_file(COMPILED).is_ok() {
            if let Some(node) = worktree.which("node") {
                let module = file_url(&format!("{}/{}", worktree.root_path(), COMPILED));
                return Ok(zed::Command {
                    command: node,
                    args: vec![
                        "--input-type=module".to_string(),
                        "-e".to_string(),
                        format!("import {{ main }} from {module:?}; main()"),
                    ],
                    env,
                });
            }
        }

        let gleam = worktree
            .which("gleam")
            .ok_or_else(|| "redraw_lint: gleam is not in the PATH.".to_string())?;
        Ok(zed::Command {
            command: gleam,
            args: ["run", "--no-print-progress", "-m", "redraw_lint/lsp"]
                .map(String::from)
                .to_vec(),
            env,
        })
    }
}

/// A `file://` URL for an absolute path, on Unix or Windows.
fn file_url(path: &str) -> String {
    let path = path.replace('\\', "/");
    if path.starts_with('/') {
        format!("file://{path}")
    } else {
        format!("file:///{path}")
    }
}

zed::register_extension!(RedrawLint);
