#!/usr/bin/env bash
set -euo pipefail

cd /repo

export RAVENOX_STATE_DIR="/tmp.ravenox-test"
export RAVENOX_CONFIG_PATH="${RAVENOX_STATE_DIR}.ravenox.json"

echo "==> Build"
pnpm build

echo "==> Seed state"
mkdir -p "${RAVENOX_STATE_DIR}/credentials"
mkdir -p "${RAVENOX_STATE_DIR}/agents/main/sessions"
echo '{}' >"${RAVENOX_CONFIG_PATH}"
echo 'creds' >"${RAVENOX_STATE_DIR}/credentials/marker.txt"
echo 'session' >"${RAVENOX_STATE_DIR}/agents/main/sessions/sessions.json"

echo "==> Reset (config+creds+sessions)"
pnpm.ravenox reset --scope config+creds+sessions --yes --non-interactive

test ! -f "${RAVENOX_CONFIG_PATH}"
test ! -d "${RAVENOX_STATE_DIR}/credentials"
test ! -d "${RAVENOX_STATE_DIR}/agents/main/sessions"

echo "==> Recreate minimal config"
mkdir -p "${RAVENOX_STATE_DIR}/credentials"
echo '{}' >"${RAVENOX_CONFIG_PATH}"

echo "==> Uninstall (state only)"
pnpm.ravenox uninstall --state --yes --non-interactive

test ! -d "${RAVENOX_STATE_DIR}"

echo "OK"
