#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
IGAC_ROOT="$REPO_ROOT/../iGac"

for folder in Mac MacShared; do
    if [[ ! -d "$IGAC_ROOT/$folder" ]]; then
        echo "Missing upstream folder: $IGAC_ROOT/$folder" >&2
        exit 1
    fi
done

for folder in Mac MacShared; do
    mkdir -p "$REPO_ROOT/Import/$folder"
    rsync -a --delete "$IGAC_ROOT/$folder/" "$REPO_ROOT/Import/$folder/"
done

echo "Imported the macOS backend from $IGAC_ROOT."
