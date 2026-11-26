#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"
WGAC_ROOT="$REPO_ROOT/../wGac"

if [[ "$#" -ne 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi

# Validate both sources before replacing either snapshot. Never run upstream scripts.
for folder in WGac WGacShared; do
    if [[ ! -d "$WGAC_ROOT/$folder" ]]; then
        echo "Missing sibling checkout directory: $WGAC_ROOT/$folder" >&2
        exit 1
    fi
done

for folder in WGac WGacShared; do
    rm -rf -- "$REPO_ROOT/Import/$folder"
    cp -R -- "$WGAC_ROOT/$folder" "$REPO_ROOT/Import/$folder"
done
echo "Imported WGac and WGacShared from $WGAC_ROOT."
