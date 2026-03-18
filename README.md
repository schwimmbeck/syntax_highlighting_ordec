# syntax_highlighting_ordec

Shared syntax-highlighting and grammar repository for the ORD language.

ORD is used by ORDeC and is syntactically close to Python, but it adds its own
language constructs such as:

- `cell` declarations
- `viewgen` declarations
- context headers like `output y:` or `Inv i1:`
- `path` and `net` statements
- inline member assignments like `.align = East`
- connection statements like `.y -- out`

Because different editors support syntax in different ways, this repository
contains multiple implementations of ORD highlighting.

## Repository Layout

- [sublime](/home/dominik/Work/workspace/syntax_highlighting_ordec/sublime):
  Sublime Text syntax extending Python syntax
- [pycharm](/home/dominik/Work/workspace/syntax_highlighting_ordec/pycharm):
  JetBrains TextMate bundle
- [vscode](/home/dominik/Work/workspace/syntax_highlighting_ordec/vscode):
  VS Code extension assets
- [tree-sitter-ord](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord):
  ORD tree-sitter grammar and queries
- `vendor/tree-sitter-python/`:
  upstream Python tree-sitter grammar used by the Emacs integration

## Which Integration Should You Use?

- Sublime Text:
  use the Sublime syntax definition in `sublime/`
- JetBrains IDEs:
  use the TextMate bundle in `pycharm/`
- VS Code:
  use the extension in `vscode/ord/`
- Emacs with tree-sitter:
  use `tree-sitter-ord/` and the `IDEmacs` repository

## Editor Support Overview

### Sublime Text

Implementation style:

- extends Sublime's built-in Python syntax
- adds ORD-specific regex-based contexts

Pros:

- easy to install
- good highlighting for editing
- strong Python baseline because it reuses Sublime's Python support

See:

- [sublime/README.md](/home/dominik/Work/workspace/syntax_highlighting_ordec/sublime/README.md)

### JetBrains / PyCharm

Implementation style:

- uses a TextMate bundle
- compatible with PyCharm and other JetBrains IDEs with TextMate support

Pros:

- simple installation
- works across multiple JetBrains IDEs

See:

- [pycharm/README.md](/home/dominik/Work/workspace/syntax_highlighting_ordec/pycharm/README.md)

### VS Code

Implementation style:

- TextMate grammar packaged as a VS Code extension
- includes language configuration and an optional theme

Pros:

- standard VS Code workflow
- can be packaged as `.vsix`

See:

- [vscode/ord/README.md](/home/dominik/Work/workspace/syntax_highlighting_ordec/vscode/ord/README.md)

### tree-sitter / Emacs

Implementation style:

- a real ORD parser derived from Python grammar
- Emacs-specific queries layered on top
- local Python tree-sitter grammar vendored for proper Python highlighting

Pros:

- best long-term foundation for structural editor support
- enables proper parsing instead of regex-only highlighting
- suitable for future navigation, folding, imenu, and language-aware features

See:

- [tree-sitter-ord/README.md](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/README.md)
- [IDEmacs](/home/dominik/Work/workspace/IDEmacs)

## External Setup

### Clone This Repository

```bash
git clone <your-remote-url> syntax_highlighting_ordec
cd syntax_highlighting_ordec
```

### Initialize Submodules

If you use the Emacs/tree-sitter setup, initialize submodules too:

```bash
git submodule update --init --recursive
```

This is currently needed for:

- `vendor/tree-sitter-python`

## Emacs / tree-sitter Setup

If you want ORD support in Emacs, use this repository together with:

- [IDEmacs](/home/dominik/Work/workspace/IDEmacs)

Build the parser libraries:

ORD:

```bash
cd /path/to/syntax_highlighting_ordec/tree-sitter-ord
tree-sitter generate
cc -fPIC -I./src -c src/parser.c src/scanner.c
cc -shared -o libtree-sitter-ord.so parser.o scanner.o
```

Python:

```bash
cd /path/to/syntax_highlighting_ordec/vendor/tree-sitter-python
tree-sitter generate
cc -fPIC -I./src -c src/parser.c src/scanner.c
cc -shared -o libtree-sitter-python.so parser.o scanner.o
```

Then configure Emacs to load those grammar directories. The companion
`IDEmacs` repository already contains the needed Emacs-side wiring.

## Design Notes

The implementations are intentionally different:

- Sublime / JetBrains / VS Code are scope-based and regex/TextMate-oriented
- tree-sitter is parser-based and structural

This repository does not force one universal representation because editor
capabilities differ. The goal is consistency of language coverage, not
identical internal implementation.
