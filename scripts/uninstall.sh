#!/usr/bin/env bash
set -e

# Ravenox Oblivion Script (Uninstall) 🐦‍⬛
# "What is gone, is forgotten."

# Colors
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${RED}╔════════════════════════════════════════════╗${NC}"
echo -e "${RED}║          ⚠️  RAVENOX UNINSTALLER  ⚠️          ║${NC}"
echo -e "${RED}╚════════════════════════════════════════════╝${NC}"

read -p "Are you sure you want to delete Ravenox and all its data? This cannot be undone. (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${CYAN}Uninstall cancelled.${NC}"
    exit 0
fi

echo -e "${CYAN}Stopping processes...${NC}"
bash "$(dirname "${BASH_SOURCE[0]}")/stop.sh" || true

echo -e "${CYAN}Removing global link...${NC}"
if [ -L "/usr/local/bin/ravenox" ]; then
    sudo rm "/usr/local/bin/ravenox" || rm "/usr/local/bin/ravenox" || true
fi

echo -e "${CYAN}Removing configuration and sessions...${NC}"
rm -rf "$HOME/.ravenox" || true
rm -rf "$HOME/.ravenox-app" || true

echo -e "${CYAN}Removing application directory...${NC}"
# If we are inside the directory, we should move out before deleting it
# But usually this is run from the repo root or via curl.
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
rm -rf "$REPO_DIR" || true

echo -e "${RED}Ravenox has been completely removed from your system.${NC}"
