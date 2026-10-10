#!/usr/bin/env bash
set -euo pipefail

ARTIFACT="labs/L05-shell-scripting/build/site/index.html"
DESTINATION="labs/L05-shell-scripting/deployed"

if [[ ! -f "$ARTIFACT" ]]; then
  printf 'Deploy failed: run build.sh first.\n' >&2
  exit 1
fi

mkdir -p "$DESTINATION"
cp "$ARTIFACT" "$DESTINATION/index.html"
printf 'Local deployment complete: %s/index.html\n' "$DESTINATION"
