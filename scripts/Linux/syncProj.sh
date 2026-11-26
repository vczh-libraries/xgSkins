#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"

if [[ "$#" -ne 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi

# Windows owns resource generation. The checked-in C++ and resource payloads
# are portable; the Wayland raw painters are already supplied by import.sh.
for file in \
    Import/Release/GacUI.h \
    Import/WGac/Renderers/WGacRenderer.h \
    Import/WGacShared/FullControlTestRawElement.cpp \
    Import/WGacShared/FullControlTestRawClockInterpretor.cpp \
    Import/WGacShared/FullControlTestRawClockInterpretor_Wayland.cpp \
    Test/FullControlTest/SharedDocumentEditor.cpp \
    Test/FullControlTest/UI/Source/FullControlTestResource.cpp; do
    if [[ ! -f "$REPO_ROOT/$file" ]]; then
        echo "Missing $file. Run import.sh; resource generation requires Windows." >&2
        exit 1
    fi
done
echo "FullControlTest sources are ready; no Linux compatibility fixes are needed."
