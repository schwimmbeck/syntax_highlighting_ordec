# syntax_highlighting_ordec

Shared syntax-highlighting repository for the ORD language.

This repo collects editor-specific support for `.ord` files. ORD is close to
Python syntactically, but adds its own declarations and inline constructs such
as `cell`, `viewgen`, `path`, `net`, context headers, member assignments, and
connection statements.

## Repository Layout

- [sublime](/home/dominik/Work/workspace/syntax_highlighting_ordec/sublime):
  Sublime Text syntax definition extending Python syntax
- [pycharm](/home/dominik/Work/workspace/syntax_highlighting_ordec/pycharm):
  JetBrains TextMate bundle
- [vscode](/home/dominik/Work/workspace/syntax_highlighting_ordec/vscode):
  VS Code extension assets
- [tree-sitter-ord](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord):
  tree-sitter grammar and Emacs-oriented queries

## Current Status

The editor integrations are not all implemented the same way:

- Sublime extends Python syntax with ORD-specific rules
- JetBrains support is based on TextMate scopes
- VS Code support is TextMate-based
- tree-sitter support uses a dedicated ORD parser derived from Python grammar

## tree-sitter / Emacs

The tree-sitter folder currently contains:

- grammar source
- generated parser files
- highlight queries
- compiled shared library for local Emacs use

Important files:

- [grammar.js](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/grammar.js)
- [highlights-emacs.scm](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/queries/highlights-emacs.scm)
- [highlights.scm](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/queries/highlights.scm)
- [libtree-sitter-ord.so](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/libtree-sitter-ord.so)

The active Emacs config that consumes this grammar lives in:

- [IDEmacs](/home/dominik/Work/workspace/IDEmacs)

## Design Goal

The long-term goal is to keep a single ORD language model and then adapt it to
each editor with as little duplication as possible. In practice:

- TextMate-style editors reuse regex-based scopes
- tree-sitter-based editors should rely on a real ORD parser

## Regeneration

To regenerate the parser after grammar changes:

```bash
cd /home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord
tree-sitter generate
cc -fPIC -I./src -c src/parser.c src/scanner.c
cc -shared -o libtree-sitter-ord.so parser.o scanner.o
```

## Next Work

- improve Python highlighting reuse inside the ORD tree-sitter path
- reduce editor-specific duplication across Sublime, VS Code, and Emacs
- package Emacs ORD support more cleanly so less wiring is needed in `init.el`
