#!/usr/bin/env bash
set -euo pipefail

ARTIFACT="labs/L05-shell-scripting/build/site/index.html"

if [[ ! -f "$ARTIFACT" ]]; then
  printf 'Test failed: run build.sh first.\n' >&2
  exit 1
fi

if ! grep -q '<title>Workshop Demo</title>' "$ARTIFACT"; then
  printf 'Test failed: expected title was not found.\n' >&2
  exit 1
fi

printf 'Test passed: page exists and title is correct.\n'
