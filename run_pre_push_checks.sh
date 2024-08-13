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

# Run tests (you can replace this with your actual test command)
print_color $BLUE "Running tests..."
if ! ./run_tests.sh; then
    print_color $RED "Error: Tests failed. Please fix the issues before pushing."
    exit 1
fi

print_color $GREEN "All tests passed."

# Run linting (you can replace this with your actual lint command)
print_color $BLUE "Running code linter..."
if ! ./run_linter.sh; then
    print_color $RED "Error: Linting failed. Please fix the issues before pushing."
    exit 1
fi

print_color $GREEN "Code linter passed."

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
