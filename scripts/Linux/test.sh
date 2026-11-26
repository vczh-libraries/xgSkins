#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_NAME=""
MODE=/MultiWindow

for argument in "$@"; do
    case "$argument" in
        --app:fct) APP_NAME=fct ;;
        --hosted) MODE=/Hosted ;;
        *) echo "Usage: $0 --app:fct [--hosted]" >&2; exit 1 ;;
    esac
done
if [[ "$APP_NAME" != fct ]]; then
    echo "Usage: $0 --app:fct [--hosted]" >&2
    exit 1
fi

APP="$SCRIPT_DIR/.build/bin/FullControlTest"
if [[ ! -x "$APP" ]]; then
    echo "FullControlTest is not built. Run $SCRIPT_DIR/build.sh first." >&2
    exit 1
fi
exec "$APP" "$MODE"
