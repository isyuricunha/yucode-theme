from __future__ import annotations

import logging
from typing import Any, Dict

from plugins.web._common import (
    SEARCH_LIMIT_CAP,
    keyless_search,
    provider_env,
    run_search,
    search_ok,
    use_keyless,
    web_hit,
)
from plugins.web.exa.provider import ExaWebSearchProvider, _get_exa_client
from plugins.web.tavily.provider import (
    TavilyWebSearchProvider,
    _SEARCH_PAYLOAD,
    _auth,
    _normalize_tavily_search_results,
    _tavily_request,
)

logger = logging.getLogger(__name__)


class DeepExaWebSearchProvider(ExaWebSearchProvider):
    """Hermes' Exa provider with Exa Deep as the keyed search default."""

    def search(self, query: str, limit: int = 5) -> Dict[str, Any]:
        def _body() -> Dict[str, Any]:
            # Hermes' anonymous Exa MCP path does not expose the Exa `type`
            # parameter, so preserve its normal keyless behavior there.
            if use_keyless("exa", provider_env("EXA_API_KEY")):
                return keyless_search("Exa", "exa", query, limit, logger)

            logger.info("Exa deep search: '%s' (limit=%d)", query, limit)
            response = _get_exa_client().search(
                query,
                num_results=limit,
                type="deep",
                contents={"highlights": True},
            )
            return search_ok([
                web_hit(r.url or "", r.title or "", " ".join(r.highlights or []), i + 1)
                for i, r in enumerate(response.results or [])
            ])

        return run_search("Exa", logger, _body, sdk=True)


class AdvancedTavilyWebSearchProvider(TavilyWebSearchProvider):
    """Hermes' Tavily provider with Advanced search as the default."""

    def search(self, query: str, limit: int = 5) -> Dict[str, Any]:
        def _body() -> Dict[str, Any]:
            key, missing, prefix = _auth("search")
            if missing:
                return {"success": False, "error": missing}

            logger.info("Tavily %sadvanced search: '%s' (limit=%d)", prefix, query, limit)
            payload = {
                "query": query,
                "max_results": min(limit, SEARCH_LIMIT_CAP),
                **_SEARCH_PAYLOAD,
                "search_depth": "advanced",
            }
            return _normalize_tavily_search_results(
                _tavily_request("search", payload, api_key=key)
            )

        return run_search("Tavily", logger, _body)


def register(ctx) -> None:
    # User web-provider plugins are loaded after bundled providers. Re-registering
    # the same provider names replaces the bundled instances without modifying
    # the Hermes installation itself.
    ctx.register_web_search_provider(DeepExaWebSearchProvider())
    ctx.register_web_search_provider(AdvancedTavilyWebSearchProvider())
