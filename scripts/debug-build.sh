#!/usr/bin/env bash
set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ENTRIES=(
  "src/index.ts"
  "src/entry.ts"
  "src/cli/daemon-cli.ts"
  "src/infra/warning-filter.ts"
  "src/plugin-sdk/index.ts"
  "src/plugin-sdk/account-id.ts"
  "src/extensionAPI.ts"
  "src/hooks/llm-slug-generator.ts"
)

for entry in "${ENTRIES[@]}"; do
  echo "Building $entry..."
  ./node_modules/.bin/tsup "$entry" --format esm --target node22 --no-splitting --no-shims || echo "FAILED $entry"
done
