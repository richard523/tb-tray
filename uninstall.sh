#!/bin/sh
# tb-tray uninstaller - removes the binary and the autostart entry.
set -eu

rm -f "$HOME/.local/bin/tb-tray" "$HOME/.config/autostart/tb-tray.desktop"
echo "removed binary + autostart entry"
echo "a running instance quits via its menu, or: pkill -f tb-tray"
