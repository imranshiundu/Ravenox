# Agent Aurthur 🤖🚀

**Agent Aurthur** is a state-of-the-art, high-autonomy personal AI assistant designed to run on your own hardware. It is built for absolute speed, total privacy, and sovereign control.

> [!NOTE]
> **Lineage Credit**: Agent Aurthur is a performance-tuned distribution of [OpenClaw](https://github.com/arthur/arthur). We acknowledge and credit the OpenClaw team for the foundational code used in this project.

## 🌟 The "Ghost" Architecture
Agent Aurthur isn't just a bot; it's a **Ghost**. It lives on your devices, consumes **zero resources** when idle, and wakes up in **under 200ms** to serve your needs. 

- **Sub-200ms Wake-up**: Lightning-fast reactions via Webhook "Doorbell" triggers.
- **Zero Idle CPU**: No polling, no constant battery drain.
- **Micro-Hardware Ready**: Optimized to run on a **$5 Raspberry Pi Zero** or **ESP32** (via MimiClaw).

## 🟢 WhatsApp Automation (Native Intelligence)
Agent Aurthur treats WhatsApp as a first-class control surface. You don't just chat; you command.

- **Remote Task Execution**: Trigger complex workflows on your PC via WhatsApp messages.
- **Deterministic Commands**: Use `/` commands to bypass LLM latency for known tasks (e.g., `/status`, `/play`, `/lock`).
- **Media Intelligence**: Send images or voice notes for Aurthur to analyze using his Vision and Audio pipelines.
- **Invisible Listener**: Aurthur waits silently for your triggers, ensuring 100% privacy and 0% resource waste.

## 🚀 Titan Hybrid Capabilities
We've merged the lightweight core with heavy-duty "Titan" capabilities that activate only when needed:

- **Mem0 (Long-Term Memory)**: Aurthur builds a persistent memory graph of your preferences, projects, and history. He remembers you across sessions.
- **Tavily AI Search**: Real-time, research-grade web searching without the bloat of a headless browser.
- **PyAutoGUI Vision**: Grant Aurthur eyes and hands. He can see your screen, take screenshots, and click/type to automate any desktop app.
- **Context Compaction**: Aurthur dodges the ".jsonl trap" by summarizing your history into a dense "State" paragraph, keeping API costs low and responses instant.

## ⌨️ Command System
Aurthur supports both CLI and Messaging commands for full control.

### Messaging Commands (WhatsApp/Telegram/Slack)
| Command | Description |
| :--- | :--- |
| `/menu` | Display current skills and abilities. |
| `/status` | Check system health and connection status. |
| `/search <query>` | Perform a Tavily AI search. |
| `/remember <fact>` | Manually add a fact to Mem0 long-term memory. |
| `/vision` | Capture a screenshot and analyze the current view. |
| `/play <music>` | Open Spotify and play requested audio. |

### CLI Commands
| Command | Description |
| :--- | :--- |
| `arthur onboard` | Launch the setup wizard. |
| `arthur gateway run` | Start the control plane. |
| `arthur tui` | Open the terminal-based user interface. |
| `arthur config set` | Modify configuration on the fly. |

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
