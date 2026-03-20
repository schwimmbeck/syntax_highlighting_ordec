# SPDX-FileCopyrightText: 2016 Max Brunsfeld
# SPDX-FileCopyrightText: 2026 ORDeC contributors
# SPDX-License-Identifier: MIT AND Apache-2.0

{
  "targets": [
    {
      "target_name": "tree_sitter_ord_binding",
      "include_dirs": [
        "<!(node -e \"require('nan')\")",
        "src"
      ],
      "sources": [
        "bindings/node/binding.cc",
        "src/parser.c",
        # If your language uses an external scanner, add it here.
      ],
      "cflags_c": [
        "-std=c99",
      ]
    }
  ]
}
