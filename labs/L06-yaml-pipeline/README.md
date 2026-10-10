# L06: YAML Pipeline — Run Shell Scripts in GitHub Actions

| | |
|---|---|
| **Duration** | 25 minutes |
| **Prerequisites** | L05 shell scripting and a GitHub repository |
| **Learning objective** | Read a YAML workflow and see how it runs the same build, test, and deploy scripts as separate jobs. |

## Scenario

In L05 you ran three shell scripts on your computer. A GitHub Actions workflow can run those same scripts when you push changes or open a pull request. YAML describes the stages; the shell scripts do the work.

## Key ideas (4 minutes)

- GitHub Actions looks for workflow YAML files in `.github/workflows/`.
- `on` lists events that start the workflow.
- `jobs` contains pipeline stages. `needs` sets the order.
- `run` executes shell commands, including the scripts from L05.
- Each job gets a separate computer, so workflow artifacts pass the built page between jobs.

## Steps (17 minutes)

### 1. Inspect the workflow (5 min)

Open `capstone/.github/workflows/ci.yaml`. Find:

1. The events that start the pipeline.
2. The three job names.
3. The line that runs each shell script.
4. How build output passes to the test and deploy jobs.

The capstone contains the ready-to-push version of this pipeline. Its scripts use paths relative to the repository root, so students can push the contents of `capstone/` as a standalone repository.

### 2. Run the L05 scripts locally (6 min)

From the workshop repository root:

```bash
bash labs/L05-shell-scripting/build.sh
bash labs/L05-shell-scripting/test.sh
bash labs/L05-shell-scripting/deploy.sh
```

The commands run the same scripts used in L05. In the capstone workflow, the corresponding scripts run on GitHub's computers.

### 3. Push the capstone (6 min)

To see a real GitHub Actions run, create an empty GitHub repository and push the **contents of the `capstone/` folder** to it. Follow the simple steps in `capstone/README.md`. Open the repository's **Actions** tab to see Build, Test, and Deploy. Open a pull request to see the run status in its **Checks** section.

### 4. Discuss failure behavior (optional, 3 min)

Change the expected title in the capstone's `test.sh` to an incorrect value, push the change on a branch, and open a pull request. The test should fail and deploy should be skipped. Restore the title afterward.

## Pipeline map

```text
push or pull request
        ↓
build job: build.sh → upload page
        ↓
test job: download page → test.sh → upload tested page
        ↓
deploy job: download tested page → deploy.sh
```

The deploy step copies a file to a folder on a temporary GitHub runner. It is a classroom example, not a public website deployment.

## Completion check

- [ ] I can find the workflow trigger and three jobs.
- [ ] I understand YAML calls shell scripts; the commands are not rewritten in YAML.
- [ ] I understand deploy waits for test to succeed.
