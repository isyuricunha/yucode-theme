#!/usr/bin/env bash
# install.sh
# Installs the yucode skin for Hermes Agent and applies the display settings
# that make the TUI behave closer to Claude Code.

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

echo "removing any stale yucode skin files (case-insensitive)"
mkdir -p "$HOME/.hermes/skins"
find "$HOME/.hermes/skins" -maxdepth 1 -iname "yucode.yaml" -delete 2>/dev/null || true

echo "copying yucode.yaml to $SKIN_DEST"
cp "$SKIN_SOURCE" "$SKIN_DEST"

echo "backing up config.yaml"
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak.$(date +%Y%m%d_%H%M%S)"

# Prefer Hermes' own config writer. It understands nested dotted paths and
# preserves the rest of the user's config without brittle YAML surgery.
if command -v hermes >/dev/null 2>&1 && hermes config set display.skin yucode >/dev/null 2>&1; then
    echo "applying Claude-like TUI settings"
    hermes config set display.compact true >/dev/null
    hermes config set display.tool_progress new >/dev/null
    hermes config set display.interface tui >/dev/null

    # Claude Code does not show Hermes' reasoning accordion/recap by default.
    hermes config set display.show_reasoning false >/dev/null
    hermes config set display.sections.thinking hidden >/dev/null

    # Replace the default kawaii face + rotating verb with the quiet braille
    # spinner. The unicode style intentionally has no verb text.
    hermes config set display.tui_status_indicator unicode >/dev/null
else
    echo "warning: 'hermes config set' is unavailable; applying compatible settings with sed"

    # Existing flat keys: replace when present, otherwise add directly under display:.
    set_display_key() {
        local key="$1" value="$2"
        if grep -Eq "^[[:space:]]{2}${key}:" "$CONFIG_FILE"; then
            sed -i -E "s|^([[:space:]]{2}${key}:[[:space:]]*).*|\\1${value}|" "$CONFIG_FILE"
        else
            sed -i "/^display:/a\\  ${key}: ${value}" "$CONFIG_FILE"
        fi
    }

    set_display_key skin yucode
    set_display_key compact true
    set_display_key tool_progress new
    set_display_key interface tui
    set_display_key show_reasoning false
    set_display_key tui_status_indicator unicode

    # TUI section override: hide the reasoning accordion completely.
    if grep -Eq '^  sections:' "$CONFIG_FILE"; then
        if grep -Eq '^    thinking:' "$CONFIG_FILE"; then
            sed -i -E 's|^([[:space:]]{4}thinking:[[:space:]]*).*|\1hidden|' "$CONFIG_FILE"
        else
            sed -i '/^  sections:/a\    thinking: hidden' "$CONFIG_FILE"
        fi
    else
        sed -i '/^display:/a\  sections:\n    thinking: hidden' "$CONFIG_FILE"
    fi
fi

echo ""
echo "done. yucode is installed with Claude-like colors and TUI behavior."
echo "thinking panels are hidden and the kawaii status indicator is replaced by unicode."
echo "start a fresh Hermes session to see everything applied."
echo "run hermes --cli for a one-off classic CLI session if you ever need it."
