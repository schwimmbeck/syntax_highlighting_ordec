<!--
SPDX-FileCopyrightText: 2026 ORDeC contributors
SPDX-License-Identifier: Apache-2.0
-->

# Licensing

This extension package contains a mix of ORDeC-authored Apache-2.0 files and
files that remain subject to upstream MIT notices:

- `syntaxes/ord.tmLanguage.json` is an ORDeC-authored wrapper that delegates to
  `source.python` at runtime.
- `syntaxes/ord-injection.tmLanguage.json` reuses ORD-specific rules from the
  JetBrains TextMate grammar in this repository. That grammar is adapted from
  the MIT-licensed MagicPython Python grammar.
- several scaffold files in this extension folder originate from the
  MIT-licensed VS Code extension generator and VS Code samples.
- `themes/ord-color-theme.json` is a Dark+-style theme variant and keeps the
  upstream MIT notice alongside the Apache-2.0 notice for ORDeC changes.

For redistribution:

- see `LICENSE-APACHE` for ORDeC-authored Apache-2.0 material
- see `LICENSE-MIT` for the bundled MIT notices that still apply inside this
  extension package
