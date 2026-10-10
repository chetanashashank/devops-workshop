#!/usr/bin/env bash
set -euo pipefail

OUTPUT_DIR="labs/L05-shell-scripting/build/site"
PAGE_TITLE="Workshop Demo"
PAGE_MESSAGE="Built by the L05 shell script."

mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/index.html" <<EOF
<!doctype html>
<html lang="en">
  <head><meta charset="utf-8"><title>${PAGE_TITLE}</title></head>
  <body><h1>${PAGE_TITLE}</h1><p>${PAGE_MESSAGE}</p></body>
</html>
EOF
printf 'Build complete: %s/index.html\n' "$OUTPUT_DIR"
