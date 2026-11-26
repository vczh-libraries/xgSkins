#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Resources and shared C++ sources are synchronized/generated on Windows.
# The macOS build consumes those checked-in files and the imported Cocoa helpers.
for file in \
    Import/Release/GacUI.cpp \
    Import/Mac/NativeWindow/OSX/CoreGraphics/CoreGraphicsApp.mm \
    Import/MacShared/FullControlTestRawClockInterpretorCocoa.cpp \
    Import/MacShared/FullControlTestRawElement.cpp \
    Test/FullControlTest/SharedDocumentEditor.cpp \
    Test/FullControlTest/UI/Source/FullControlTestResource.cpp; do
    if [[ ! -f "$REPO_ROOT/$file" ]]; then
        echo "Missing $file. Run scripts/macOS/import.sh for Cocoa sources; synchronize shared sources on Windows." >&2
        exit 1
    fi
done

echo "macOS project sources are ready; no copied-source fixes are required."
