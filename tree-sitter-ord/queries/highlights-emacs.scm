; Emacs tree-sitter query for ORD.
; Emacs expects captures to be face names, not generic highlight names.

(cell_definition
  "cell" @font-lock-keyword-face
  name: (identifier) @font-lock-type-face)

(viewgen_definition
  "viewgen" @font-lock-keyword-face
  name: (identifier) @font-lock-function-name-face)

(viewgen_definition
  return_type: (type (identifier) @font-lock-type-face))

(context_definition
  kind: [
    "inout"
    "input"
    "output"
    "port"
  ] @font-lock-keyword-face)

(context_definition
  kind: (type (identifier) @font-lock-type-face)
  target: (context_target (identifier) @font-lock-variable-name-face))

(path_net_statement
  [
    "path"
    "net"
  ] @font-lock-keyword-face
  name: (identifier) @font-lock-variable-name-face)

(ord_member_assignment
  left: (ord_local_attribute
          "." @font-lock-keyword-face
          attribute: (identifier) @font-lock-variable-name-face))

(ord_member_assignment
  left: (ord_parameter_access
          "." @font-lock-keyword-face
          "$" @font-lock-keyword-face
          attribute: (identifier) @font-lock-variable-name-face))

(ord_connection_statement
  left: (ord_local_attribute
          "." @font-lock-keyword-face
          attribute: (identifier) @font-lock-variable-name-face)
  "--" @font-lock-keyword-face)

(ord_connection_statement
  left: (ord_parameter_access
          "." @font-lock-keyword-face
          "$" @font-lock-keyword-face
          attribute: (identifier) @font-lock-variable-name-face)
  "--" @font-lock-keyword-face)

(identifier) @font-lock-variable-name-face

((identifier) @font-lock-type-face
 (#match "^[A-Z]" @font-lock-type-face))

((identifier) @font-lock-constant-face
 (#match "^[A-Z][A-Z_]*$" @font-lock-constant-face))

(decorator) @font-lock-preprocessor-face
(decorator
  (identifier) @font-lock-function-name-face)

(call
  function: (attribute attribute: (identifier) @font-lock-function-name-face))
(call
  function: (identifier) @font-lock-function-name-face)

((call
  function: (identifier) @font-lock-builtin-face)
 (#match
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"
   @font-lock-builtin-face))

(function_definition
  name: (identifier) @font-lock-function-name-face)

(attribute attribute: (identifier) @font-lock-property-use-face)
(type (identifier) @font-lock-type-face)

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

[
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
