#!/usr/bin/env bash
set -e

# Ravenox Underworld Stop Script 🐦‍⬛
# "Silence is the ultimate weapon."

# Colors
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Stopping all Ravenox processes...${NC}"

# Kill the gateway
if pkill -f "ravenox gateway" || pkill -f "node ravenox.mjs gateway"; then
    echo -e "${CYAN}Ravenox Gateway stopped.${NC}"
else
    echo -e "${RED}Ravenox Gateway was not running.${NC}"
fi

# Kill any stray node processes related to ravenox
pkill -f "ravenox.mjs" || true

echo -e "${CYAN}Ravenox is now dormant.${NC}"
