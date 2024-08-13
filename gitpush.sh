#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Log actions
log_file="gitpush.log"
function log_action {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $log_file
}

# Display colored messages
function print_color {
    echo -e "$1$2${NC}"
}

# Backup current state before pushing
function backup_branch {
    BACKUP_BRANCH="backup-$(date +%Y-%m-%d-%H-%M-%S)"
    git checkout -b $BACKUP_BRANCH
    git checkout -
    log_action "Backup branch created: $BACKUP_BRANCH"
}

# Confirm pushing to protected branches
function confirm_protected_branch_push {
    read -p "Are you sure you want to push to $1? [y/N]: " confirm
    case $confirm in
        [Yy]* )
            print_color $GREEN "Proceeding with push..."
            ;;
        * )
            print_color $RED "Push aborted."
            exit 0
            ;;
    esac
}

function main {
    print_color $BLUE "Script started..."
    log_action "Script execution started."

    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    DEFAULT_REMOTE=$(git remote | head -n 1)

    print_color $BLUE "Detected branch: $CURRENT_BRANCH and remote: $DEFAULT_REMOTE"
    log_action "Working on branch: $CURRENT_BRANCH with remote: $DEFAULT_REMOTE"

    if [[ "$CURRENT_BRANCH" =~ ^(main|master)$ ]]; then
        confirm_protected_branch_push $CURRENT_BRANCH
    fi

    if ! ./run_pre_push_checks.sh; then
        print_color $RED "Pre-push checks failed."
        exit 1
    fi

    print_color $GREEN "Pre-push checks passed."
    log_action "Pre-push checks passed."

    git add -A
    log_action "Added all changes."

    echo -n "Enter commit message: "
    read COMMIT_MSG
    if git commit -m "$COMMIT_MSG"; then
        print_color $GREEN "Commit successful."
        log_action "Committed changes: $COMMIT_MSG"
    else
        print_color $RED "Error: Commit failed."
        exit 1
    fi

    backup_branch

    if git push $DEFAULT_REMOTE $CURRENT_BRANCH; then
        print_color $GREEN "Changes pushed successfully to $CURRENT_BRANCH on remote $DEFAULT_REMOTE."
        log_action "Changes pushed to $CURRENT_BRANCH on $DEFAULT_REMOTE."
    else
        print_color $RED "Error: Push failed."
        exit 1
    fi
}

main
