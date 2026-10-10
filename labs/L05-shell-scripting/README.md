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

The test script checks that the file exists and contains the expected title. Read `test.sh` to see how it reports failure.

### 3. Deploy the page locally (5 min)

```bash
bash labs/L05-shell-scripting/deploy.sh
cat labs/L05-shell-scripting/deployed/index.html
```

The deploy script copies the page to a local `deployed/` folder. It is only a simulation.

### 4. Run stages in order (2 min)

```bash
bash labs/L05-shell-scripting/build.sh && \
bash labs/L05-shell-scripting/test.sh && \
bash labs/L05-shell-scripting/deploy.sh
```

`&&` runs the next command only if the previous command succeeds.

## Student tasks

1. Change the page message in `build.sh` and rebuild it.
2. Add a matching check to `test.sh`.
3. Explain why deploy should not run when test fails.

## Completion check

- [ ] I can describe what each script does.
- [ ] All three scripts run successfully in order.
- [ ] I can explain what a non-zero exit code means.
