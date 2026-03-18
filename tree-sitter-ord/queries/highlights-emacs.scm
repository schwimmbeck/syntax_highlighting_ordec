; Emacs-specific tree-sitter highlighting for ORD.
; This mirrors the generic query, but uses Emacs font-lock faces directly.

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
] @font-lock-keyword-face

(cell_definition
  name: (identifier) @font-lock-type-face)

(viewgen_definition
  name: (identifier) @font-lock-function-name-face)

(viewgen_definition
  return_type: (type (identifier) @font-lock-type-face))

(context_definition
  kind: (type (identifier) @font-lock-type-face)
  target: (context_target (identifier) @font-lock-variable-name-face))

(path_net_statement
  name: (identifier) @font-lock-variable-name-face)

; ORD member / parameter access and inline statements

(ord_local_attribute
  "." @font-lock-keyword-face
  attribute: (identifier) @font-lock-variable-name-face)

(ord_parameter_access
  "." @font-lock-keyword-face
  "$" @font-lock-keyword-face
  attribute: (identifier) @font-lock-variable-name-face)

((ord_parameter_access) @font-lock-variable-name-face
 (#match "\\$[[:alpha:]_][[:alnum:]_]*" @font-lock-variable-name-face))

(ord_connection_statement
  "--" @font-lock-keyword-face)

((ord_connection_statement) @font-lock-keyword-face
 (#match "--" @font-lock-keyword-face))

; Python-like identifier conventions

((identifier) @font-lock-constant-face
 (#match "^[A-Z][A-Z_]*$" @font-lock-constant-face))

((identifier) @font-lock-type-face
 (#match "^[A-Z]" @font-lock-type-face))

(identifier) @font-lock-variable-name-face

; Functions, calls, decorators

(decorator) @font-lock-preprocessor-face
(decorator
  (identifier) @font-lock-function-name-face)

(function_definition
  name: (identifier) @font-lock-function-name-face)

(call
  function: (attribute attribute: (identifier) @font-lock-function-name-face))

(call
  function: (identifier) @font-lock-function-name-face)

((call
  function: (identifier) @font-lock-builtin-face)
 (#match
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"
   @font-lock-builtin-face))

(attribute
  attribute: (identifier) @font-lock-variable-name-face)

(type
  (identifier) @font-lock-type-face)

; Literals

[
  (none)
  (true)
  (false)
] @font-lock-constant-face

[
  (integer)
  (float)
] @font-lock-constant-face

(comment) @font-lock-comment-face
(string) @font-lock-string-face
(escape_sequence) @font-lock-constant-face

(interpolation
  "{" @font-lock-keyword-face
  "}" @font-lock-keyword-face)

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
] @font-lock-keyword-face

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
] @font-lock-keyword-face
