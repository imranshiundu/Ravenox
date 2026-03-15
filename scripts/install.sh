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
    echo -e "${CYAN}Cloning Ravenox repository into $HOME/.ravenox-app...${NC}"
    git clone https://github.com/imranshiundu/Ravenox.git "$HOME/.ravenox-app"
    cd "$HOME/.ravenox-app"
else
    echo -e "${CYAN}Already inside Ravenox directory.${NC}"
fi

echo -e "${CYAN}Installing high-performance dependencies...${NC}"
pnpm install

echo -e "${CYAN}Building the Sovereign Architecture...${NC}"
pnpm build

# Link the binary globally if permissions allow, or provide a local link
echo -e "${CYAN}Setting up global 'ravenox' command...${NC}"
if [ -w "/usr/local/bin" ]; then
    ln -sf "$(pwd)/ravenox.mjs" /usr/local/bin/ravenox
    chmod +x /usr/local/bin/ravenox
    echo -e "${GREEN}Global 'ravenox' command linked to /usr/local/bin/ravenox${NC}"
else
    echo -e "${CYAN}Note: Could not link globally (no sudo). Use './ravenox.mjs' to run.${NC}"
fi

echo -e "${GREEN}Installation successful!${NC}"
echo -e "${BLUE}------------------------------------------------${NC}"
echo -e "${CYAN}Starting the Ravenox Onboarding Wizard...${NC}"
echo -e "${CYAN}This will help you setup your first Messaging Provider (WhatsApp/Telegram).${NC}"
echo -e "${BLUE}------------------------------------------------${NC}"

node ravenox.mjs onboard

echo -e ""
echo -e "${GREEN}Ravenox is now ready!${NC}"
echo -e "${CYAN}To start the Background Gateway, run:${NC}"
echo -e "${WHITE}  ravenox gateway run${NC}"
echo -e ""
echo -e "${CYAN}To open the Universal Dashboard, visit:${NC}"
echo -e "${WHITE}  http://localhost:18789${NC}"
echo -e "${BLUE}------------------------------------------------${NC}"
