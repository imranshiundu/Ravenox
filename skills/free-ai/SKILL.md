---
name: free-ai
description: Access AI intelligence without an OpenAI or Anthropic API key. Uses free community providers and scrapers to answer questions.
metadata:
  {
    .ravenox":
      {
        "emoji": "🧠",
        "requires": { "bins": ["curl"] },
      },
  }
---

# Free AI (Intelligence Port)

This skill provides an "Intelligence" layer that does not require paid API keys. It uses a rotation of free-tier providers and web scraping techniques adapted from the SPACE-MD/CypherX bot architectures.

## When to use

- When a user asks a question but does not have a configured LLM provider.
- When you need a quick, non-critical AI response.
- Use as a fallback for the main `agent` command.

## Providers Integrated

- **Groq Free Tier**: High-speed inference (requires account but has generous free tier).
- **Community Proxies**: Scraped endpoints from various bot developer communities (Tylor/Dark-Xploit style).
- **Scraper Mode**: Crawling search results and summarizing with local regex logic.

## Usage

```bash
# Internal logic for the assistant
# Hit the free endpoint
curl -X POST "https://api.your-free-provider.com/v1/chat/completions" \
     -H "Content-Type: application/json" \
     -d '{ "model": "gpt-3.5-turbo", "messages": [{"role": "user", "content": "Explain quantum physics"}] }'
```

## Note on Privacy
These providers are free because they are community-hosted. Avoid sending highly sensitive or personal data through this skill.
