#!/usr/bin/env bash
set -euo pipefail

# Ravenox Sovereign Validation Script 🐦‍⬛
# "Trust, but verify. Then verify again."

echo -e "\033[0;36m🔍 Validating Ravenox Sovereign Distribution...\033[0m"

# 1. JSON Syntax Check
echo -en "\033[0;34m👉 Checking JSON validity: \033[0m"
failed_json=0
for f in $(find . -name "package.json" -not -path "*/node_modules/*"); do
    if ! jq . "$f" > /dev/null 2>&1; then
        echo -e "\n\033[0;31m❌ JSON Parse Error in $f\033[0m"
        failed_json=$((failed_json + 1))
    fi
done

if [ "$failed_json" -eq 0 ]; then
    echo -e "\033[0;32mPASSED\033[0m"
else
    echo -e "\033[0;31mFAILED ($failed_json errors)\033[0m"
    exit 1
fi

# 2. Legacy Name Leakage Check
echo -en "\033[0;34m👉 Checking for legacy name leakage: \033[0m"
# Exclude files known to contain history (CHANGELOG) or internal agent configs
leaks=$(grep -riE "openclaw|arthur" . --exclude-dir=.git --exclude-dir=node_modules --exclude=pnpm-lock.yaml --exclude=CHANGELOG.md --exclude=AGENTS.md --exclude=package.json --exclude=ravenox.mjs 2>/dev/null | head -n 5 || true)

if [ -z "$leaks" ]; then
    echo -e "\033[0;32mCLEAN\033[0m"
else
    echo -e "\033[0;33mPOTENTIAL LEAKS DETECTED\033[0m"
    grep -riE "openclaw|arthur" . --exclude-dir=.git --exclude-dir=node_modules --exclude=pnpm-lock.yaml --exclude=CHANGELOG.md --exclude=AGENTS.md --exclude=package.json --exclude=ravenox.mjs | head -n 5
    # We don't exit here as some might be false positives or necessary strings, but we warn.
fi

# 3. Core Integrity (Typescript / Lint)
echo -e "\033[0;34m👉 Running Core Integrity Checks (Lint & Typecheck)...\033[0m"
if pnpm check; then
    echo -e "\033[0;32m✅ Core Integrity Verified.\033[0m"
else
    echo -e "\033[0;31m❌ Core Checks Failed!\033[0m"
    exit 1
fi

echo -e "\n\033[0;32m🚀 Everything is okay. Ready to push to main.\033[0m"
