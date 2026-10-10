# Capstone: Campus Service Release Pipeline

**Time: 25 minutes · Work alone or with a partner**

## Your task

Push this folder to your own GitHub repository, then watch GitHub run the pipeline.

The pipeline runs three jobs in order:

1. **Build** creates a Campus Pulse web page using `build.sh`.
2. **Test** checks the page using `test.sh`.
3. **Deploy** copies the page using `deploy.sh`.

The workflow is `.github/workflows/ci.yaml`. Deploy copies the page into a folder on GitHub's temporary computer; it does not publish a public website.

## Push this project to GitHub

1. Create an empty repository on GitHub.
2. Open a terminal in this `capstone` folder.
3. Replace the example URL below with your repository URL, then run:

```bash
git init
git branch -M main
git add .
git commit -m "Add capstone pipeline"
git remote add origin https://github.com/YOUR-NAME/YOUR-REPOSITORY.git
git push -u origin main
```

GitHub Actions starts automatically. Open your repository's **Actions** tab to see the run. Create a pull request and look at its **Checks** section to see the pipeline status for the PR.

## Try the scripts on your computer

Run these from the capstone folder in a Bash terminal:

```bash
bash build.sh
bash test.sh
bash deploy.sh
```

## Log task

Use the sample `data/access.log` to find the total number of requests and the number of HTTP 500 responses:

```bash
wc -l data/access.log
awk '$9 == 500 { count++ } END { print count+0 }' data/access.log
```

- Total requests: **_____**
- HTTP 500 responses: **_____**

## Check your understanding

- Which script creates the page?
- What happens if the test fails?
- Why does Deploy wait for Test?
- Which file tells GitHub Actions what to run?
