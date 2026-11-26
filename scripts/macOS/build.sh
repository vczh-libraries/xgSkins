#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$(uname -s)" != Darwin ]]; then
    echo "This build requires macOS." >&2
    exit 1
fi
if ! command -v cmake >/dev/null 2>&1; then
    echo "Install CMake (brew install cmake) and the Xcode Command Line Tools (xcode-select --install)." >&2
    exit 1
fi

cmake -S "$SCRIPT_DIR" -B "$SCRIPT_DIR/.build" -DCMAKE_BUILD_TYPE=Debug "$@"
cmake --build "$SCRIPT_DIR/.build" --parallel "${CMAKE_BUILD_PARALLEL_LEVEL:-4}"
