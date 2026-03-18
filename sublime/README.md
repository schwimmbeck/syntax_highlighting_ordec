# ORD Language Support for Sublime Text

Sublime Text syntax highlighting for `.ord` files.

This implementation extends Sublime Text's built-in Python syntax and adds
ORD-specific rules on top. That makes it a good fit for a language like ORD,
which is Python-like but adds its own declarations and inline operators.

## What It Highlights

- `cell` declarations
- `viewgen` declarations
- `path` and `net` declarations
- context headers like `output y:` and `Nmos m1:`
- connection operator `--`
- constrain operator `!`
- parameter access like `.$param`
- dotted context access like `.name`
- SI unit suffixes like `100n`, `3.14u`, `1M`
- rational numbers like `1/3`
- normal Python syntax inside ORD files

## Files

- [Ord.sublime-syntax](/home/dominik/Work/workspace/syntax_highlighting_ordec/sublime/Ord.sublime-syntax)

## Installation

### Option 1: Install As A User Syntax

Copy `Ord.sublime-syntax` into your Sublime Text `Packages/User/` directory.

- Linux: `~/.config/sublime-text/Packages/User/`
- macOS: `~/Library/Application Support/Sublime Text/Packages/User/`
- Windows: `%APPDATA%\\Sublime Text\\Packages\\User\\`

### Option 2: Install As Its Own Package

Create an `Ord/` folder in your Sublime packages directory and copy the syntax
file there.

- Linux: `~/.config/sublime-text/Packages/Ord/`
- macOS: `~/Library/Application Support/Sublime Text/Packages/Ord/`
- Windows: `%APPDATA%\\Sublime Text\\Packages\\Ord\\`

Example:

```bash
mkdir -p ~/.config/sublime-text/Packages/Ord
cp Ord.sublime-syntax ~/.config/sublime-text/Packages/Ord/
```

## Activation

Restart Sublime Text, then open a `.ord` file.

If syntax selection does not happen automatically:

1. click the syntax selector in the bottom-right corner
2. choose `Ord`

## Notes

- This version is regex/scope based, not parser based.
- It intentionally reuses Sublime's Python syntax instead of reimplementing
  all of Python.
- For structural parsing and editor-aware syntax, use the tree-sitter version
  instead.
