<!--
SPDX-FileCopyrightText: 2026 ORDeC contributors
SPDX-License-Identifier: Apache-2.0
-->

# ORD Language Support for PyCharm / JetBrains IDEs

JetBrains IDE support for `.ord` files using a TextMate bundle.

This integration is intended for PyCharm and other JetBrains IDEs that support
TextMate bundles. It provides syntax highlighting for ORD without requiring a
custom JetBrains plugin.

## What It Highlights

- `cell` declarations
- `viewgen` declarations
- `path` and `net` declarations
- context headers like `output y:` and `Inv i1:`
- connection operator `--`
- constrain operator `!`
- parameter access like `.$param`
- dotted ORD member access
- SI unit suffixes and rational numbers
- Python syntax inside ORD files

## Files

- [ord.tmbundle](./ord.tmbundle)

## Supported IDEs

Any JetBrains IDE with TextMate bundle support, including:

- PyCharm
- IntelliJ IDEA
- CLion
- WebStorm
- GoLand

## Installation

1. Open your JetBrains IDE.
2. Open settings:
   - Linux/Windows: `Ctrl+Alt+S`
   - macOS: `Cmd+,`
3. Go to `Editor > TextMate Bundles`.
4. Click `+`.
5. Select the `ord.tmbundle` directory inside this repository.
6. Apply the changes.
7. Reopen the `.ord` file if needed.

Important:

- select `pycharm/ord.tmbundle`
- do not select the parent `pycharm/` directory

## Verification

Open a `.ord` file. You should see TextMate-based highlighting applied.

If the file is not recognized automatically:

1. open the file
2. use `Associate with File Type` if prompted
3. or check TextMate bundle settings again

## Notes

- This is a TextMate-based solution, not a parser plugin.
- The final colors depend on your active JetBrains color scheme.
- If you want structural parsing rather than just syntax highlighting, use the
  tree-sitter / Emacs path instead.

## Licensing

- `ord.tmbundle/Syntaxes/ord.tmLanguage.json` is adapted from the
  MIT-licensed MagicPython Python grammar.
- `ord.tmbundle/LICENSE-MIT` and `ord.tmbundle/LICENSE-APACHE` carry the
  redistribution notices for the bundle itself.
