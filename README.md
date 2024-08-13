# Enhanced Git Automation Script

This script simplifies Git operations like add, commit, and push directly from your repository's root directory. It's designed to be robust, handling error checks, creating backups, and preventing accidental pushes to critical branches.

## Features

- **Colored Output**: Enhances readability with color-coded messages.
- **Backup Creation**: Automatically creates a backup branch before pushing.
- **Branch Validation**: Prevents accidental pushes to `main` or `master` without confirmation.
- **Logging**: Maintains a log file (`gitpush.log`) for audit and troubleshooting.

## Prerequisites

- Git installed on your machine.
- A Unix-like terminal (Linux, macOS).
- Execute permissions for shell scripts.

## Setup

1. **Clone or Download**
   - Clone this repository or download the `gitpush.sh` file directly into your Git repository root.

2. **Make Executable**
   - Change the script to be executable:
     ```bash
     chmod +x gitpush.sh
     ```

## Usage

Run the script directly in your repository's root directory:

```bash
./gitpush.sh
```

  - Detects your current branch and remote.
  - Prompts for commit message and confirms before pushing to protected branches.
  - Optionally, execute ./run_pre_push_checks.sh before pushing for additional safety (create this script as per your custom checks).

## Customization
Modify the script as needed to fit your workflow, such as adding specific pre-push checks in run_pre_push_checks.sh.

## Contributing
Feel free to fork, modify, and make pull requests to improve the script functionality.
