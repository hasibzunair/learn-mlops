# GitHub Actions - The Complete Guide Notes

Course Link - [Link](https://www.udemy.com/course/github-actions-the-complete-guide/).

## Section 1

Q. What is GitHub Actions?
A. Workflow automation service. CI/CD processes. Method for automating app dev and deployment.

CI: Code changes automatically built, tested and merged with existing code.

CD: After integration, new app or package versions are published automatically.

GH Actions makes CI/CD easier. Also helps with code reviews, issue management.

Git: Tool to manage source code changes. Save snapshots (commits), work on alternative code (branches), move between branches (checkout). Roll back if problem and not break existing code.

## Section 2

```bash
git log
git revert <id> # undo commit
git reset --hard <id> # delete commit
git merge <name> # merge branch
```

## Section 3

**Key Elements**: Workflows, jobs and steps.

Repository -> Workflow -> Jobs -> Steps (acutal thing done like download code, install libs, etc).

Workflows: Contains one or more jobs. Triggered on events.

Jobs: Define a runner (exec environment), contains one or more steps. Runs in parallel or sequential, can be conditional.

Steps: shell script or action, perform a certain task, use custom or third-party actions, steps executed in order.

See some gh actions in https://github.com/hasibzunair/image-classifier-gradio-demo and https://github.com/mlmed/torchxrayvision/blob/master/.github/workflows/tests.yml.

```yaml
# first-action.yml
name: My first workflow
on: workflow_dispatch
jobs:
  first-job:
    runs-on: ubuntu-latest
    steps:
      - name: Print greeting
        run: echo "Hello World"
      - name: Print goodbye
        run: echo "Done, byeee! :D"
```

https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows

**Actions**: A custom application that performs a frequently repeated task. You can build your own actions.

See https://github.com/marketplace?category=&query=&type=actions&verification=.

```yaml
# deploy.yml
name: Deploy Project
on: [push, workflow_dispatch] # multiple event triggers
jobs: 
  test: 
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v4
      - name: Install NodeJS
        uses: actions/setup-node@v3
        with:
          node-version: 18
      - name: Install libs
        run: npm ci
      - name: Run tests
        run: npm test
  # Another job
  deploy:
    # If previous job passes, only run this job
    needs: test
    # every job has its own runner, its own vm that is isolated from other
    # machines and jobs.
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v4
      - name: Install NodeJS
        uses: actions/setup-node@v3
        with:
          node-version: 18
      - name: Install libs
        run: npm ci
      - name: Run tests
        run: npm test
      - name: Build project
        run: npm run build
      - name: Deploy
        run: echo "Deploying ..."
```

See context objects: https://docs.github.com/en/actions/learn-github-actions/contexts, and expressions https://docs.github.com/en/actions/learn-github-actions/expressions. For actions and commands that need metadata: 

```yaml
name: Output info
on: workflow_dispatch
jobs:
  info:
    runs-on: ubuntu-latest
    steps:
      - name: Output github context
        run: echo "${{ toJSON(github) }}" # reserved word
```

Summary: 

Core components, workflows (events + jobs), jobs (runner + steps), steps (do actual work).

Events/triggers, workflows have at least one event(s).

Defien workflows, .github/workflows/<file>.yml, github actions syntax.

Runners are servers and machines that execture jobs, pre-def runners, also create custom runner.

Workflow exec when event (PR, new commit etc) triggered.

Actions can run shell commands, also predef actions.

