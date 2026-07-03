#!/usr/bin/env bash
# install.sh
# Installs the yucode skin for Hermes Agent, applies my preferred display
# settings, and sets the TUI as the default interface.
# Run this from the same directory as yucode.yaml.

set -euo pipefail

SKIN_SOURCE="$(dirname "$0")/yucode.yaml"
SKIN_DEST="$HOME/.hermes/skins/yucode.yaml"
CONFIG_FILE="$HOME/.hermes/config.yaml"

if [ ! -f "$SKIN_SOURCE" ]; then
    echo "error: yucode.yaml not found next to install.sh"
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "error: $CONFIG_FILE not found. Is Hermes Agent installed for this user?"
    exit 1
fi

echo "removing any stale yucode skin files (case mismatches included)"
find "$HOME/.hermes/skins" -maxdepth 1 -iname "yucode.yaml" -delete 2>/dev/null || true

echo "creating skins directory"
mkdir -p "$HOME/.hermes/skins"

echo "copying yucode.yaml to $SKIN_DEST"
cp "$SKIN_SOURCE" "$SKIN_DEST"

echo "backing up config.yaml"
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak.$(date +%Y%m%d_%H%M%S)"

echo "setting skin: yucode in config.yaml"
sed -i 's/^\(\s*skin:\s*\).*/\1yucode/' "$CONFIG_FILE"

echo "enabling compact display"
sed -i 's/^\(\s*compact:\s*\).*/\1true/' "$CONFIG_FILE"

echo "setting tool_progress to new"
sed -i 's/^\(\s*tool_progress:\s*\).*/\1new/' "$CONFIG_FILE"

echo "setting the TUI as the default interface"
if grep -q "^\s*interface:" "$CONFIG_FILE"; then
    sed -i 's/^\(\s*interface:\s*\).*/\1tui/' "$CONFIG_FILE"
else
    sed -i '/^display:/a\  interface: tui' "$CONFIG_FILE"
fi

echo ""
echo "done. yucode is installed and the TUI is now the default interface."
echo "start a fresh session (exit and run hermes again) to see everything applied."
echo "run hermes --cli for a one-off classic CLI session if you ever need it."
