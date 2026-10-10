# L05: Shell Script Basics — Build, Test, Deploy

| | |
|---|---|
| **Duration** | 25 minutes |
| **Prerequisites** | L01 Linux navigation, L03 permissions, and a Bash terminal |
| **Learning objective** | Write and run three shell scripts, use variables and conditions, and understand exit codes. |

## Scenario

You are preparing a tiny web page for release. One script builds it, one checks it, and one copies it to a local deployment folder. A configuration file stores the page message so both the build and test scripts can use the same value. This is a safe local demonstration; it does not publish a website.

## Key ideas (3 minutes)

- A shell script is a text file containing commands. `#!/usr/bin/env bash` selects Bash.
- Variables hold values. Use `"$NAME"` to safely use a variable.
- `source config.sh` loads variables from a configuration file into the current shell.
- An `if` statement can check whether a file exists with `[[ -f "$FILE" ]]`.
- Exit code `0` means success. A non-zero exit code means failure.
- `bash script.sh` runs a script. `chmod +x script.sh` makes it executable.
- `&&` runs the next command only if the previous command succeeds.

## Files used in this lab

- `config.sh` — stores `PAGE_MESSAGE`.
- `build.sh` — sources `config.sh` and uses `PAGE_MESSAGE` to generate the HTML page.
- `test.sh` — initially checks only that the generated file exists and the title is correct.
- `deploy.sh` — copies the generated page to the local deployment folder. In this exercise, modify it to run tests before copying.

## Steps (17 minutes)

Run these commands from the repository root.

### 1. Build the page (5 min)

```bash
bash labs/L05-shell-scripting/build.sh
cat labs/L05-shell-scripting/build/site/index.html
```

The build script creates an HTML file under `build/site/`. The page message comes from `config.sh`.

### 2. Test the page (5 min)

```bash
bash labs/L05-shell-scripting/test.sh
```

The initial test script checks that the file exists and contains the expected title. In the student tasks, you will add a check for the page message.

### 3. Deploy the page locally (5 min)

```bash
bash labs/L05-shell-scripting/deploy.sh
cat labs/L05-shell-scripting/deployed/index.html
```

The deploy script copies the page to a local `deployed/` folder. You will modify it so that it runs the test first and stops if the test fails. This is only a simulation.

### 4. Run stages in order (2 min)

After completing the tasks, run:

```bash
bash labs/L05-shell-scripting/build.sh && \
bash labs/L05-shell-scripting/test.sh && \
bash labs/L05-shell-scripting/deploy.sh
```

`&&` runs the next command only if the previous command succeeds.

## Student tasks

1. Change `PAGE_MESSAGE` in `config.sh` and rebuild the HTML page.
2. Add a matching check to `test.sh` to verify that the page message from `config.sh` exists in the generated HTML file. Use `source` to load `config.sh` so the test can access `PAGE_MESSAGE`.
3. Modify `deploy.sh` so deployment fails when the test fails. Test this by temporarily changing `PAGE_MESSAGE` in `config.sh` to a new value and deliberately making the expected message in `test.sh` incorrect. Run `deploy.sh` and confirm that the test fails and the deployment copy does not run. Restore the correct expected value afterward.

## Answer guide (for reference)

These are suggested answers to help students check their work.

### Task 1 — Change the page message

In `config.sh`, update the shared variable, for example:

```bash
PAGE_MESSAGE="Welcome to our beginner workshop!"
```

Then rebuild the page:

```bash
bash labs/L05-shell-scripting/build.sh
```

### Task 2 — Check the page message

At the top of `test.sh`, after `set -euo pipefail`, load the configuration:

```bash
source config.sh
```

Then add this check after the existing title check:

```bash
if ! grep -Fq "$PAGE_MESSAGE" "$ARTIFACT"; then
    printf 'Test failed: expected message was not found.\n' >&2
    exit 1
fi
```

`source` makes the variable available in `test.sh`. `grep -Fq` checks whether the exact message appears in the generated HTML file.

### Task 3 — Stop deployment when the test fails

In `deploy.sh`, add this line before creating the destination directory or copying the file:

```bash
bash labs/L05-shell-scripting/test.sh
```

Keep `set -euo pipefail` at the top of `deploy.sh`. If the test returns a non-zero exit code, `set -e` makes the deployment script stop before copying the file.

To demonstrate the failure:
1. Change `PAGE_MESSAGE` in `config.sh` to a new message and rebuild.
2. Temporarily make the expected message in `test.sh` incorrect (for example, replace the `grep` check's `"$PAGE_MESSAGE"` with `"Wrong message"`).
3. Run:

   ```bash
   bash labs/L05-shell-scripting/deploy.sh
   ```

Expected result: `Test failed: expected message was not found.` Deployment stops before the copy command. Restore the correct test check afterward.

Note: this prevents a new deployment; it does not delete an older deployed file.

## Final execution order

After restoring the correct test check, run these commands from the repository root:

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

- [ ] I can describe what `config.sh`, `build.sh`, `test.sh`, and `deploy.sh` do.
- [ ] I can change the page message in `config.sh` and rebuild the page.
- [ ] I can add a test for the page message.
- [ ] Deployment stops when the test fails.
- [ ] I can explain what a non-zero exit code means.
