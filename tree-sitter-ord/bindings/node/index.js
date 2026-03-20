// SPDX-FileCopyrightText: 2016 Max Brunsfeld
// SPDX-FileCopyrightText: 2026 ORDeC contributors
// SPDX-License-Identifier: MIT AND Apache-2.0

try {
  module.exports = require("../../build/Release/tree_sitter_ord_binding");
} catch (error1) {
  if (error1.code !== 'MODULE_NOT_FOUND') {
    throw error1;
  }
  try {
    module.exports = require("../../build/Debug/tree_sitter_ord_binding");
  } catch (error2) {
    if (error2.code !== 'MODULE_NOT_FOUND') {
      throw error2;
    }
    throw error1
  }
}

try {
  module.exports.nodeTypeInfo = require("../../src/node-types.json");
} catch (_) {}
