# yucode

A minimal skin for [Hermes Agent](https://github.com/NousResearch/hermes-agent)'s CLI, styled after Claude Code's terminal look. Coral accent, neutral grays, no rainbow diff colors fighting each other.

I made this because the default Hermes output got too noisy for me, lots of red/green diff blocks and repeated progress comments stacked on screen. This skin does not fix the verbosity by itself (that is a display setting, see below), it just makes the colors calmer and closer to what I am used to from Claude Code.

## What is in this repo

- `yucode.yaml`: the skin file itself.
- `install.sh`: installs the skin and applies the display settings I use alongside it.

## Requirements

- Hermes Agent already installed, with a `~/.hermes/config.yaml` present.

## Install

```bash
git clone <this-repo>
cd yucode
./install.sh
```

The script does four things:

1. Removes any stale `yucode.yaml` files under `~/.hermes/skins/` first, including case mismatches like `YuCode.yaml`. Hermes gets confused if two files with the same name in different casing sit side by side.
2. Copies `yucode.yaml` into `~/.hermes/skins/`.
3. Backs up my existing `config.yaml` (timestamped, just in case).
4. Sets `display.skin: yucode`, `display.compact: true`, and `display.tool_progress: new`. The last two are what actually cut down the diff/patch noise from the screenshot that started this whole thing.

After running it, restart the session (exit, then run `hermes` again) so the banner colors pick it up. Prompt and TUI colors apply instantly with `/skin yucode` inside an active session, but the ASCII banner only refreshes on next start.

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

## Credits

Skin schema and the whole `~/.hermes/skins/` convention come from Hermes Agent's own skin engine and the community skin packs (`joeynyc/hermes-skins`, `Sahil-SS9/hermes-Custom-CLI-Themes`). I just wrote a palette that matches Claude Code's look.

## License

AGPL-3.0
