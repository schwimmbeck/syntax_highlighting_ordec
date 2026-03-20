; SPDX-FileCopyrightText: 2026 ORDeC contributors
; SPDX-License-Identifier: Apache-2.0

; Emacs-specific tree-sitter highlighting for ORD.
; Only ORD-specific constructs — Python highlighting comes from
; python--treesit-settings via the Python parser.
;
; These rules use :override t (set in ord-mode.el) so they take
; precedence over Python ERROR-node artifacts on ORD constructs.

; ORD keywords

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

; ORD declarations

(cell_definition
  name: (identifier) @font-lock-type-face)

(viewgen_definition
  name: (identifier) @font-lock-function-name-face)

(viewgen_definition
  return_type: (type (identifier) @font-lock-type-face))

(context_definition
  kind: (type (identifier) @font-lock-type-face))

(context_definition
  target: (context_target (identifier) @font-lock-variable-name-face))

(path_net_statement
  name: (identifier) @font-lock-variable-name-face)

; ORD member / parameter access and connections
; Use keyword face for ORD-specific operators (., $, --) to match
; Sublime scoping (keyword.operator.accessor / keyword.operator.connection).

(ord_local_attribute
  "." @font-lock-keyword-face
  attribute: (identifier) @font-lock-variable-name-face)

(ord_parameter_access
  "." @font-lock-keyword-face
  "$" @font-lock-keyword-face
  attribute: (identifier) @font-lock-variable-name-face)

(ord_connection_statement
  "--" @font-lock-keyword-face)
