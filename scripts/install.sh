#!/usr/bin/env bash
set -euo pipefail

# Ravenox One-Line Installer 🐦‍⬛
# "Control is silent. Power is invisible."

# Colors
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          🐦‍⬛ RAVENOX INSTALLER 🐦‍⬛          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"

# Check for Node.js
if ! command -v node >/dev/null 2>&1; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    echo -e "Please install Node.js 22+ from https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 22 ]; then
    echo -e "${RED}Error: Ravenox requires Node.js 22 or higher.${NC}"
    echo -e "Current version: $(node -v)"
    exit 1
fi

# Check for pnpm
if ! command -v pnpm >/dev/null 2>&1; then
    echo -e "${CYAN}pnpm not found. Installing pnpm...${NC}"
    npm install -g pnpm
fi

# Clone if not in repo
if [ ! -f "package.json" ] || [ "$(grep -c "ravenox" package.json)" -eq 0 ]; then
    echo -e "${CYAN}Cloning Ravenox repository...${NC}"
    git clone https://github.com/imranshiundu/Ravenox.git ravenox
    cd ravenox
fi

echo -e "${CYAN}Installing high-performance dependencies...${NC}"
pnpm install

echo -e "${CYAN}Building the Ghost Architecture...${NC}"
pnpm build

echo -e "${GREEN}Installation successful! Starting Onboarding Wizard...${NC}"
echo -e "${BLUE}------------------------------------------------${NC}"

node ravenox.mjs onboard
