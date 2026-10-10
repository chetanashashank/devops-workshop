# L05: Shell Script Basics — Build, Test, Deploy

| | |
|---|---|
| **Duration** | 25 minutes |
| **Prerequisites** | L01 Linux navigation, L03 permissions, and a Bash terminal |
| **Learning objective** | Write and run three shell scripts, use variables and conditions, and understand exit codes. |

## Scenario

You are preparing a tiny web page for release. One script builds it, one checks it, and one copies it to a local deployment folder. This is a safe local demonstration; it does not publish a website.

## Key ideas (3 minutes)

- A shell script is a text file containing commands. `#!/usr/bin/env bash` selects Bash.
- Variables hold values. Use `"$NAME"` to safely use a variable.
- An `if` statement can check whether a file exists with `[[ -f "$FILE" ]]`.
- Exit code `0` means success. A non-zero exit code means failure.
- `bash script.sh` runs a script. `chmod +x script.sh` makes it executable.
- `&&` runs the next command only if the previous command succeeds.

## Steps (17 minutes)

Run these commands from the repository root.

### 1. Build the page (5 min)

```bash
bash labs/L05-shell-scripting/build.sh
cat labs/L05-shell-scripting/build/site/index.html
```

The build script creates an HTML file under `build/site/`.

### 2. Test the page (5 min)

```bash
bash labs/L05-shell-scripting/test.sh
```

The test script checks that the file exists and contains the expected title and page message. Read `test.sh` to see how it reports failure.

### 3. Deploy the page locally (5 min)

```bash
bash labs/L05-shell-scripting/deploy.sh
cat labs/L05-shell-scripting/deployed/index.html
```

The deploy script should run the tests before copying the page to the local `deployed/` folder. If a test fails, deployment must stop. This is only a simulation.

### 4. Run stages in order (2 min)

```bash
bash labs/L05-shell-scripting/build.sh && \
bash labs/L05-shell-scripting/test.sh && \
bash labs/L05-shell-scripting/deploy.sh
```

`&&` runs the next command only if the previous command succeeds.

## Student tasks

1. Change the page message in `build.sh` and rebuild the HTML page.
2. Add a matching check to `test.sh` to verify that the updated page message exists in the generated HTML file.
3. Modify `deploy.sh` so deployment fails when the test fails. Test this by temporarily changing `EXPECTED_MESSAGE` in `test.sh` to an incorrect value, then run `deploy.sh`. Confirm that the test fails and the deployment copy does not run. Restore the correct message afterward.

## Answer guide (for reference)

These are suggested answers to help students check their work.

### Task 1 — Change the page message

In `build.sh`, update the message variable, for example:

```bash
PAGE_MESSAGE="Welcome to our beginner workshop!"
```

Then rebuild:

```bash
bash labs/L05-shell-scripting/build.sh
```

### Task 2 — Check the page message

In `test.sh`, define the expected message:

```bash
EXPECTED_MESSAGE="Welcome to our beginner workshop!"
```

After the existing title check, add:

```bash
if ! grep -Fq "$EXPECTED_MESSAGE" "$ARTIFACT"; then
    printf 'Test failed: expected message was not found.\n' >&2
    exit 1
fi
```

`grep -Fq` searches for the exact message as a fixed string. If it is not found, the test prints an error and exits with a non-zero status.

### Task 3 — Stop deployment when the test fails

In `deploy.sh`, run the test before creating the deployment directory or copying the file:

```bash
bash labs/L05-shell-scripting/test.sh
```

Keep `set -euo pipefail` at the top of `deploy.sh`. If the test exits with a non-zero status, `set -e` causes the deployment script to stop before the copy command.

To demonstrate the failure, temporarily change `EXPECTED_MESSAGE` in `test.sh` to:

```bash
EXPECTED_MESSAGE="Wrong message"
```

Then run:

```bash
bash labs/L05-shell-scripting/deploy.sh
```

Expected result: `Test failed: expected message was not found.` The deployment copy should not run. Restore the correct expected message after this test. This prevents a new deployment; it does not delete an older deployed file.

## Final execution order

After restoring the correct expected message, run these commands from the repository root:

```bash
bash labs/L05-shell-scripting/build.sh
bash labs/L05-shell-scripting/test.sh
bash labs/L05-shell-scripting/deploy.sh
```

Or run the full successful pipeline in one command:

```bash
bash labs/L05-shell-scripting/build.sh && \
bash labs/L05-shell-scripting/test.sh && \
bash labs/L05-shell-scripting/deploy.sh
```

If any stage fails, the `&&` chain stops and later stages do not run.

## Completion check

- [ ] I can describe what each script does.
- [ ] The build and test scripts run successfully when the expected content is correct.
- [ ] Deployment stops when the test fails.
- [ ] I can explain what a non-zero exit code means.
