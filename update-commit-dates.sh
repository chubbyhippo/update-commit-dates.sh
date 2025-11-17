#!/usr/bin/env sh

# Check if the required parameters are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <committer-date> <author-date> <commit-id>"
    echo "Example: $0 '2023-01-01 12:00:00' '2023-01-01 12:00:00' abc123"
    exit 1
fi

COMMITTER_DATE=$1
AUTHOR_DATE=$2
COMMIT_ID=$3
# Get the name of the current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Check if the commit exists in the repo
if ! git cat-file -e "$COMMIT_ID" 2>/dev/null; then
    echo "Error: Commit ID $COMMIT_ID not found in the repository."
    exit 1
fi

# Checkout the branch and detach HEAD (to rewrite history)
git checkout "$COMMIT_ID" || exit

# Set the new dates for the rewrite
export GIT_COMMITTER_DATE="$COMMITTER_DATE"
export GIT_AUTHOR_DATE="$AUTHOR_DATE"

# Rewrite the commit with the new dates
git commit --amend --no-edit --date "$AUTHOR_DATE" || exit

# Reapply the rewritten commit to the branch
git rebase --onto HEAD "$COMMIT_ID" "$CURRENT_BRANCH" || exit

echo "Successfully updated commit $COMMIT_ID with new dates:"
echo "  Committer Date: $COMMITTER_DATE"
echo "  Author Date:    $AUTHOR_DATE"