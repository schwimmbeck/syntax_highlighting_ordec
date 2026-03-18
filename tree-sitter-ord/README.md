# tree-sitter-ord

tree-sitter grammar for the ORD language.

Unlike the TextMate/Sublime integrations in this repository, this folder
contains a real parser. It is intended for tree-sitter-based editors and is
currently used most directly by the Emacs integration in `IDEmacs`.

## Design

ORD is Python-derived, but it is not just Python with a few colored keywords.
It introduces grammar-level constructs such as:

- `cell`
- `viewgen`
- context definitions like `output y:` and `Inv i1:`
- `path` / `net`
- inline statements like `.align = East`
- connection statements like `.y -- out`

Because of that, this grammar is implemented as:

- a Python-derived grammar base
- ORD-specific productions where the language diverges
- query files layered on top for highlighting

## Important Files

- [grammar.js](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/grammar.js):
  grammar source
- [src/parser.c](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/src/parser.c):
  generated parser
- [src/node-types.json](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/src/node-types.json):
  generated node definitions
- [queries/highlights.scm](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/queries/highlights.scm):
  generic highlight query
- [queries/highlights-emacs.scm](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/queries/highlights-emacs.scm):
  Emacs-specific highlight query
- [queries/tags.scm](/home/dominik/Work/workspace/syntax_highlighting_ordec/tree-sitter-ord/queries/tags.scm):
  tags query

## Build

Generate parser artifacts:

```bash
tree-sitter generate
```

Build the shared library used by Emacs:

```bash
cc -fPIC -I./src -c src/parser.c src/scanner.c
cc -shared -o libtree-sitter-ord.so parser.o scanner.o
```

## Validation

Parse a sample file:

```bash
tree-sitter parse /path/to/file.ord
```

## Emacs Usage

This grammar is intended to be consumed together with:

- `vendor/tree-sitter-python`
- the Emacs configuration in `IDEmacs`

That setup allows Emacs to:

- use Python tree-sitter highlighting as the base
- add ORD-specific highlighting and syntax on top

## References

- [tree-sitter](https://github.com/tree-sitter/tree-sitter)
- [Python 3 grammar](https://docs.python.org/3/reference/grammar.html)
