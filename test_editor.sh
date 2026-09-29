#!/bin/bash
# Verifies that checkOut launches $EDITOR, and falls back to nano when unset.
# Run: ./test_editor.sh

set -u
cd "$(dirname "$0")" || exit 1

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export PATH="$tmp/bin:$PATH"
mkdir -p "$tmp/bin"

# Stand-ins that record their own name alongside the path they were handed, so
# a test can tell *which* editor ran. A shared fake would let a hardcoded
# `nano` pass the $EDITOR case.
printf '#!/bin/bash\n{ echo "fake-editor"; for a in "$@"; do echo "arg=$a"; done; } > "$RECORD"\n' > "$tmp/bin/fake-editor"
printf '#!/bin/bash\necho "nano $1" > "$RECORD"\n' > "$tmp/bin/nano"
chmod +x "$tmp/bin/fake-editor" "$tmp/bin/nano"
export RECORD="$tmp/launched"

# Load the script's functions, skipping the trailing `mainMenu` invocation
# so nothing tries to take over the terminal. Sourced from a real file
# rather than a process substitution: bash 3.2 cannot seek the fd that
# `source <(...)` hands it, so the definitions silently vanish.
# shellcheck disable=SC1090
sed '$d' VersionControl.sh > "$tmp/funcs.sh"
source "$tmp/funcs.sh"

currentRepo="$tmp/repo"
logFile="activity.log"
mkdir -p "$currentRepo"
echo "hello" > "$currentRepo/tracked.txt"
checkedout="$currentRepo/tracked.txt.checkedout"

run_checkout() { echo "tracked.txt" | checkOut >/dev/null 2>&1; }

fail=0
check() { # check <label> <expected>
    local got
    got=$(cat "$RECORD" 2>/dev/null)
    if [ "$got" = "$2" ]; then
        echo "ok - $1"
    else
        echo "NOT OK - $1"
        echo "       expected: $2"
        echo "       got:      ${got:-<nothing ran>}"
        fail=1
    fi
}

# 1. $EDITOR is honoured, and nano is not used.
rm -f "$RECORD" "$checkedout"
EDITOR="$tmp/bin/fake-editor" run_checkout
check "\$EDITOR is used instead of nano" "fake-editor
arg=$checkedout"

# 2. $EDITOR carrying its own flags reaches the target file rather than
#    being word-split into an argument the file never gets.
rm -f "$RECORD" "$checkedout"
EDITOR="$tmp/bin/fake-editor --wait" run_checkout
check "\$EDITOR with flags still opens the file" "fake-editor
arg=--wait
arg=$checkedout"

# 3. Falls back to nano when $EDITOR is unset.
rm -f "$RECORD" "$checkedout"
unset EDITOR
run_checkout
check "falls back to nano when \$EDITOR is unset" "nano $checkedout"

# 4. The .checkedout lock is still created and logged.
if [ -f "$checkedout" ] &&
   [ -f "$currentRepo/$logFile" ] &&
   grep -q "checked out file" "$currentRepo/$logFile"; then
    echo "ok - .checkedout lock created and logged"
else
    echo "NOT OK - .checkedout lock created and logged"
    fail=1
fi

exit $fail
