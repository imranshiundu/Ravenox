# Agent Aurthur 🤖🚀

**Agent Aurthur** is a state-of-the-art, high-autonomy personal AI assistant designed to run on your own hardware. It is built for absolute speed, total privacy, and sovereign control. It is a performance-tuned superset of the OpenClaw codebase.

> [!NOTE]
> **Lineage Credit**: Agent Aurthur is a performance-tuned distribution of [OpenClaw](https://github.com/arthur/arthur). We acknowledge and credit the OpenClaw team for the foundational code. Agent Aurthur maintains **100% feature parity** with OpenClaw—you lose nothing while gaining everything.

## 📊 Specification & Efficiency Comparison

Agent Aurthur is engineered to be a "Ghost"—consuming zero resources when idle and responding in under 200ms.

| Feature | OpenClaw (Standard) | Agent Aurthur (Ghost Mode) |
| :--- | :--- | :--- |
| **Idle CPU Usage** | 2% - 5% (Constant Polling) | **0% (Webhook Triggered)** |
| **Idle RAM Usage** | ~250MB - 400MB | **<128MB (with `LIGHT_MODE=1`)** |
| **Response Latency** | 2s - 10s (Polling + Context Bloat) | **<200ms (Webhook + Compaction)** |
| **Hardware Support** | VPS, PC, Mac | **ESP32, Pi Zero, Cloudflare Workers** |
| **Memory Persistence** | Session-based (Short-term) | **Permanent Fact Graph (Mem0)** |
| **Web Research** | Headless Browser (Heavy) | **Tavily AI Proxy (Instant/Light)** |

---

## 🟢 WhatsApp & Messaging Intelligence
Agent Aurthur treats messaging apps (WhatsApp, Telegram, Slack) as first-class control surfaces. 

- **Ghost Wake-up**: Replaces the latency-heavy "polling" loop with instant **Webhooks**. Aurthur sleeps until a message arrives, waking up in under 10ms.
- **Remote Task Execution**: Trigger complex workflows on your PC via simple messages.
- **Media Support**: Send images or voice notes for Aurthur to analyze using his Vision and Audio pipelines.

## 🛠 Zero-API / Offline Mode (Deterministic Commands)
One of Aurthur's most powerful features is the ability to operate **without an AI API key**. Using deterministic command routing, you can control your machine even when offline or tokens are exhausted.

- **Fast Commands**: Use `/` prefixed messages to bypass the LLM entirely for known tasks.
- **Direct Control**: Aurthur detects commands like `/play`, `/status`, `/lock`, or `/search` and executes them locally using shell scripts or Python tools, saving you money and time.

## 🪐 SPACE-MD Capabilities (Structural Precision)
Integrated from the **SPACE-MD** (CypherX) project, Aurthur uses high-autonomy structural maps to navigate your codebase without wasting tokens.

- **Zero-Token Navigation**: Uses `SPACE.md` and `STRUCTURE.txt` to give the AI a static blueprint of your project. No more expensive directory recursive listings.
- **Context Compaction**: Aurthur dodges the ".jsonl trap" by summarizing your history into a dense "State" paragraph, keeping payloads tiny and responses instant.

## 🚀 Titan Hybrid Capabilities
- **Mem0 (Long-Term Memory)**: A persistent memory graph that tracks your preferences across months, not just minutes.
- **Tavily AI Search**: AI-optimized web research that returns clean Markdown instead of heavy HTML.
- **PyAutoGUI Vision**: Grant Aurthur "eyes" to see your screen and "hands" to click and type in any application.

## ⌨️ Command Guide
### Messaging Interface
| Command | Description |
| :--- | :--- |
| `/menu` | Display a structured list of Aurthur's skills. |
| `/status` | Check system health and resource consumption. |
| `/search <query>` | Instant AI-ready web research via Tavily. |
| `/remember <fact>` | Save a fact to long-term memory (Mem0). |
| `/vision` | Screenshot the screen and analyze the current view. |

### CLI Interface
| Command | Description |
| :--- | :--- |
| `arthur onboard` | Launch the setup wizard. |
| `arthur gateway run` | Start the dormant control plane. |
| `arthur tui` | Open the terminal-based UI dashboard. |

## 📦 Installation

```bash
# Clone the repository
git clone https://github.com/imranshiundu/Agent-Aurther.git

# Install dependencies
pnpm install

# Run the onboarding wizard
arthur onboard
```

## 👥 Maintenance
Maintained with passion by **Imran Shiundu (Lead Architect)**.

---
*Elevate your digital reality with Agent Aurthur.*
