<p align="center">
  <img src="assets/logo.png" width="400" alt="Ravenox Logo">
</p>

# Ravenox 🐦‍⬛🚀
### *The Sovereign Intelligence System*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen.svg)]()
[![Version](https://img.shields.io/badge/Version-1.0.5-cyan.svg)]()
[![Platform](https://img.shields.io/badge/Platform-Node.js%20%7C%20Linux%20%7C%20Mac%20%7C%20Docker-blue.svg)]()

**Ravenox** is a high-performance, high-autonomy personal AI assistant distribution. Designed for developers and power users, it prioritizes **sovereignty, speed, and extreme resource efficiency**. By merging standard bot capabilities with heavy-duty LLM reasoning, Ravenox acts as a "Ghost" in your shell—ready to wake up in milliseconds and execute complex tasks across any platform.

---

> [!IMPORTANT]
> **Lineage & Acknowledgement**: Ravenox is a performance-tuned evolution of the [OpenClaw](https://github.com/ravenox/ravenox) project. We extend our gratitude to the original OpenClaw contributors for the foundational gateway and modular architecture that makes this system possible.

---

## 🌟 Core Philosophy: Ghost in the Machine
Ravenox is built on two primary architectural pillars:

### 👻 1. The Ghost Architecture (Efficiency)
Standard bots burn CPU cycles constant polling Messaging servers. Ravenox uses a **Webhook-First "Doorbell" Architecture** that allows the system to remain dormant (0% idle CPU) and wake up in **under 200ms** when a message hits the gateway. 

### 🦾 2. The Titan Hybrid Suite (Autonomy)
When high-level reasoning is required, Ravenox activates the **Titan Suite**—a collection of high-autonomy tools that bridge the gap between AI and OS:
- **Mem0 Core**: Long-term memory graph that remembers user preferences across months.
- **Tavily Intelligence**: AI-optimized web research that bypasses the bloat of traditional browsing.
- **PyAutoGUI Vision**: Native screen control allowing the AI to "see" and "interact" with non-API software.

---

## 🟢 WhatsApp Native Automation
Ravenox offers a specialized command surface for WhatsApp, enabling full remote control without the need for a web-browser interface.

### 📜 Command Categories
- **AI MENU**: Access advanced LLM reasoning and task planning.
- **AUDIO/VIDEO MENU**: Automated download and conversion pipelines.
- **TOOLS MENU**: System utilities, network probes, and remote shell control.
- **OWNER/SETTINGS MENU**: Sophisticated permission and behavior management.

### 📂 Settings Control (Prefix: `.`)
Ravenox follows a deterministic command pattern to ensure 100% reliability even without an active LLM API:

| Command | Capability |
| :--- | :--- |
| `.mode` | Toggles between Public/Private/Dormant operation. |
| `.alwaysonline` | Keeps the Ravenox identity visible 24/7. |
| `.anticall` | Automatically manages and deflects intrusive calls. |
| `.chatbot` | Activates/Deactivates the high-autonomy LLM responder. |
| `.setprefix` | Dynamically update the command trigger on the fly. |

---

## 🌩️ Optimization & Spec Comparison

Ravenox is engineered for the "Architectural Diet"—running on everything from a $5 Raspberry Pi Zero to a top-tier server cluster.

| Specification | OpenClaw (Vanilla) | **Ravenox (Ghost)** |
| :--- | :--- | :--- |
| **Idle CPU** | 2-5% (Polling) | **0% (Webhook)** |
| **Boot Latency** | 2s - 15s | **< 200ms** |
| **Context Load** | Full JSONL Load | **Sliding Window + Summary** |
| **Memory Persistence**| Session Only | **Mem0 Graph (Permanent)** |
| **Hardware** | PC / Server | **Microcontrollers / ESP32** |

---

## 📦 Quick Start

### 1. Installation
```bash
# Clone the Ravenox distribution
git clone https://github.com/imranshiundu/Ravenox.git

# Install the high-performance dependencies
pnpm install

# Initialize the onboarding wizard
ravenox onboard
```

### 2. Environment (Ghost Mode)
To activate the absolute most lightweight mode, set the following in your `.env`:
```bash
RAVENOX_LIGHT_MODE=1
RAVENOX_WEBHOOK_URL="https://your-domain.com/webhook"
```

---

## 👥 Maintenance & Governance
Ravenox is directed and maintained by **Imran Shiundu (Lead Architect)**. 

We welcome contributions that align with the "Ghost Architecture" principles. For more information, please see the [CONTRIBUTING.md](CONTRIBUTING.md) guide.

---
<p align="center">
  <i>"Control is silent. Power is invisible."</i><br>
  <b>Ravenox © 2026</b>
</p>
