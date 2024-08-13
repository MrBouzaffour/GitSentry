#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display messages in color
function print_color {
    echo -e "$1$2${NC}"
}

print_color $GREEN "Tests step skipped (no tests configured)."

# Check for large files (over 10MB)
print_color $BLUE "Checking for large files..."
if git ls-files | xargs -I {} bash -c 'if [ $(stat -c%s {}) -gt 10485760 ]; then echo "{} is larger than 10MB"; exit 1; fi'; then
    print_color $GREEN "No large files detected."
else
    print_color $RED "Error: Large files detected. Consider reducing file sizes or excluding them before pushing."
    exit 1
fi

# Check for merge conflicts
print_color $BLUE "Checking for merge conflicts..."
if git ls-files -u | grep -q '^'; then
    print_color $RED "Error: Merge conflicts detected. Please resolve them before pushing."
    exit 1
fi

print_color $GREEN "No merge conflicts detected."

# If all checks passed
print_color $GREEN "All pre-push checks passed successfully."
exit 0
