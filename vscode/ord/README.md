<!--
SPDX-FileCopyrightText: 2026 ORDeC contributors
SPDX-License-Identifier: Apache-2.0
-->

# ORD Language Support for VS Code

VS Code extension assets for highlighting `.ord` files.

This integration is TextMate-based and is intended for users who want ORD
syntax support inside Visual Studio Code without building a language server.

## What It Provides

- syntax highlighting for `.ord` files
- ORD-specific token scopes for declarations and inline constructs
- file association for the `.ord` extension
- language configuration
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

- This extension is TextMate/scope based, not parser based.
- It is a good fit if you want straightforward highlighting in VS Code.
- `ord.tmLanguage.json` is a thin ORDeC wrapper around `source.python`.
- `ord-injection.tmLanguage.json` carries ORD-specific rules adapted from the
  JetBrains/MagicPython-derived TextMate grammar in this repository.
- `LICENSE.md`, `LICENSE-MIT`, and `LICENSE-APACHE` document the package's
  redistribution obligations.
- If you want structural parsing or tree-sitter-based editor support, use the
  tree-sitter implementation instead.
