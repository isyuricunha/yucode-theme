# EOF - quick install

The no-clone, no-script path: a single shell block that writes `yucode.yaml` straight into place. Useful on remote boxes, or when `~/.hermes/config.yaml` is already set up the way you want and you just need the skin file.

## 1. Drop the skin

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
    [
      "vibing",
      "sacrificing RAM",
      "summoning Stack Overflow",
      "asking the rubber duck",
      "waiting for CI",
      "petting the server",
      "warming quantum bits",
      "thinking",
    ]

  thinking_verbs:
    [
      "grep'ing the universe",
      "chasing null pointers",
      "compressing brainwaves",
      "reading docs (finally)",
      "rewriting history",
      "executing side quests",
      "optimizing bad decisions",
      "running benchmarks",
      "debugging reality",
    ]

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

## 2. Point Hermes at it

In a running session:

```
/skin yucode
```

Or edit `~/.hermes/config.yaml`:

```yaml
display:
  skin: yucode
  interface: tui
```

## 3. Restart

```bash
/exit
hermes
```

The TUI picks up the colors immediately. The classic CLI banner only refreshes on next start. For a one-off classic CLI session: `hermes --cli`.

---

## When to use this

- **EOF (this file)** - just the skin, nothing else. Good when `config.yaml` is already configured and you only need the file dropped into place. Fast, no repo dependency.
- **`install.sh`** - the skin **and** the display settings (`skin`, `compact: true`, `tool_progress: new`, `interface: tui`) applied at once, with a backup of `config.yaml`. Good for first install or when you want the full setup.

The content of the block above is identical to [`yucode.yaml`](yucode.yaml). If you prefer to copy from the file, see the [README](README.md) for the `install.sh` path.
