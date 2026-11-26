#!/usr/bin/env bash
set -euo pipefail

if [[ "$#" -ne 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi
if [[ ! -r /etc/os-release ]]; then
    echo "Unable to identify the operating system. This script supports Ubuntu only." >&2
    exit 1
fi
source /etc/os-release
if [[ "${ID:-}" != ubuntu ]]; then
    echo "This script supports Ubuntu only. Install equivalent packages for your distribution." >&2
    exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
    echo "Root privileges are required. Run: sudo $0" >&2
    exit 1
fi

apt-get update
apt-get install -y \
    build-essential clang cmake pkg-config dbus-daemon \
    libwayland-dev libxkbcommon-dev libdecor-0-dev libdecor-0-plugin-1-gtk \
    libcairo2-dev libpango1.0-dev libfontconfig-dev libglib2.0-dev liburing-dev
