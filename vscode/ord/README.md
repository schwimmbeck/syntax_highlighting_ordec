<!--
SPDX-FileCopyrightText: 2026 ORDeC contributors
SPDX-License-Identifier: Apache-2.0
-->

# ORD Language Support for VS Code

VS Code extension assets for `.ord` files.

This integration currently provides two layers:

- TextMate-based highlighting and language configuration
- a lightweight VS Code language-client scaffold for an external `ordec-lsp`

The highlighting layer works on its own. The language-client layer is intended
to connect to a future `ordec-lsp` binary once it is available.

## What It Provides

- syntax highlighting for `.ord` files
- ORD-specific token scopes for declarations and inline constructs
- file association for the `.ord` extension
- language configuration
- VS Code commands for restarting the ORD language server and opening its output
- settings for launching an external `ordec-lsp`
- an optional ORD-specific dark theme

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

## Theme

The extension includes an optional ORD-specific dark theme.

To enable it:

1. open the command palette
2. run `Preferences: Color Theme`
3. select the ORD theme

## Notes

- The shipped highlighting remains TextMate/scope based.
- The language-client scaffold does not bundle the language server itself.
- `ord.tmLanguage.json` is a thin ORDeC wrapper around `source.python`.
- `ord-injection.tmLanguage.json` carries ORD-specific rules adapted from the
  JetBrains/MagicPython-derived TextMate grammar in this repository.
- The client is designed to launch an external `ordec-lsp` over stdio.
- `LICENSE.md`, `LICENSE-MIT`, and `LICENSE-APACHE` document the package's
  redistribution obligations.
- If you want structural parsing or tree-sitter-based editor support, use the
  tree-sitter implementation instead.

## Language Server Settings

The extension contributes the following settings:

- `ord.languageServer.enabled`
- `ord.languageServer.command`
- `ord.languageServer.args`
- `ord.languageServer.cwd`
- `ord.languageServer.env`
- `ord.languageServer.trace.server`

`ord.languageServer.command`, `args`, and `cwd` support
`${workspaceFolder}` and `${extensionPath}` placeholders.
