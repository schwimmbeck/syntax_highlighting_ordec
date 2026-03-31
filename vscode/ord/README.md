<!--
SPDX-FileCopyrightText: 2026 ORDeC contributors
SPDX-License-Identifier: Apache-2.0
-->

# ORD Language Support for VS Code

VS Code extension assets for `.ord` files.

This integration currently provides three layers:

- TextMate-based highlighting and language configuration
- a VS Code language client for an external `ordec-lsp`
- a local-viewer bridge for launching ORDeC on the active `.ord` file

The highlighting layer works on its own. The language-client layer connects to
an external `ordec-lsp` binary when one is available.

## What It Provides

- syntax highlighting for `.ord` files
- ORD-specific token scopes for declarations and inline constructs
- file association for the `.ord` extension
- language configuration
- VS Code commands for restarting the ORD language server and opening its output
- VS Code commands for launching and stopping an ORDeC local viewer for the active file
- VS Code command for opening the current ORD view at the cursor in ORDeC
- settings for launching an external `ordec-lsp`
- settings for launching the ORDeC local viewer process
- an optional ORD-specific dark theme

When `ordec-lsp` is available, the extension can surface diagnostics, document
symbols, document highlights, definition, hover, references, completions,
rename, workspace symbols, folding ranges, selection ranges, and semantic
tokens through the language server.

## What It Highlights

- `cell` declarations
- `viewgen` declarations
- `path` and `net` declarations
- context headers like `output y:` and `Inv i1:`
- connection operator `--`
- constrain operator `!`
- parameter access like `.$param`
- SI unit suffixes and rational numbers
- Python syntax inside ORD files

## Repository Layout

Key files in this extension folder:

- `package.json`
- `language-configuration.json`
- `syntaxes/ord.tmLanguage.json`
- `syntaxes/ord-injection.tmLanguage.json`
- `themes/ord-color-theme.json`

## Installation

### Option 1: Package As VSIX

From `vscode/ord/`:

```bash
npm install
npx @vscode/vsce package
code --install-extension *.vsix
```

If you also want language-server features, make sure an `ordec-lsp` command is
available on your `PATH`, or configure the launch command through the extension
settings.

If you also want the viewer bridge, make sure an `ordec` command is available
on your `PATH`, or configure the viewer command through the extension settings.

### Option 2: Development Mode

1. Open `vscode/ord/` in VS Code.
2. Press `F5`.
3. A new Extension Development Host window will open.
4. Open a `.ord` file in that window.

### Option 3: Manual Local Installation

Copy the extension folder into your VS Code extensions directory.

- Linux: `~/.vscode/extensions/ord/`
- macOS: `~/.vscode/extensions/ord/`
- Windows: `%USERPROFILE%\\.vscode\\extensions\\ord\\`

Then restart VS Code.

## Runtime Setup

### Regular ORDeC Installation

For a normal packaged ORDeC installation, the extension should usually work with
minimal configuration:

- install ORDeC so that `ordec-lsp` and `ordec` are on your `PATH`
- set `ord.viewer.moduleRoot` to the root directory of your ORD project
- optionally set `ord.viewer.cwd` if ORDeC should start from a different working
  directory than the workspace root

In this setup, the default command settings are typically sufficient:

- `ord.languageServer.command = "ordec-lsp"`
- `ord.viewer.command = "ordec"`

### Editable / Source Checkout ORDeC Installation

If ORDeC is installed from a source checkout in editable mode, you will usually
need explicit command paths and viewer arguments.

Example settings:

```json
{
  "ord.languageServer.command": "/path/to/ordec/.venv/bin/ordec-lsp",
  "ord.languageServer.args": [],
  "ord.languageServer.cwd": "/path/to/ordec",
  "ord.viewer.command": "/path/to/ordec/.venv/bin/ordec",
  "ord.viewer.args": [
    "-r",
    "/path/to/ordec/web/dist"
  ],
  "ord.viewer.env": {
    "PYTHONUNBUFFERED": "1"
  }
}
```

Notes for editable installs:

- `ordec` may need `-r /path/to/ordec/web/dist` because `webdist.tar` is not
  bundled in editable mode
- `PYTHONUNBUFFERED=1` can help the viewer bridge see ORDeC's printed launch URL
  immediately
- `ord.languageServer.trace.server = "messages"` is useful for debugging, but is
  not part of normal setup

## Theme

The extension includes an optional ORD-specific dark theme.

To enable it:

1. open the command palette
2. run `Preferences: Color Theme`
3. select the ORD theme

## Notes

- The shipped highlighting remains TextMate/scope based.
- The extension does not bundle the language server itself.
- `ord.tmLanguage.json` is a thin ORDeC wrapper around `source.python`.
- `ord-injection.tmLanguage.json` carries ORD-specific rules adapted from the
  JetBrains/MagicPython-derived TextMate grammar in this repository.
- The client is designed to launch an external `ordec-lsp` over stdio.
- The viewer bridge launches `ordec --no-browser --module ...`, reads the signed
  local-mode URL from stdout, and opens it in your browser.
- `ORD: Open Current View in ORDeC Viewer` derives view names like
  `Inv().schematic` or `Amp().layout` from the current cursor position.
- The active `.ord` file is saved before launching the viewer, because ORDeC
  local mode reads from the file system.
- The active file must live under `ord.viewer.moduleRoot`, and its relative path
  must map cleanly to a Python-style import path such as `ord2.nmux`.
- `LICENSE.md`, `LICENSE-MIT`, and `LICENSE-APACHE` document the package's
  redistribution obligations.
- If you want structural parsing or tree-sitter-based editor support, use the
  tree-sitter implementation instead.

## Troubleshooting

- `spawn ordec-lsp ENOENT`
  Configure `ord.languageServer.command` to the absolute path of `ordec-lsp`.

- `webdist.tar not found`
  In editable ORDeC installs, add `-r /path/to/ordec/web/dist` through
  `ord.viewer.args`.

- Viewer process starts but no browser opens
  Set `ord.viewer.env.PYTHONUNBUFFERED = "1"` so the extension can read the
  printed launch URL without waiting for buffered stdout.

- Need to inspect raw LSP traffic
  Temporarily set `ord.languageServer.trace.server = "messages"` or `"verbose"`.

## Language Server Settings

The extension contributes the following settings:

- `ord.languageServer.enabled`
- `ord.languageServer.command`
- `ord.languageServer.args`
- `ord.languageServer.cwd`
- `ord.languageServer.env`
- `ord.languageServer.trace.server`
- `ord.viewer.command`
- `ord.viewer.args`
- `ord.viewer.cwd`
- `ord.viewer.moduleRoot`
- `ord.viewer.env`
- `ord.viewer.hostname`
- `ord.viewer.port`
- `ord.viewer.urlAuthority`

`ord.languageServer.command`, `args`, and `cwd` support
`${workspaceFolder}` and `${extensionPath}` placeholders.

The viewer settings also support `${workspaceFolder}`, `${extensionPath}`,
`${file}`, `${fileDirname}`, `${fileBasename}`, and
`${fileBasenameNoExtension}` placeholders.

## Viewer Commands

- `ORD: Open Active File in ORDeC Viewer`
- `ORD: Open Current View in ORDeC Viewer`
- `ORD: Stop ORDeC Viewer`
- `ORD: Show ORDeC Viewer Output`
