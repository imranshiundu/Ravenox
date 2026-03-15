# 👻 Ravenox: The Architectural Diet (Ghost Mode)

Achieve a sub-200ms wake-up time with zero idle CPU burn by converting Ravenox into a "Ghost."

## 1. Webhooks: The Doorbell vs. The Paranoia
Polling is "Paranoia"—constantly asking the server for updates. Webhooks are the "Doorbell"—Ravenox sleeps until a message hits the server.

- **Polled (Default)**: 1-2s delay, constant CPU/RAM burn.
- **Webhook (Ghost Mode)**: Sub-10ms server reaction, 0% idle CPU.

### Deployment Options:
- **Cloudflare Workers (True Sleep)**: Sub-5ms boot. Ravenox only exists during the request.
- **Local Express Listener (Idle Listener)**: Suspended in RAM until network I/O wakes it.

## 2. Dodging the .jsonl Trap (Context Compression)
Waking up in 10ms doesn't matter if Ravenox takes 10 seconds to read a massive session log.

### The Fix: Sliding Window & Summarization
- **Hard Cap**: Force Ravenox to only send the **last 5 raw messages** to the LLM.
- **State Compression**: Use **Gemini 1.5 Flash** to summarize older history into a single, dense "State" paragraph.
- **Result**: Tiny (200-token) payloads = lightning-fast LLM generation.

## 3. Optimization Checklist (The Bloat Audit)
The following modules are "Heavy" and should be pruned for Pi Zero or Microcontroller setups:

| Component | Resource Usage | Optimization Path |
| :--- | :--- | :--- |
| **Playwright/Chromium** | ~150MB RAM | Use `RAVENOX_LIGHT_MODE=1` to disable browser. |
| **Sharp** | ~20MB RAM | Prune `skills/vision` if not doing image editing. |
| **Python tools/** | ~30MB RAM | Use native JS replacements for simple tasks. |
| **FFmpeg** | High CPU Burst | Use external APIs for media compression. |

## 4. Configuration
Edit your `ravenox.json`:
```json
{
  "agent": {
    "compactionThreshold": 10,
    "maxRawMessages": 5,
    "summaryModel": "gemini-1.5-flash"
  },
  "gateway": {
    "mode": "webhook"
  }
}
```

## 5. Bare-Metal (MimiClaw)
For $5 ESP32 microcontrollers, use the MimiClaw port which rips out Linux and Node.js entirely, running the core loop on bare metal.
