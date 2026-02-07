# Proposed Feature Issues

## Issue: Add repository status summary command

**Description**
Create a new menu option that summarizes the current repository state. The status view should list:
- Files that are currently checked out (`*.checkedout`).
- Files that have backups but are missing from the repository (deleted files that could be restored).
- The active repository name and timestamp of the latest check-in.

**Why this matters**
Users currently need to manually inspect the directory to understand what is checked out or deleted. A status command makes the tool feel more Git-like and improves day-to-day usability.

## Issue: Add file rename/move support with logging

**Description**
Add a file operation that lets users rename or move a tracked file inside the current repository. The command should:
- Verify the source file exists and is not checked out.
- Rename/move the file.
- Record the rename in the log with timestamps and user attribution.
- Preserve existing backups under the new name (rename backups if needed).

**Why this matters**
Renaming files is a common workflow in real projects. Right now users must do it manually, which bypasses logging and can break the backup trail.

## Issue: Add log viewer with filter options

**Description**
Introduce a view option to display the repository log with simple filters, such as:
- Show all entries (current behavior).
- Show entries for a specific file.
- Show only check-ins or check-outs.

The command should read `log.txt` and present it in `less` or `cat`, depending on user preference.

**Why this matters**
The log exists but requires users to manually open it. A dedicated viewer keeps navigation consistent with the menu UI and makes it easier to discover history.

## Issue: Respect the user's preferred editor

**Description**
When checking out a file, open it with the editor defined in `$EDITOR` when available, falling back to `nano` if it is unset. The update should preserve the current behavior when `$EDITOR` is not defined.

**Why this matters**
Many users prefer editors like `vim` or `code --wait`. Respecting `$EDITOR` improves usability without adding dependencies.
