# L05: Shell Scripting — Build, Test, and Deploy

## Learning objective

Use Bash scripts to build a simple HTML page, validate the generated file, and deploy it only after the required checks pass.

**Duration:** Approximately 30–40 minutes

## Lab structure

Run all commands from the **repository root**.

```text
labs/
└── L05-shell-scripting/
    ├── config.sh
    ├── build.sh
    ├── test.sh
    ├── deploy.sh
    ├── build/
    │   └── site/
    │       └── index.html
    └── deployed/
        └── index.html
```

The `build/` and `deployed/` directories are created when the scripts run.

## Starter files

### `config.sh`

This file contains the message that the build script inserts into the HTML page.

```bash
#!/usr/bin/env bash
PAGE_MESSAGE="Built by the L05 shell script."
```

### `build.sh`

The build script reads the configuration and generates the HTML page.

```bash
#!/usr/bin/env bash
set -euo pipefail

source labs/L05-shell-scripting/config.sh

OUTPUT_DIR="labs/L05-shell-scripting/build/site"
PAGE_TITLE="Workshop Demo"

mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/index.html" <<EOF
<!doctype html>
<html lang="en">
  <head><meta charset="utf-8"><title>${PAGE_TITLE}</title></head>
  <body><h1>${PAGE_TITLE}</h1><p>${PAGE_MESSAGE}</p></body>
</html>
EOF

printf 'Build complete: %s/index.html\n' "$OUTPUT_DIR"
```

### `test.sh` — starter version

Initially, this test checks that the generated HTML exists and contains the expected title.

```bash
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
```

### `deploy.sh` — starter version

```bash
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
```

## Student tasks

### Task 1 — Change the page message

1. Open `config.sh`.
2. Change `PAGE_MESSAGE` to a new message.
3. Run the build script:

   ```bash
   bash labs/L05-shell-scripting/build.sh
   ```

4. Inspect the generated HTML:

   ```bash
   cat labs/L05-shell-scripting/build/site/index.html
   ```

Confirm that the new message appears in the page.

### Task 2 — Add a message check to `test.sh`

Update `test.sh` so it also checks that the configured message appears in the generated HTML.

Hints:
- Source `labs/L05-shell-scripting/config.sh`.
- Use `grep -Fq "$PAGE_MESSAGE" "$ARTIFACT"`.
- Print the final success message only after all checks pass.

Run the test:

```bash
bash labs/L05-shell-scripting/test.sh
```

### Task 3 — Intentionally make the test fail

To demonstrate a failed test, change the expected title in `test.sh` from:

```bash
'<title>Workshop Demo</title>'
```

to this incorrect title:

```bash
'<title>Workshop</title>'
```

Then run:

```bash
bash labs/L05-shell-scripting/test.sh
```

Expected output:

```text
Test failed: expected title was not found.
```

This failure is intentional: the generated HTML contains `<title>Workshop Demo</title>`, not `<title>Workshop</title>`.

After demonstrating the failure, **restore** the correct expected title:

```bash
'<title>Workshop Demo</title>'
```

Do not leave the test with the incorrect title.

### Task 4 — Make deployment run the test first

Modify `deploy.sh` to run `test.sh` **after checking that the build artifact exists but before creating the deployment directory or copying the file**.

Add this command before the `mkdir -p "$DESTINATION"` line:

```bash
bash labs/L05-shell-scripting/test.sh
```

Because `deploy.sh` uses `set -euo pipefail`, a failing test causes deployment to stop before the copy command.

### Task 5 — Demonstrate deployment protection

1. Build the page.
2. Temporarily change the expected title in `test.sh` to `<title>Workshop</title>`.
3. Run `deploy.sh`.
4. Observe that the test fails and the script stops before copying the artifact.
5. Restore `<title>Workshop Demo</title>`.
6. Run the build, test, and deploy scripts again to confirm the successful workflow.

Note: this prevents a new copy from being made when the test fails. It does not automatically remove a file that was deployed during an earlier successful run.

## Answer guide

### Updated `test.sh`

This version checks the artifact, title, and configured message:

```bash
#!/usr/bin/env bash
set -euo pipefail

source labs/L05-shell-scripting/config.sh

ARTIFACT="labs/L05-shell-scripting/build/site/index.html"

if [[ ! -f "$ARTIFACT" ]]; then
    printf 'Test failed: run build.sh first.\n' >&2
    exit 1
fi

if ! grep -Fq '<title>Workshop Demo</title>' "$ARTIFACT"; then
    printf 'Test failed: expected title was not found.\n' >&2
    exit 1
fi

if ! grep -Fq "$PAGE_MESSAGE" "$ARTIFACT"; then
    printf 'Test failed: expected message was not found.\n' >&2
    exit 1
fi

printf 'Test passed: page exists, title is correct, and message matches.\n'
```

### Updated `deploy.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail

ARTIFACT="labs/L05-shell-scripting/build/site/index.html"
DESTINATION="labs/L05-shell-scripting/deployed"

if [[ ! -f "$ARTIFACT" ]]; then
  printf 'Deploy failed: run build.sh first.\n' >&2
  exit 1
fi

bash labs/L05-shell-scripting/test.sh

mkdir -p "$DESTINATION"
cp "$ARTIFACT" "$DESTINATION/index.html"
printf 'Local deployment complete: %s/index.html\n' "$DESTINATION"
```

### Final execution order

Run each command from the repository root:

```bash
bash labs/L05-shell-scripting/build.sh
bash labs/L05-shell-scripting/test.sh
bash labs/L05-shell-scripting/deploy.sh
```

Expected successful flow:
1. `build.sh` generates `build/site/index.html`.
2. `test.sh` checks that the page exists and validates its title and configured message.
3. `deploy.sh` runs the test and copies the page to `deployed/index.html` only when the test passes.
