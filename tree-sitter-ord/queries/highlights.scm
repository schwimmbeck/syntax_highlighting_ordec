; SPDX-FileCopyrightText: 2016 Max Brunsfeld
; SPDX-FileCopyrightText: 2026 ORDeC contributors
; SPDX-License-Identifier: MIT AND Apache-2.0

; Generic tree-sitter highlighting for ORD.
; This keeps Python-like highlighting as the base and adds ORD-specific nodes.

; ORD declarations and headers

[
  "cell"
  "viewgen"
  "path"
  "net"
  "inout"
  "input"
  "output"
  "port"
] @keyword

(cell_definition
  name: (identifier) @type)

(viewgen_definition
  name: (identifier) @function)

(viewgen_definition
  return_type: (type (identifier) @type))

(context_definition
  kind: (type (identifier) @type)
  target: (context_target (identifier) @variable))

(path_net_statement
  name: (identifier) @variable)

; ORD member / parameter access and inline statements

(ord_local_attribute
  "." @punctuation.special
  attribute: (identifier) @property)

(ord_parameter_access
  "." @punctuation.special
  "$" @operator
  attribute: (identifier) @property)

((ord_parameter_access) @property
 (#match? @property "\\$[A-Za-z_][A-Za-z0-9_]*"))

(ord_connection_statement
  "--" @operator)

((ord_connection_statement) @operator
 (#match? @operator "--"))

; Python-like identifier conventions

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z_]*$"))

((identifier) @type
 (#match? @type "^[A-Z]"))

(identifier) @variable

; Functions, calls, decorators

(decorator) @function
(decorator
  (identifier) @function)

(function_definition
  name: (identifier) @function)

(call
  function: (attribute attribute: (identifier) @function.method))

(call
  function: (identifier) @function)

((call
  function: (identifier) @function.builtin)
 (#match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

(attribute
  attribute: (identifier) @property)

(type
  (identifier) @type)

; Literals

[
  (none)
  (true)
  (false)
] @constant.builtin

[
  (integer)
  (float)
] @number

(comment) @comment
(string) @string
(escape_sequence) @escape

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

; Operators and keywords

[
  "--"
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "&="
  "%"
  "%="
  "^"
  "^="
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<<="
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  ">>="
  "|"
  "|="
  "~"
  "@="
  "and"
  "in"
  "is"
  "not"
  "or"
  "is not"
  "not in"
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
] @keyword
