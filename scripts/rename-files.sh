#!/usr/bin/env bash
set -euo pipefail

# Ravenox Rename Script
# Renames files and directories from OpenClaw/Arthur to Ravenox

rename_item() {
    local item="$1"
    local new_item
    new_item=$(echo "$item" | sed 's/OpenClaw/Ravenox/g; s/Claw/Ravenox/g; s/openclaw/ravenox/g; s/Arthur/Ravenox/g; s/arthur/ravenox/g')
    if [ "$item" != "$new_item" ]; then
        echo "Renaming $item to $new_item"
        mkdir -p "$(dirname "$new_item")"
        mv "$item" "$new_item"
    fi
}

# 1. Rename directories (deep first)
find . -depth -type d \( -name "*OpenClaw*" -o -name "*Claw*" -o -name "*openclaw*" -o -name "*Arthur*" -o -name "*arthur*" \) -not -path "*/.git/*" -not -path "*/node_modules/*" | while read -r dir; do
    rename_item "$dir"
done

# 2. Rename files
find . -type f \( -name "*OpenClaw*" -o -name "*Claw*" -o -name "*openclaw*" -o -name "*Arthur*" -o -name "*arthur*" \) -not -path "*/.git/*" -not -path "*/node_modules/*" | while read -r file; do
    rename_item "$file"
done
