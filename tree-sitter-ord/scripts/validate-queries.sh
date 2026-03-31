#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "${script_dir}/.." && pwd)"
sample_file="${repo_dir}/test/fixtures/query-sample.ord"

cd "${repo_dir}"

queries=(
  "queries/highlights.scm"
  "queries/highlights-emacs.scm"
  "queries/tags.scm"
  "queries/folds.scm"
  "queries/locals.scm"
)

for query_file in "${queries[@]}"; do
  echo "Validating ${query_file}"
  tree-sitter query "${query_file}" "${sample_file}" >/dev/null
done
