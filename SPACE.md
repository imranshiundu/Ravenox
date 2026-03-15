# 🌌 Ravenox: SPACE-MD Framework (Titan Blueprint)

## Core Philosophy
Ravenox operates in a **Dormant Hybrid Architecture**. It remains a disciplined passive listener (Bot Mode) until explicitly triggered for heavy engineering (Titan Mode).

## The Skeleton (Zero-Token Navigation)
By following this blueprint, the Agent avoids scanning large directories.
- **ROOT**: `/home/imran/Code/Managers`
- **CLI**: `bin.ravenox.mjs`
- **SKILLS**: `skills/`
- **TOOLS**: `tools/` (Python Heavy Load)
- **GATEWAY**: `src/provider-web.ts`

## Rules of Engagement (Anti-Hallucination)
1. **Dormant First**: Use GPT-4o-mini or local regex for `/status`, `/info`, `/files`.
2. **Lazy-Load**: Only boot Python dependencies (`Mem0`, `Tavily`) when required.
3. **Rigid Structure**: Never search for files; use `STRUCTURE.txt` for context.
4. **Token Budgeting**: Summarize conversations into Mem0 "Facts" to keep context windows small.

## Integrated Titan Tools
- **Memory**: Persistent facts via Mem0 (`tools/memory.py`).
- **Research**: Clean AI-ready Markdown via Tavily (`tools/search.py`).
- **Action**: Screen control via PyAutoGUI/MSS (`tools/vision.py`).
- **Orchestra**: Model switching/failover via LiteLLM (`tools/proxy_server.py`).

## File Structure Registry (STRUCTURE.txt)
```text
.
├──.ravenox.mjs         # Entry Point
├── package.json       # Dependencies
├── tools/             # Python Titan Suite
│   ├── memory.py      # Mem0 interface
│   ├── search.py      # Tavily interface
│   ├── vision.py      # Action/Vision suite
│   └── requirements.txt
├── skills/            # Extensible Skills
│   ├──.ravenox-core/   # SPACE-MD Legacy
│   ├── free-ai/       # No-API Intelligence
│   └── titan/         # Advanced Bridge
└── src/               # Core Gateway Logic
```
