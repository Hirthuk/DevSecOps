# ✅ GitHub Actions Cheatsheet (With Clear Explanations)

---

## 🧠 What is GitHub Actions?

**GitHub Actions** is a tool built into GitHub that lets you **automate tasks** like:

* Testing your code when someone pushes
* Deploying your app when code is merged
* Running scripts on a schedule

You do this by writing **workflow files** in **YAML**.

---

## 📁 Where are Workflow Files Stored?

Your workflows are stored inside your repo here:

```bash
.github/workflows/<your-workflow>.yml
```

---

## 🧱 Basic Structure of a Workflow

```yaml
name: CI Pipeline  # (Optional) Name of the workflow

on: [push, pull_request]  # Triggers: When to run the workflow

jobs:
  build:  # A job runs steps on a virtual machine
    runs-on: ubuntu-latest  # OS for the runner (Ubuntu VM)

    steps:  # Steps to run in this job
      - uses: actions/checkout@v3  # Step 1: Checkout the code
      - name: Install dependencies
        run: npm install  # Step 2: Run a shell command
```

---

## 🔄 1. `on`: What Triggers the Workflow?

This tells GitHub **when to run** your workflow.

```yaml
on:
  push:  # Run when someone pushes code
    branches: [main]
  pull_request:  # Run when someone opens a PR
    branches: [main]
  schedule:  # Run on a schedule (like a cron job)
    - cron: '0 3 * * 1'  # Every Monday at 3 AM UTC
```

---

## 🧪 2. `jobs`: What Your Workflow Does

A **job** is a group of steps that run in a clean environment (a "runner").

```yaml
jobs:
  test:
    runs-on: ubuntu-latest  # You get a fresh Ubuntu VM
    steps:
      - run: echo "Running tests"
```

> 📝 You can have **multiple jobs** that run in **parallel** or **depend on each other**.

---

## 🧩 3. `steps`: Individual Tasks in a Job

Each **step** is either:

* A **shell command** you run (`run`)
* An **action** someone else wrote (`uses`)

```yaml
steps:
  - uses: actions/checkout@v3  # Built-in action to clone the repo
  - run: echo "Hello, world!"  # Simple shell command
```

---

## 💻 4. `runs-on`: What Kind of Machine to Use

Tells GitHub what OS to use for the job:

```yaml
runs-on: ubuntu-latest  # Or: windows-latest, macos-latest
```

---

## 🔌 5. `uses`: Using Existing Actions

You can reuse public actions (like plugins).

```yaml
- uses: actions/setup-node@v3  # Sets up Node.js
  with:
    node-version: '18'
```

---

## 🔐 6. Secrets and Environment Variables

Secrets are stored safely in your repo settings. Use them like this:

```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
```

Or just in a single step:

```yaml
- run: echo $API_KEY
  env:
    API_KEY: ${{ secrets.API_KEY }}
```

---

## 🔁 7. Matrix Strategy: Run Tests Across Versions

Useful to test against multiple versions (e.g., different Node.js versions):

```yaml
strategy:
  matrix:
    node: [14, 16, 18]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node: [14, 16, 18]
    steps:
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node }}
```

> 💡 This runs the same steps for Node.js v14, 16, and 18 in parallel.

---

## 🚀 8. Deploying with GitHub Actions

Example: Deploy a static site to **GitHub Pages**:

```yaml
- uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./dist
```

> `publish_dir` is the folder you want to publish (e.g., build output)

---

## 💾 9. Caching Dependencies (Speed Up Builds)

You can cache things like `node_modules` or `.venv` to save time:

```yaml
- uses: actions/cache@v3
  with:
    path: ~/.npm  # Cache location
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

> This avoids re-downloading packages every run.

---

## 📦 10. Uploading Artifacts (Save Files)

You can save files between jobs or after a build:

```yaml
- name: Upload build
  uses: actions/upload-artifact@v3
  with:
    name: build-files
    path: ./build
```

Later, download them:

```yaml
- name: Download build
  uses: actions/download-artifact@v3
  with:
    name: build-files
```

---

## 🧠 11. Contexts and Expressions (`${{ }}`)

Use these to access info dynamically:

```yaml
- run: echo "Commit message is ${{ github.event.head_commit.message }}"
```

Useful Contexts:

* `github` → Info about repo, user, commit, etc.
* `env` → Environment variables
* `secrets` → Your secret values
* `runner` → Info about the machine running the job
* `job` / `steps` → Status and outputs of other steps

---

## 🔍 12. Debugging Workflows

Enable verbose logging by adding secrets to your repo:

| Secret Name            | Value  |
| ---------------------- | ------ |
| `ACTIONS_STEP_DEBUG`   | `true` |
| `ACTIONS_RUNNER_DEBUG` | `true` |

Log a debug message:

```yaml
- run: echo "::debug::This is a debug log"
```

---

## 🔁 13. Reusable Workflows (Advanced)

You can call one workflow from another:

### `deploy.yml`

```yaml
on: workflow_call
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

### Main Workflow:

```yaml
jobs:
  call-deploy:
    uses: ./.github/workflows/deploy.yml
```

---

## ⚡ 14. Commonly Used Actions

| Action                       | What it does           |
| ---------------------------- | ---------------------- |
| `actions/checkout`           | Clones your repo       |
| `actions/setup-node`         | Sets up Node.js        |
| `actions/cache`              | Caches dependencies    |
| `upload-artifact`            | Save build/test files  |
| `download-artifact`          | Get saved files        |
| `peaceiris/actions-gh-pages` | Deploy to GitHub Pages |

