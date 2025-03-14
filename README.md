# Update Commit Dates

A shell script to modify the **committer date** and **author date** of a specific Git commit in a repository. This script safely rewrites the commit history with new dates and reapplies the rewritten commit to the current branch.

## Features
- Updates the committer and author dates of a specific commit.
- Rewrites the commit history to keep your Git repository consistent.
- Automatically detects and reapplies the changes onto the current branch.

---

## Prerequisites
- **Git** must be installed and available in your PATH.
- Ensure that the commit you wish to update exists in your repository.
- Backup the repository if the commit history is shared with others, as rewriting history will require a forced push.

---
## Usages
### curl
```shell
curl https://raw.githubusercontent.com/chubbyhippo/update-commit-dates.sh/refs/heads/main/update-commit-dates.sh | /usr/bin/env sh -s abc123 "2023-01-01 12:00:00" "2023-01-01 12:00:00"
```
### Make executable:
```shell
chmod +x update-commit-dates.sh
```

### Syntax:
```shell
./update-commit-dates.sh <commit-id> <committer-date> <author-date>
```

### Example:
```shell
./update-commit-dates.sh abc123 "2023-01-01 12:00:00" "2023-01-01 12:00:00"
```

In this example:
- Replace `abc123` with the Git hash of the commit you want to update.
- The `committer-date` and `author-date` should be provided in the format `YYYY-MM-DD HH:MM:SS`.

---

## How It Works
1. **Commit Verification**: The script ensures the specified commit exists in the repository.
2. **Rewrite**: The commit’s dates are updated using Git environment variables:
   - `GIT_COMMITTER_DATE`
   - `GIT_AUTHOR_DATE`
3. **Reapply Changes**: The rewritten commit is reapplied to the current branch.
4. **Output**: If successful, it displays the updated commit details.

---

## Notes
- **Rewriting History**: This script modifies commit history by rewriting the specified commit. After running this script, you may need to force-push the branch to a remote repository:
  ```bash
  git push --force-with-lease
  ```
- **Risk of Collaboration Issues**: If the branch is being actively worked on by others, rewriting history can cause conflicts. Ensure you're aware of the implications before using this script.

---

## Error Handling
- If the specified commit hash is invalid, the script will terminate with an error.
- If the required parameters are not supplied, the script will display the correct usage format.

---

## License
This script is open for use and modification. Feel free to adapt it to your needs.

---

## Disclaimer
Use this script responsibly and carefully, especially in shared repositories, as rewriting history can disrupt collaboration.
