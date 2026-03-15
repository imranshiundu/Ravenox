<p align="center">
  <img src="assets/logo.png" width="400" alt="Ravenox Logo">
</p>

# Ravenox 🐦‍⬛🚀
### *The Sovereign Intelligence System*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.5-cyan.svg)]()
[![Build](https://img.shields.io/badge/Build-Passing-brightgreen.svg)]()

**Ravenox** is a high-performance, high-autonomy personal AI distribution. It transforms your hardware into a sovereign agent, capable of managing messaging (WhatsApp, Telegram, etc.), research, and desktop automation with **zero-latency**.

---

## 🛠️ Detailed Hardware Specifications (Usage Requirements)

Ravenox is highly optimized. It doesn't "eat" RAM; it sips it. However, the requirements change based on how many features you enable.

| Spec | **Micro (Ghost Mode)** | **Standard (Daily Driver)** | **Titan (High-Autonomy)** |
| :--- | :--- | :--- | :--- |
| **CPU Cores** | 1 Core (e.g., Pi Zero) | 2 Cores (Modern Laptop) | 4+ Cores (Workstation) |
| **RAM (Target)** | **~85MB - 128MB** | **512MB - 2GB** | **4GB - 8GB+** |
| **Storage** | 200MB (Base OS + App) | 1GB (History + Logs) | 5GB+ (Mem0 Graph + Media) |
| **Network** | 256kbps+ | 5Mbps+ | 20Mbps+ (for Vision/Media) |
| **Ideal Hardware** | Raspberry Pi Zero, ESP32 | VPS, Mac Mini, WSL2 | Desktop PC, Docker Cluster |

---

## ⚡ Power User Setup: "Ready-to-Work"

The installation is designed to be **Zero-Config**. Once installed, everything—including your Messaging providers and AI settings—is managed through the **Universal Dashboard**.

### 1. One-Line "Software" Install
This script clones Ravenox, installs dependencies, builds the sovereign core, and links the `ravenox` command globally. It literally turns your machine into a Ravenox host in seconds.
```bash
curl -sSL https://raw.githubusercontent.com/imranshiundu/Ravenox/main/scripts/install.sh | bash
```

### 2. The Universal Dashboard
After installation, start the gateway and open the dashboard in your browser:
- **Command**: `ravenox gateway run`
- **Dashboard**: `http://localhost:18789`
- *Everything from WhatsApp linking to AI model selection happens here.*

### 3. Automatic Updates
Ravenox stays fresh. To update your system to the latest version of the "Sovereign Distribution":
```bash
# Simply run the build sync command
ravenox update
```
*(This pulls latest code, rebuilds the Ghost architecture, and restarts the gateway automatically.)*

---

## 📡 Messaging Connection Guide

| Platform | Difficulty | Method |
| :--- | :--- | :--- |
| **WhatsApp** | 🟢 Easy | QR Code Scan via Dashboard or `ravenox channels login` |
| **Telegram** | 🟢 Easy | Bot Token from [@BotFather](https://t.me/botfather) |
| **Signal** | 🟡 Medium | Link existing primary device |
| **Discord** | 🟢 Easy | Bot Token from Developer Portal |

---

## 🏗️ System Architecture
```mermaid
graph TD
    User([User]) -- "WhatsApp/Signal/Slack" --> Gateway[Ravenox Gateway]
    Gateway -- "Intent Analysis" --> Router{Intent Router}
    Router -- "Passive Command" --> Shell[Local Shell/Python Tools]
    Router -- "Complex Task" --> Titan[Titan Suite - autonomous]
    Titan -- "Long-term Memory" --> Mem0[(Mem0 Graph)]
    Titan -- "Vision" --> Screen[Desktop Control]
    Gateway -- "Doorbell trigger" --> Ghost[Ghost Wake-up <200ms]
    Ghost -- "Suspends" --> P[0% Idle CPU]
```

---

## 👥 Maintenance & Governance
Ravenox is directed and maintained by **Imran Shiundu (Lead Architect)**. 

---
<p align="center">
  <i>"Control is silent. Power is invisible."</i><br>
  <b>Ravenox © 2026</b>
</p>
