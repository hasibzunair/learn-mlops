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

**Summary**:

Core components, workflows (events + jobs), jobs (runner + steps), steps (do actual work).

Events/triggers, workflows have at least one event(s).

Defien workflows, .github/workflows/<file>.yml, github actions syntax.

Runners are servers and machines that execture jobs, pre-def runners, also create custom runner.

Workflow exec when event (PR, new commit etc) triggered.

Actions can run shell commands, also predef actions.

```yaml
name: Deployment Exercise 1
on: push # Do it when code is pushed
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      # get code in gh machine
      - name: Get code
        uses: actions/checkout@v3
      # install dependencies
      - name: Install libs
        run: npm ci
      #- name: Lint
      #  run: npm run lint
      - name: Test code
        run: npm run test
      - name: Build code
        run: npm run build
      - name: Deploy code
        run: echo "Deploying...."
```

```yaml
name: Deployment Exercise 2
on: push # Do it when code is pushed
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      # get code in gh machine
      - name: Get code
        uses: actions/checkout@v3
      # install dependencies
      - name: Install libs
        run: npm ci
      - name: Lint
        run: npm run lint
  test:
    needs: lint
    runs-on: ubuntu-latest
    steps:
      # get code in gh machine
      - name: Get code
        uses: actions/checkout@v3
      # install dependencies
      - name: Install libs
        run: npm ci
      - name: Lint
        run: npm run lint
      - name: Test code
        run: npm run test
  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      # get code in gh machine
      - name: Get code
        uses: actions/checkout@v3
      # install dependencies
      - name: Install libs
        run: npm ci
      - name: Build code
        run: npm run build
      - name: Deploy code
        run: echo "Deploying...."
```

```yaml
name: Issues Exercise
on: issues # Do it when new issue
jobs:
  output-info:
    runs-on: ubuntu-latest
    steps:
      - name: Output event details
        run: echo "${{ toJSON(github.event) }}"

```

## Section 4

Events that trigger workflows. Like, not all push event triggers workflow. More control over when a workflow runs.

Repo related events -> push, pull_request, create, issues, etc.

Other -> workflow_dispatch, schedule, workflow_call etc.

Events: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#pull_request

```yaml
name: Events Demo 1
on:
  pull_request:
    types:
      - opened
      branches:
      - main
      - 'dev-*' # dev-new, dev-this-is-new
      - 'feat/**' # feat/new, feat/new/button
  workflow_dispatch:
  push:
    branches:
      - main
      - 'dev-*' # dev-new, dev-this-is-new
      - 'feat/**' # feat/new, feat/new/button
    paths-ignore:
     - '.github/workflows/*' # if we dont change here, trigger workflow
    # or
    #paths-ignore:
    # - '.github/workflows/*' # if we dont change here, trigger workflow
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Output event data
        run: echo "${{ toJSON(github.event) }}"
      - name: Get code
        uses: actions/checkout@v3
      - name: Install dependencies
        run: npm ci
      - name: Test code
        run: npm run test
      - name: Build code
        run: npm run build
      - name: Deploy project
        run: echo "Deploying..."
```

To skip workflow: 

```git commit -m "add comments [skip ci]"```

## Section 5

Job artifacts: assets generated by a job. (binary files etc.).

Artifacts from different jobs are not together as each job runs on its own machine, so if we want an artifact from another job, we need to download it in the new job.

Jobs can output values that we want to use in another job.

```yaml
name: Deploy website
on:
  push:
    branches:
      - main
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      # Cache dependencies and use in other jobs to save time when installing libs
      # This also caches new dependencies if installed at end of job
      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        run: npm ci
      - name: Lint code
        run: npm run lint
      - name: Test code
        run: npm run test
  build:
    needs: test
    runs-on: ubuntu-latest
    outputs: 
      script-file: ${{ steps.publish.outputs.script-file }}
    steps:
      - name: Get code
        uses: actions/checkout@v3
      # Cache dependencies and use in other jobs to save time when installing libs
      # This also caches new dependencies if installed at end of job
      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        run: npm ci
      - name: Build website
        run: npm run build
      # Get filename and make it available in another jobs
      - name: Publish JS filename
        id: publish
        run: find dist/assets/*.js -type f -execdir echo 'script-file={}' >> $GITHUB_OUTPUT ';'
      # Upload job artifacts
      - name: Uplaod artifacts 
        uses: actions/upload-artifact@v3
        with:
          name: dist-files
          path: dist
          # path: | 
          #   dist
          #   package.json
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      # Download job artifacts
      - name: Get build artifact from build job
        uses: actions/download-artifact@v3
        with:
          name: dist-files
      - name: Output contents
        run: ls
      # Read filename from another job and output it here
      - name: Output filename
        run: echo "${{ needs.build.outputs.script-file }}"
      - name: Deploy
        run: echo "Deploying..."
```

Summary: Artifacts upload and download in diff jobs, Use job outputs /values in another job; cache dependencies to speed up workflow with caching.

## Section 6

Environment variables and secrets. Hardcoding is not often solution!

Env variables: values needed at different places, values might change. Variables can be dynamic.

https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables

Secrets: credentials we dont want in workflow file! Repo-> Settings-> Secrets and variables.

Summary: Environment variables, Secrets, GH Actions environments. 

## Section 7

Controlling workflow and job exec. Remember: Workflow, jobs, steps!

Some conditions: failur(), success(), always(), cancelled()

Reusable workflows.

```yaml
# continue.yml
name: Continue Website Deployment
on:
  push:
    branches:
      - main
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Lint code
        run: npm run lint
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Test code
      # New condition
        # Use continue-on-error if you want workflow to continue even if a step fails
        continue-on-error: true # job should continue even if this fails
        id: run-tests
        run: npm run test
      - name: Upload test report
        uses: actions/upload-artifact@v3
        with:
          name: test-report
          path: test.json
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Build website
        id: build-website
        run: npm run build
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: dist-files
          path: dist
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Get build artifacts
        uses: actions/download-artifact@v3
        with:
          name: dist-files
      - name: Output contents
        run: ls
      - name: Deploy
        run: echo "Deploying..."
  report:
    needs: [lint, deploy]
    if: failure()
    runs-on: ubuntu-latest
    steps:
      - name: Output information
        run: |
          echo "Sth went wrong"
          echo "${{ toJSON(github) }}"
```

```yaml
# execution-flow.yml
name: Website Deployment
on:
  push:
    branches:
      - main
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      # Install, if cache was not used. If not, manually install
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Lint code
        run: npm run lint
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      # If cache is there, dont install, use cache
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      # when this step fails, test report wont work by default, add if statement
      - name: Test code
        id: run-tests
        run: npm run test
      # If run test step failed, upload test report. If it didn't, skip uploading report
      - name: Upload test report
        # if any step fails and run test setps fails, do sth
        if: failure() && steps.run-tests.outcome == 'failure'
        uses: actions/upload-artifact@v3
        with:
          name: test-report
          path: test.json
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      # Install, if cache was used. If not, manually install
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Build website
        id: build-website
        run: npm run build
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: dist-files
          path: dist
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Get build artifacts
        uses: actions/download-artifact@v3
        with:
          name: dist-files
      - name: Output contents
        run: ls
      - name: Deploy
        run: echo "Deploying..."
  # Conditional job, if any other job after lint or deploy failed
  report:
    needs: [lint, deploy]
    if: failure()
    runs-on: ubuntu-latest
    steps:
      - name: Output information
        run: |
          echo "Sth went wrong"
          echo "${{ toJSON(github) }}"
```

```yaml
# matrix.yml
name: Matrix Demo
on: push
jobs:
  build:
    continue-on-error: true # dont cancel the job if any step fails
    # Use multiple values for a config
    # This step run paralelly with diff configs
    strategy:
      matrix:
        node-version: [12, 14, 16]
        operating-system: [ubuntu-latest, windows-latest]
        include: # single combination
          - node-version: 18
            operating-system: ubuntu-latest
        exclude: # exclude from generated matrix
          - node-version: 12
            operating-system: windows-latest
    runs-on: ${{ matrix.operating-system }}
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Install JodeJS
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - name: Install dep
        run: npm ci
      - name: Build project
        run: npm run build
```

```yaml
# reusable.yml
name: Reusable deploy
# Run inside other workflow
on: 
  workflow_call:
    inputs: 
      artifact-name: 
        description: The name of the deployable artifact files
        required: false
        default: dist
        type: string
    #secrets:
      #some-secret: 
        #required: false
    outputs:
      result:
        description: Result of deploy ops
        value: ${{ jobs.deploy.outputs.outcome }}
jobs:
  deploy:
    outputs:
      outcome: ${{ steps.set-result.outputs.step-results }}
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/download-artifact@v3
        with:
          name: ${{ inputs.artifact-name }}
      - name: List files
        run: ls
      - name: Output info
        run: echo "Deploy and upload"
      - name: Set result output
        id: set-result
        run: echo "step-result=success" >> $GITHUB_OUTPUT
```

```yaml
# use-reuse.yml
name: Using reusable workflow
on:
  push:
    branches:
      - main
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Lint code
        run: npm run lint
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Test code
        id: run-tests
        run: npm run test
      - name: Upload test report
        if: failure() && steps.run-tests.outcome == 'failure'
        uses: actions/upload-artifact@v3
        with:
          name: test-report
          path: test.json
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Get code
        uses: actions/checkout@v3
      - name: Cache dependencies
        id: cache
        uses: actions/cache@v3
        with:
          path: node_modules
          key: deps-node-modules-${{ hashFiles('**/package-lock.json') }}
      - name: Install dependencies
        if: steps.cache.outputs.cache-hit != 'true' 
        run: npm ci
      - name: Build website
        id: build-website
        run: npm run build
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: dist-files
          path: dist
  deploy:
    # define workflow
    needs: build
    uses: ./.github/workflows/reusable.yml
    with: 
      # add filename to new workflow
      artifact-name: dist-files
    #secrets:
      #some-secret: ${{ secrets.some-secret}}
  print-deploy-results:
    needs: deploy
    runs-on: ubuntu-latest
    steps:
      - name: Print deploy output
        run: echo "${{ needs.deploy.outputs.result }}"
  report:
    needs: [lint, deploy]
    if: failure()
    runs-on: ubuntu-latest
    steps:
      - name: Output information
        run: |
          echo "Sth went wrong"
          echo "${{ toJSON(github) }}"
```

Summary: conditional jobs, matrix jobs, reusable workflows.

## Section 8

TBA.
