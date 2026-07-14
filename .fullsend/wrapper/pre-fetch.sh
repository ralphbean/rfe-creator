#!/usr/bin/env bash
set -euo pipefail

# Copy scripts/ into CWD so they're available both here (host) and inside the
# sandbox (where a symlink to a host path would be broken).
if [[ ! -e scripts ]]; then
    REAL_SCRIPTS="$(cd "$(dirname "${BASH_SOURCE[0]}")/../scripts" && pwd -P)"
    cp -r "$REAL_SCRIPTS" scripts
fi

# Extract issue key from URL
# e.g., https://issues.redhat.com/browse/PROJ-1234 -> PROJ-1234
ISSUE_KEY="${FULLSEND_WORK_ITEM_URL##*/}"

# Fetch issue and write all artifact files (task, original, comments)
python3 scripts/fetch_issue.py "$ISSUE_KEY" --fetch-all artifacts
