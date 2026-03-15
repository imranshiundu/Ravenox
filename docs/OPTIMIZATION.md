# 👻 Agent Aurthur: The Architectural Diet

Run Agent Aurthur on minimal hardware (Pi Zero, ESP32) or for $0/mo on Cloudflare.

## 1. Serverless Deployment (moltworker)
Porting the gateway to Cloudflare Workers eliminates idle costs.
- **Config**: Set `gateway.mode="webhook"`.
- **Compute**: Arthur only runs when a message hits your endpoint.
- **Note**: Requires the `moltworker` adapter (see `extensions/serverless`).

## 2. Bare-Metal (MimiClaw)
For absolute minimum weight, use the MimiClaw approach.
- **Runtime**: Rips out Node.js and Linux.
- **Hardware**: Fits on an ESP32 or similar microcontroller.
- **Connectivity**: Uses lightweight MQTT or WebSockets directly.

## 3. Aggressive Context Compaction
Keep your API calls small and fast.
Edit your `arthur.json` (or `~/.arthur/config.json`):
```json
{
  "agent": {
    "compactionThreshold": 10,
    "summaryMode": "bullet_points"
  }
}
```
*Arthur will summarize the session every 10 messages and delete the raw logs.*

## 4. Model Tiering (Flash-First)
The "Dormant Router" ensures you only use heavy models when needed.
- **Default**: `gemini-1.5-flash` or `claude-3-haiku`.
- **Escalation**: Only switches to `sonnet` or `pro` for code engineering or deep research.

## 5. Skill Pruning
Remove heavy dependencies by deleting unused skills:
```bash
rm -rf skills/vision
rm -rf skills/browser
```
*Arthur will automatically fallback to text-only mode.*

## 6. Webhooks (Sleep Mode)
Switch from Polling to Webhooks to drop idle CPU to 0%.
- **Telegram**: `arthur channels telegram set-webhook https://your-domain.com/webhook`
- **WhatsApp**: Requires a webhook-compatible gateway (see `src/channels/whatsapp`).
