#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/.build"

if [[ "$#" -gt 1 || ( "$#" -eq 1 && "$1" != "--rebuild" ) ]]; then
    echo "Usage: $0 [--rebuild]" >&2
    exit 1
fi
if [[ "$#" -eq 1 ]]; then
    rm -rf -- "$BUILD_DIR"
fi

CC="${CC:-clang}" CXX="${CXX:-clang++}" cmake -S "$SCRIPT_DIR" -B "$BUILD_DIR"
# The amalgamated framework sources are large; let CMake's default build
# serially unless the caller opts in with CMAKE_BUILD_PARALLEL_LEVEL.
cmake --build "$BUILD_DIR"
