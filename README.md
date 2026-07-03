# yucode

A minimal skin for [Hermes Agent](https://github.com/NousResearch/hermes-agent)'s CLI, styled after Claude Code's terminal look. Coral accent, neutral grays, no rainbow diff colors fighting each other, and a small custom logo/banner instead of the default mascot art.

I made this because the default Hermes output got too noisy for me, lots of red/green diff blocks and repeated progress comments stacked on screen. The skin fixes the colors and branding. The install script also flips a couple of display settings and switches the default interface to the TUI, which renders user/agent messages far more evenly than the classic CLI.

## What is in this repo

- `yucode.yaml`: the skin file itself.
- `install.sh`: installs the skin, applies the display settings I use alongside it, and sets the TUI as the default interface.

## Requirements

- Hermes Agent already installed, with a `~/.hermes/config.yaml` present.

## Install

```bash
git clone <this-repo>
cd yucode
./install.sh
```

The script does five things:

1. Removes any stale `yucode.yaml` files under `~/.hermes/skins/` first, including case mismatches like `YuCode.yaml`. Hermes gets confused if two files with the same name in different casing sit side by side.
2. Copies `yucode.yaml` into `~/.hermes/skins/`.
3. Backs up my existing `config.yaml` (timestamped, just in case).
4. Sets `display.skin: yucode`, `display.compact: true`, and `display.tool_progress: new`. These cut down the diff/patch noise that started this whole project.
5. Sets `display.interface: tui`, so a bare `hermes` launches the modern TUI instead of the classic REPL.

After running it, restart the session (exit, then run `hermes` again). The TUI picks up the skin colors immediately; the classic CLI's ASCII banner only refreshes on next start too.

If I ever want the classic CLI back for a single run: `hermes --cli`.

## Manual install

If I do not want to run the script (or I am reviewing this before trusting it):

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

All keys inherit from the built-in `default` skin, so I only need to override what I want to change. Full key reference is in Hermes Agent's own skin docs. The palette I used here:

| Purpose | Color |
|---|---|
| Accent / borders / labels | `#D97757` |
| Secondary accent | `#E8A87C` |
| Muted text / labels | `#8C8C8C` |
| Main text | `#D4D4D4` |
| Backgrounds | `#1E1E1E` |
| Borders / dividers | `#3A3A3A` / `#4A4A4A` |
| Success | `#87C38F` |
| Error | `#E5707E` |
| Warning | `#D9A066` |

The `banner_logo` key replaces the big block-letter "HERMES-AGENT" title with a small coral "YuCode" wordmark. The `banner_hero` key replaces the default caduceus mascot art with a compact block-style "Y". Both support Rich console markup, so each line can carry its own color tag.

## License

AGPL-3.0
