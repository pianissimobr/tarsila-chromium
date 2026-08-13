#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PKG="tarsila-chromium"
V="${1:-2.0.0}"
DEB="${PKG}_${V}_all.deb"
D="$(mktemp -d)"
trap 'rm -rf "$D"' EXIT
cp -a "$SCRIPT_DIR/DEBIAN" "$D/"
cp -a "$SCRIPT_DIR/src/." "$D/"
chmod 755 "$D/usr/local/bin/tarsila-chromium" "$D/usr/local/lib/tarsila/"*.py "$D/DEBIAN/"* 2>/dev/null || true
dpkg-deb --build --root-owner-group "$D" "$DEB"
echo " $DEB"
