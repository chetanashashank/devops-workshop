#!/usr/bin/env bash
set -euo pipefail

ARTIFACT="build/site/index.html"
DESTINATION="deployed"

if [[ ! -f "$ARTIFACT" ]]; then
  printf 'Deploy failed: build and test the website first.\n' >&2
  exit 1
fi

mkdir -p "$DESTINATION"
cp "$ARTIFACT" "$DESTINATION/index.html"
printf 'Demo deployment complete: %s/index.html\n' "$DESTINATION"
