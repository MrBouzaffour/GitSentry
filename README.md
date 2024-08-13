# GitSentry

GitSentry is an advanced Git automation script designed to streamline and safeguard your Git workflow. It automates common Git operations like adding, committing, and pushing changes, while incorporating pre-push checks, branch protection, and logging to ensure your repository remains in a clean and stable state.

## Features

- **Automated Git Operations**: Handles adding, committing, and pushing changes in a single script.
- **Pre-Push Checks**: Ensures that tests pass, code is linted, and there are no uncommitted changes or merge conflicts before pushing.
- **Branch Protection**: Confirms before pushing to critical branches like `main` or `master`.
- **Backup Creation**: Automatically creates a backup branch before pushing to preserve the current state.
- **Logging**: Logs all actions to `gitpush.log` for tracking and troubleshooting.

## Prerequisites

- Git must be installed on your machine.
- Ensure you have executable permissions for the script (`gitpush.sh`).

## Setup

1. **Clone or Download GitSentry**:
   Clone this repository or download the `gitpush.sh` and `run_pre_push_checks.sh` scripts to your Git project's root directory.

2. **Make Scripts Executable**:
   If you're on a Unix-like system, ensure the scripts are executable:
   ```bash
   chmod +x gitpush.sh
   chmod +x run_pre_push_checks.sh
   ```
3. **Configure Line Endings (Optional but recommended)**:
   Configure Git to handle line endings appropriately based on your operating system:

- Windows:

   ```bash
   Copy code
   git config --global core.autocrlf true
   ```
- Linux/Mac:

   ``` bash
   Copy code
   git config --global core.autocrlf input
   ```
## Usage

1. **Run GitSentry**:
   In your project's root directory, execute the gitpush.sh script:
   ```bash
   ./gitpush.sh
   ```

   The script will:

   - Detect your current branch and remote.
   - Confirm before pushing to protected branches.
   - Run pre-push checks (tests, linting, merge conflict detection).
   - Automatically add and commit changes.
   - Create a backup branch.
   - Push changes to the remote repository.

2. **Pre-Push Checks**:
   The 'run_pre_push_checks.sh' script runs automatically during the process to ensure that:

   - There are no uncommitted changes.
   - All tests pass.
   - The code passes linting.
   - There are no unresolved merge conflicts.
If any of these checks fail, the push operation will be aborted, and you'll need to address the issues before attempting to push again.

## Customization
   - Pre-Push Checks:
You can customize the pre-push checks by modifying the run_pre_push_checks.sh script. For example, you can replace the test and linter commands with those specific to your project.

   - Branch Protection:
You can modify the list of protected branches in the gitpush.sh script if you want to add or remove branches that require confirmation before pushing.

## Troubleshooting

   - Uncommitted Changes:
If the script fails due to uncommitted changes, run git status to see what's pending. You can either commit those changes or stash them before rerunning the script.

   - Pre-Push Check Failures:
If any pre-push check fails, address the specific issue (e.g., fixing failing tests or resolving lint errors) and try again.

Contributing
Contributions to enhance GitSentry are welcome! Feel free to fork the repository, make improvements, and submit a pull request.
