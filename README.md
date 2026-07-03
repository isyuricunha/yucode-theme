# yucode

[![License: AGPL-3.0](https://img.shields.io/badge/license-AGPL--3.0-C15F3C)](LICENSE)
[![Hermes Agent](https://img.shields.io/badge/for-Hermes%20Agent-D9834F)](https://github.com/NousResearch/hermes-agent)
[![install.sh](https://img.shields.io/badge/install-install.sh-87C38F)](install.sh)

A minimal skin for [Hermes Agent](https://github.com/NousResearch/hermes-agent)'s CLI, styled after Claude Code's terminal look - coral accent, neutral grays, no rainbow diff colors fighting each other, and a small custom logo/banner instead of the default mascot art.

The default Hermes output can get noisy: lots of red/green diff blocks and stacked progress comments. **yucode** fixes the colors and branding, and the install script flips a few display settings (compact, new tool progress) and switches the default interface to the TUI, which renders user/agent messages far more evenly than the classic CLI.

---

## Table of contents

- [Files](#files)
- [Requirements](#requirements)
- [The scripts](#the-scripts)
- [Quick install (EOF)](#quick-install-eof)
- [Standard install](#standard-install)
- [Manual install](#manual-install)
- [Customizing](#customizing)
- [Color palette](#color-palette)
- [Banner and hero](#banner-and-hero)
- [Uninstall](#uninstall)
- [License](#license)

## Files

| File | What it is |
|---|---|
| [`yucode.yaml`](yucode.yaml) | The skin file itself. Drop it into `~/.hermes/skins/` and reference it as `display.skin: yucode`. |
| [`install.sh`](install.sh) | Installer: copies the skin, applies the display settings, and sets the TUI as the default interface. |
| [`EOF.md`](EOF.md) | The "quick install" - a single copy-paste block that drops the skin into place without cloning the repo. |
| [`LICENSE`](LICENSE) | AGPL-3.0. |

## Requirements

- Hermes Agent already installed, with a `~/.hermes/config.yaml` present.

## The scripts

### `install.sh`

The recommended path. Run it from the repo directory:

```bash
./install.sh
```

It does five things, in order:

1. **Cleans stale skins** - removes any `yucode.yaml` under `~/.hermes/skins/`, including case variants like `YuCode.yaml`. Hermes gets confused if two files with the same name in different casing sit side by side.
2. **Installs the skin** - copies `yucode.yaml` into `~/.hermes/skins/`.
3. **Backs up config** - timestamped copy of `~/.hermes/config.yaml` (`.bak.<YYYYMMDD_HHMMSS>`), so the previous state is always recoverable.
4. **Applies display settings** - sets `display.skin: yucode`, `display.compact: true`, and `display.tool_progress: new`. These cut down the diff/patch noise.
5. **Flips the interface** - sets `display.interface: tui`, so a bare `hermes` launches the modern TUI instead of the classic REPL.

`set -euo pipefail` is on, so the script aborts on the first error. It never deletes the config - only backs it up and patches keys with `sed`.

### `EOF.md`

Not a script, but a single self-contained shell block (`cat ... << 'EOF'`) that writes the skin straight into `~/.hermes/skins/yucode.yaml` without cloning anything. Useful for a fast, throw-free apply on a remote box, or when you already have the display settings the way you want them and only need the file. See [Quick install (EOF)](#quick-install-eof) below.

## Quick install (EOF)

The no-clone, no-script path - just a shell block that writes the file into place. Good for remote machines or when the rest of `~/.hermes/config.yaml` is already configured and you only want the skin ready to go.

```bash
mkdir -p ~/.hermes/skins
cat > ~/.hermes/skins/yucode.yaml << 'EOF'
name: YuCode
description: Minimal, Code's terminal aesthetic

colors:
  banner_border: "#C15F3C"
  banner_title: "#C15F3C"
  banner_accent: "#D9834F"
  banner_dim: "#6B6B6B"
  banner_text: "#D4D4D4"
  ui_accent: "#C15F3C"
  ui_label: "#8C8C8C"
  ui_ok: "#87C38F"
  ui_error: "#E50000"
  ui_warn: "#D9A066"
  prompt: "#D4D4D4"
  input_rule: "#4A4A4A"
  response_border: "#4A4A4A"
  response_text: "#D4D4D4"
  session_label: "#C15F3C"
  session_border: "#3A3A3A"
  reasoning_border: "#4A4A4A"
  reasoning_text: "#8C8C8C"
  status_bar_bg: "#1E1E1E"
  voice_status_bg: "#1E1E1E"
  selection_bg: "#8B4530"
  completion_menu_bg: "#1E1E1E"
  completion_menu_current_bg: "#3A3A3A"
  completion_menu_meta_bg: "#1E1E1E"
  completion_menu_meta_current_bg: "#2C2C2C"

spinner:
  waiting_verbs:
    ["vibing","sacrificing RAM","summoning Stack Overflow","asking the rubber duck","waiting for CI","petting the server","warming quantum bits","thinking"]
  thinking_verbs:
    ["grep'ing the universe","chasing null pointers","compressing brainwaves","reading docs (finally)","rewriting history","executing side quests","optimizing bad decisions","running benchmarks","debugging reality"]

branding:
  agent_name: "YuCode"
  response_label: " ● YuCode "
  tool_prefix: "●"

wings:
  - ["", ""]

banner_logo: |
  [bold #C15F3C]YuCode[/]

banner_hero: |
  [bold #C15F3C]██╗   ██╗[/]
  [bold #C15F3C]╚██╗ ██╔╝[/]
  [bold #D9834F] ╚████╔╝ [/]
  [bold #D9834F]  ╚██╔╝  [/]
  [dim #6B6B6B]   ██║   [/]
  [dim #6B6B6B]   ╚═╝   [/]
EOF
```

Then point Hermes at it. In a session: `/skin yucode`. Or edit `~/.hermes/config.yaml`:

```yaml
display:
  skin: yucode
  interface: tui
```

Exit and run `hermes` again. The TUI picks up the colors immediately; the classic CLI banner only refreshes on next start. The full content of the block above also lives in [`EOF.md`](EOF.md) - the repo's quick-install reference.

## Standard install

```bash
git clone <this-repo>
cd yucode
./install.sh
```

After running it, restart the session (exit, then run `hermes` again). The TUI picks up the skin colors immediately; the classic CLI's ASCII banner only refreshes on next start too.

One-off classic CLI, when needed: `hermes --cli`.

## Manual install

If you prefer not to run the script (or you are reviewing this before trusting it):

```bash
mkdir -p ~/.hermes/skins
cp yucode.yaml ~/.hermes/skins/yucode.yaml
```

Then either run `/skin yucode` in a session, or edit `~/.hermes/config.yaml` and set:

```yaml
display:
  skin: yucode
  interface: tui
```

## Customizing

All keys inherit from the built-in `default` skin, so you only need to override what you want to change. The full key reference is in Hermes Agent's own skin docs.

## Color palette

The palette is intentionally tight - one accent (coral), a secondary accent for the lower half of the banner, muted gray for labels, and dark grays for borders/backgrounds. No pure white, no pure black.

| Purpose | Key | Color |
|---|---|---|
| Accent / borders / labels | `ui_accent`, `banner_border`, `banner_title`, `session_label` | `#C15F3C` |
| Secondary accent (banner lower) | `banner_accent` | `#D9834F` |
| Muted text / labels | `ui_label`, `banner_dim`, `reasoning_text` | `#6B6B6B` / `#8C8C8C` |
| Main text | `banner_text`, `prompt`, `response_text` | `#D4D4D4` |
| Backgrounds | `status_bar_bg`, `voice_status_bg`, `completion_menu_bg` | `#1E1E1E` |
| Borders / dividers | `session_border`, `input_rule`, `response_border` | `#3A3A3A` / `#4A4A4A` |
| Success | `ui_ok` | `#87C38F` |
| Error | `ui_error` | `#E50000` |
| Warning | `ui_warn` | `#D9A066` |
| Selection | `selection_bg` | `#8B4530` |

## Banner and hero

- `banner_logo` replaces the big block-letter "HERMES-AGENT" title with a small coral `YuCode` wordmark.
- `banner_hero` replaces the default caduceus mascot art with a compact block-style `Y`.

Both support Rich console markup, so each line can carry its own color tag (`[bold #C15F3C]...[/]`, `[dim #6B6B6B]...[/]`).

## Uninstall

```bash
rm ~/.hermes/skins/yucode.yaml
# then, in ~/.hermes/config.yaml, set display.skin: default  (or remove the line)
```

## License

[AGPL-3.0](LICENSE) © isyuricunha
