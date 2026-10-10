# Instructor Solution

This folder contains the completed files for the Hello World CI Pipeline capstone. To use it as a standalone repository, create an empty GitHub repository first, then run these commands from this folder:

```bash
git init
git add .
git commit -m "Add Hello World CI pipeline"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/my-first-pipeline.git
git push -u origin main
```

To demonstrate the pull request workflow, create a feature branch, make a small change, push it, and open a pull request into `main`:

```bash
git switch -c feature/first-pipeline
```

After editing one of the files:

```bash
git add .
git commit -m "Update the capstone"
git push -u origin feature/first-pipeline
```

Create the pull request on GitHub. The Build, Test, and Deploy jobs will run in order. They print demonstration messages only; Deploy does not publish an application.
