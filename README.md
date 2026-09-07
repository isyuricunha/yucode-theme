# YuCode

[![License: AGPL-3.0](https://img.shields.io/badge/license-AGPL--3.0-D77757)](LICENSE)
[![Hermes Agent](https://img.shields.io/badge/for-Hermes%20Agent-D77757)](https://github.com/NousResearch/hermes-agent)
[![install.sh](https://img.shields.io/badge/install-install.sh-4EBA65)](install.sh)

A minimal dark skin for [Hermes Agent](https://github.com/NousResearch/hermes-agent), built around the Claude Code dark-terminal palette while keeping Hermes' own TUI and workflow.

YuCode keeps the useful observability — **Thinking** and **Tool Calls stay in the chat** — but makes the interface quieter: both sections are collapsed by default, the noisy kawaii faces/novelty status phrases are removed, and the busy indicator is reduced to a small Unicode spinner.

The result is simple: Claude-like colors, Hermes UX, YuCode branding.

---

## What it changes

- Claude Code-inspired dark color palette mapped to Hermes skin tokens.
- Compact YuCode banner and block-style `Y` hero.
- TUI enabled as the default Hermes interface.
- Thinking remains available in-chat, collapsed by default.
- Tool calls remain available in-chat, collapsed by default.
- `tool_progress: all`, so tool lifecycle events are not discarded just to reduce visual noise.
- Unicode busy indicator instead of kawaii faces and rotating phrases.
- Compact display enabled.
- Timestamped backup of `~/.hermes/config.yaml` before installation.

## Files

| File | Purpose |
|---|---|
| [`yucode.yaml`](yucode.yaml) | The YuCode skin. |
| [`install.sh`](install.sh) | Installs the skin and applies the recommended TUI settings. |
| [`EOF.md`](EOF.md) | No-clone copy/paste installation. |
| [`LICENSE`](LICENSE) | AGPL-3.0. |

## Requirements

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) installed.
- An existing `~/.hermes/config.yaml`.
- A terminal with true-color support is recommended.

## Recommended install

```bash
git clone https://github.com/isyuricunha/yucode-theme.git
cd yucode-theme
./install.sh
```

Then restart Hermes:

```bash
hermes
```

The installer:

1. removes stale case-variant copies of `yucode.yaml`;
2. copies the current skin to `~/.hermes/skins/yucode.yaml`;
3. backs up `~/.hermes/config.yaml` with a timestamp;
4. sets `display.skin` to `yucode`;
5. enables compact output and the TUI;
6. keeps reasoning enabled;
7. keeps all tool-call lifecycle events enabled;
8. collapses Thinking and Tool Calls by default;
9. switches the TUI status indicator to the quiet Unicode style.

The effective display setup is:

```yaml
display:
  skin: yucode
  interface: tui
  compact: true
  show_reasoning: true
  tool_progress: all
  tui_status_indicator: unicode
  sections:
    thinking: collapsed
    tools: collapsed
```

> `tool_progress: all` is intentional. YuCode keeps the data and lets the TUI accordion control visual density instead of suppressing repeated tool events with `new` mode.

## Quick install without cloning

See [`EOF.md`](EOF.md) for a self-contained copy/paste block that writes the exact current `yucode.yaml` into `~/.hermes/skins/` and applies the recommended display settings.

## Manual install

If you only want the skin file:

```bash
mkdir -p ~/.hermes/skins
cp yucode.yaml ~/.hermes/skins/yucode.yaml
```

Then select it in Hermes:

```text
/skin yucode
```

Or configure it manually:

```yaml
display:
  skin: yucode
```

A one-off classic CLI session is still available with:

```bash
hermes --cli
```

## Color palette

YuCode maps the Claude Code dark palette onto the closest Hermes tokens. The terminal itself still controls the actual terminal background, so a dark profile around `#0C0C0C` gives the closest result.

| Purpose | Color |
|---|---:|
| Claude / YuCode accent | `#D77757` |
| Accent shimmer | `#EB9F7F` |
| Main assistant text | `#CCCCCC` |
| User / strong text | `#FFFFFF` |
| Inactive text | `#999999` |
| Subtle borders | `#505050` |
| Prompt border | `#888888` |
| Success | `#4EBA65` |
| Error | `#FF6B80` |
| Warning | `#FFC107` |
| Selection | `#264F78` |
| User-message / menu surface | `#373737` |
| Hover surface | `#464646` |
| Shell/tool accent | `#FD5DB1` |
| Status/menu background | `#0C0C0C` |

### Token mapping

```yaml
colors:
  banner_border: "#505050"
  banner_title: "#D77757"
  banner_accent: "#D77757"
  banner_dim: "#999999"
  banner_text: "#CCCCCC"

  ui_accent: "#D77757"
  ui_label: "#999999"
  ui_ok: "#4EBA65"
  ui_error: "#FF6B80"
  ui_warn: "#FFC107"

  prompt: "#FFFFFF"
  input_rule: "#888888"
  response_border: "#505050"
  response_text: "#CCCCCC"

  session_label: "#D77757"
  session_border: "#505050"
  reasoning_border: "#505050"
  reasoning_text: "#999999"

  status_bar_bg: "#0C0C0C"
  status_bar_text: "#999999"
  status_bar_strong: "#FFFFFF"
  status_bar_dim: "#505050"
  status_bar_good: "#4EBA65"
  status_bar_warn: "#FFC107"
  status_bar_bad: "#FF6B80"
  status_bar_critical: "#FF6B80"
  voice_status_bg: "#0C0C0C"

  selection_bg: "#264F78"
  completion_menu_bg: "#0C0C0C"
  completion_menu_current_bg: "#373737"
  completion_menu_meta_bg: "#0C0C0C"
  completion_menu_meta_current_bg: "#464646"

  shell_dollar: "#FD5DB1"
```

## Thinking, tools and busy indicator

YuCode intentionally does **not** hide reasoning or tool calls.

In the TUI they stay in the transcript as compact, collapsible sections:

```text
› user message

├ ▸ Thinking  ~N tokens
├ ▸ Tool calls (N)

● assistant response
```

The cosmetic Hermes spinner content is blanked in the skin, and the installer also sets:

```yaml
display:
  tui_status_indicator: unicode
```

That removes the rotating faces and novelty phrases while preserving a minimal indication that the agent is still working.

## Banner and branding

YuCode keeps its own identity instead of copying Claude Code's layout:

- `banner_logo` shows the `YuCode` wordmark.
- `banner_hero` renders the compact block-style `Y`.
- `prompt_symbol` is `❯`.
- tool rows use `●` as their prefix.

The skin uses Rich markup, so the banner colors are defined directly in [`yucode.yaml`](yucode.yaml).

## Updating

From an existing clone:

```bash
cd yucode-theme
git pull
./install.sh
```

The installer backs up the Hermes config every time before applying settings.

## Uninstall

Remove the skin:

```bash
rm -f ~/.hermes/skins/yucode.yaml
```

Then switch back to another skin, for example:

```bash
hermes config set display.skin default
```

YuCode also changes a few display preferences. If you want to restore your exact previous configuration, use one of the timestamped `~/.hermes/config.yaml.bak.*` backups created by `install.sh`.

## License

[AGPL-3.0](LICENSE) © isyuricunha
