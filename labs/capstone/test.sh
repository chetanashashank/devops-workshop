#!/usr/bin/env bash
set -euo pipefail

ARTIFACT="build/site/index.html"

if [[ ! -f "$ARTIFACT" ]]; then
  printf 'Test failed: build the website first.\n' >&2
  exit 1
fi

if ! grep -q '<title>Campus Pulse</title>' "$ARTIFACT"; then
  printf 'Test failed: Campus Pulse title was not found.\n' >&2
  exit 1
fi

if ! grep -q 'Release pipeline is working.' "$ARTIFACT"; then
  printf 'Test failed: release message was not found.\n' >&2
  exit 1
fi

printf 'Test passed: Campus Pulse page is ready.\n'
