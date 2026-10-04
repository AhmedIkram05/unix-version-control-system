#!/bin/bash
# Verifies that restore rolls back to the second-most-recent backup,
# resurrects deleted files from .deleted_ backups, and reports cleanly
# when there is nothing to restore.
# Run: ./test_restore.sh

set -u
cd "$(dirname "$0")" || exit 1

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Load the script's functions, skipping the trailing menu invocation
# so nothing tries to take over the terminal (same pattern as test_editor.sh).
# shellcheck disable=SC1090
sed '$d' VersionControl.sh > "$tmp/funcs.sh"
source "$tmp/funcs.sh"
# $backupDir is set by the sourced file; fall back to its default so this
# script also reads standalone under `set -u`.
backupDir="${backupDir:-backups}"

currentRepo="$tmp/repo"
mkdir -p "$currentRepo/$backupDir"

fail=0
check() { # check <label> <expected> <actual>
    if [ "$3" = "$2" ]; then
        echo "ok - $1"
    else
        echo "NOT OK - $1"
        echo "       expected: $2"
        echo "       got:      ${3:-<empty>}"
        fail=1
    fi
}

# Three backups, oldest first (sleep keeps ls -t ordering deterministic).
echo "v1" > "$currentRepo/target.txt"
echo "v1" > "$currentRepo/$backupDir/target.txt.backup_2026-01-01_00-00-01"
sleep 1
echo "v2" > "$currentRepo/$backupDir/target.txt.backup_2026-01-01_00-00-02"
sleep 1
echo "v3" > "$currentRepo/$backupDir/target.txt.backup_2026-01-01_00-00-03"

# 1. Restores the second-most-recent backup, not the newest.
echo "target.txt" | restore >/dev/null 2>&1
check "restores second-most-recent backup" "v2" "$(cat "$currentRepo/target.txt")"

# 2. A deleted file comes back from its .deleted_ backup.
echo "gone-content" > "$currentRepo/$backupDir/victim.txt.deleted_2026-01-01_00-00-01"
echo "victim.txt" | restore >/dev/null 2>&1
check "resurrects deleted file from backup" "gone-content" "$(cat "$currentRepo/victim.txt" 2>/dev/null)"

# 3. Nothing to restore is reported, not a silent no-op.
echo "lonely-content" > "$currentRepo/lonely.txt"
out=$(echo "lonely.txt" | restore 2>&1)
check "reports missing backup" "No backup found for 'lonely.txt'." "$(echo "$out" | tail -n 1)"

# 4. No repository selected is reported.
savedRepo="$currentRepo"
currentRepo=""
out=$(echo "target.txt" | restore 2>&1)
currentRepo="$savedRepo"
check "reports missing repository" "No repository selected. Please create or select a repository first." "$(echo "$out" | tail -n 1)"

exit $fail
