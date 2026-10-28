#!/bin/sh
# tb-tray installer - user mode only, no root needed.
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

mkdir -p "$HOME/.local/bin" "$HOME/.config/autostart"
install -m 0755 "$DIR/tb-tray" "$HOME/.local/bin/tb-tray"
sed "s|__HOME__|$HOME|g" "$DIR/autostart/tb-tray.desktop" \
  > "$HOME/.config/autostart/tb-tray.desktop"

echo "installed: $HOME/.local/bin/tb-tray"
echo "autostart: $HOME/.config/autostart/tb-tray.desktop (next login)"
echo "start now:   ~/.local/bin/tb-tray &"
