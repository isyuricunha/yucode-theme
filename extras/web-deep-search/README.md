# Hermes deep web search override

Optional user plugin for Hermes Agent. It leaves the Hermes installation untouched and re-registers the bundled `exa` and `tavily` web providers at user-plugin priority.

Defaults applied to `web_search`:

- **Exa**: `type="deep"` on the keyed SDK path.
- **Tavily**: `search_depth="advanced"`.

Hermes currently exposes backend selection and provider tiers in `config.yaml`, but it does not expose Exa's search `type` or Tavily's `search_depth` as native config options.

## Install

```bash
./extras/web-deep-search/install.sh
```

The installer copies the plugin to:

```text
~/.hermes/plugins/web/deep-search/
```

and enables `web-deep-search` through Hermes' plugin CLI. Restart Hermes (and any running gateway process) after installation.

## Notes

- Exa Deep requires the normal keyed Exa SDK path. If Hermes is explicitly pinned to Exa's anonymous/keyless tier, the plugin preserves the keyless search path because that MCP surface does not expose Exa's `type` parameter.
- Tavily Advanced is sent through the same auth/keyless path Hermes already selected. Tavily charges Advanced Search at a higher credit rate than Basic Search.
- `web_extract` behavior is unchanged; this override only changes search depth/type.

## Remove

```bash
hermes plugins disable web-deep-search
rm -rf ~/.hermes/plugins/web/deep-search
```

Restart Hermes afterward and the bundled Exa/Tavily providers take over again.
