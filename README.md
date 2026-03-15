<p align="center">
  <img src="assets/logo.png" width="300" alt="Ravenox Logo">
</p>

# Ravenox 🐦‍⬛🚀

**Ravenox** is a state-of-the-art, high-autonomy personal AI assistant designed to run on your own hardware. It is built for absolute speed, total privacy, and sovereign control. It is a performance-tuned superset of the OpenClaw codebase.

> [!NOTE]
> **Lineage Credit**: Ravenox is a performance-tuned distribution of [OpenClaw](https://github.com/arthur/arthur). We acknowledge and credit the OpenClaw team for the foundational code. Ravenox maintains **100% feature parity** with OpenClaw—you lose nothing while gaining everything.

## 🌟 The "Ghost" Architecture
Ravenox isn't just a bot; it's a **Ghost**. It lives on your devices, consumes **zero resources** when idle, and wakes up in **under 200ms** to serve your needs. 

- **Sub-200ms Wake-up**: Lightning-fast reactions via Webhook "Doorbell" triggers.
- **Zero Idle CPU**: No polling, no constant battery drain.
- **Micro-Hardware Ready**: Optimized to run on a **$5 Raspberry Pi Zero** or **ESP32** (via MimiClaw).

## 🟢 WhatsApp Automation (Raven Edition)
Ravenox treats WhatsApp as a first-class control surface. You don't just chat; you command.

### 📜 Available Categories
1. **AI MENU**
2. **AUDIO MENU**
3. **DOWNLOAD MENU**
4. **EPHOTO360 MENU**
5. **FUN MENU**
6. **GROUP MENU**
7. **IMAGE MENU**
8. **MULTISESSION MENU**
9. **OTHER MENU**
10. **OWNER MENU**
11. **RELIGION MENU**
12. **SEARCH MENU**
13. **SETTINGS MENU**
14. **SPORTS MENU**
15. **SUPPORT MENU**
16. **TOOLS MENU**
17. **VIDEO MENU**

### 📂 Settings Commands
Command Prefix: `.` (e.g., `.mode`)

| Command | Action |
| :--- | :--- |
| `.mode` | Switch Ravenox operation modes. |
| `.setprefix` | Customize the command prefix. |
| `.addsudo` | Add a sudo user for advanced permissions. |
| `.alwaysonline` | Toggle "Always Online" presence. |
| `.anticall` | Automatically block incoming calls. |
| `.antidelete` | Prevent message deletion. |
| `.chatbot` | Toggle AI chat capabilities. |
| `.setbotname` | Rename your Ravenox instance. |
| `.getsettings` | View current configuration. |

## 🚀 Titan Hybrid Capabilities
- **Mem0 (Long-Term Memory)**: Ravenox builds a persistent memory graph of your preferences and projects.
- **Tavily AI Search**: Real-time, research-grade web searching without the bloat.
- **PyAutoGUI Vision**: Grant Ravenox eyes and hands to automate any desktop app.
- **Context Compaction**: Dodges the ".jsonl trap" by summarizing history into a dense "State" paragraph.

## ⌨️ Command Guide
| Command | Description |
| :--- | :--- |
| `.menu` | Display the structured Ravenox interactive menu. |
| `/status` | Check system health and connection status. |
| `/search` | Perform an AI-optimized web search. |
| `/remember` | Manually add a fact to long-term memory. |

## 📦 Installation

```bash
# Clone the repository
git clone https://github.com/imranshiundu/Ravenox.git

# Install dependencies
pnpm install

# Run the onboarding wizard
ravenox onboard
```

## 👥 Maintenance
Maintained with passion by **Imran Shiundu (Lead Architect)**.

---
*Elevate your digital reality with Ravenox.*
