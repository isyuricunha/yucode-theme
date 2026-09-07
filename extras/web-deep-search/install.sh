#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$HOME/.hermes/plugins/web/deep-search"

if ! command -v hermes >/dev/null 2>&1; then
    echo "error: hermes command not found"
    exit 1
fi

mkdir -p "$DEST_DIR"
cp "$SRC_DIR/plugin.yaml" "$DEST_DIR/plugin.yaml"
cp "$SRC_DIR/__init__.py" "$DEST_DIR/__init__.py"

hermes plugins enable web-deep-search >/dev/null

echo "installed Hermes deep web-search overrides"
echo "  Exa:   type=deep (keyed SDK path)"
echo "  Tavily: search_depth=advanced"
echo "restart Hermes/gateway sessions so the plugin is reloaded"
