---
name: titan
description: The "Freight Train" engine for Agent Aurthur. Provides long-term memory, advanced web research, and local machine control.
metadata:
  {
    "openclaw":
      {
        "emoji": "🦾",
        "requires": { "bins": ["python3", "pip3"] },
      },
  }
---

# Titan Bridge (High Autonomy Engine)

This skill bridges Agent Aurthur to the Python-based Titan tools. It enables the "Freight Train" mode when high-level engineering or personal context is needed.

## Features

- **Mem0 (Long-term Memory)**: Remembers user facts across sessions.
- **Tavily (Deep Research)**: Fast, clean web search results.
- **Vision (Local Control)**: Desktop screenshots and clicking for automation.

## Usage

```bash
# Store a fact
python3 tools/memory.py add "User prefers Dark Mode and Python 3.12" 12345

# Find a fact
python3 tools/memory.py search "What is the user's preferred Python version?" 12345

# Perform deep search
python3 tools/search.py "Current price of Bitcoin"

# Control the screen
python3 tools/vision.py screenshot
```

## Configuration

Requires API keys in `.env`:
- `MEM0_API_KEY` (Optional for local)
- `TAVILY_API_KEY`
- `LITELLM_API_KEY` (For the Cost Shield)
