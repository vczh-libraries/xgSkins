#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP=""
MODE=""

for argument in "$@"; do
    case "$argument" in
        --app:fct) APP=FullControlTest ;;
        --hosted|--multiwindow)
            if [[ -n "$MODE" && "$MODE" != "$argument" ]]; then
                echo "--hosted and --multiwindow are mutually exclusive." >&2
                exit 1
            fi
            MODE="$argument"
            ;;
        *)
            echo "Usage: $0 --app:fct [--hosted | --multiwindow]" >&2
            exit 1
            ;;
    esac
done

if [[ -z "$APP" ]]; then
    echo "Usage: $0 --app:fct [--hosted | --multiwindow]" >&2
    exit 1
fi

EXECUTABLE="$SCRIPT_DIR/.build/bin/$APP.app/Contents/MacOS/$APP"
if [[ ! -x "$EXECUTABLE" ]]; then
    echo "Application not found. Run scripts/macOS/build.sh first: $EXECUTABLE" >&2
    exit 1
fi

if [[ "$MODE" == --multiwindow ]]; then
    exec "$EXECUTABLE" /MultiWindow
else
    exec "$EXECUTABLE" /Hosted
fi
