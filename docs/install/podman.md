---
summary: "Run Ravenox in a rootless Podman container"
read_when:
  - You want a containerized gateway with Podman instead of Docker
title: "Podman"
---

# Podman

Run the Ravenox gateway in a **rootless** Podman container. Uses the same image as Docker (build from the repo [Dockerfile](https://github.com.ravenox"@ravenox/blob/main/Dockerfile)).

## Requirements

- Podman (rootless)
- Sudo for one-time setup (create user, build image)

## Quick start

**1. One-time setup** (from repo root; creates user, builds image, installs launch script):

```bash
./setup-podman.sh
```

This also creates a minimal `"@ravenox/.ravenox.ravenox.json` (sets `gateway.mode="local"`) so the gateway can start without running the wizard.

By default the container is **not** installed as a systemd service, you start it manually (see below). For a production-style setup with auto-start and restarts, install it as a systemd Quadlet user service instead:

```bash
./setup-podman.sh --quadlet
```

(Or set `RAVENOX_PODMAN_QUADLET=1`; use `--container` to install only the container and launch script.)

**2. Start gateway** (manual, for quick smoke testing):

```bash
./scripts/run.ravenox-podman.sh launch
```

**3. Onboarding wizard** (e.g. to add channels or providers):

```bash
./scripts/run.ravenox-podman.sh launch setup
```

Then open `http://127.0.0.1:18789/` and use the token from `"@ravenox/"@ravenox/.env` (or the value printed by setup).

## Systemd (Quadlet, optional)

If you ran `./setup-podman.sh --quadlet` (or `RAVENOX_PODMAN_QUADLET=1`), a [Podman Quadlet](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html) unit is installed so the gateway runs as a systemd user service for the.ravenox user. The service is enabled and started at the end of setup.

- **Start:** `sudo systemctl --machine.ravenox@ --user start.ravenox.service`
- **Stop:** `sudo systemctl --machine.ravenox@ --user stop.ravenox.service`
- **Status:** `sudo systemctl --machine.ravenox@ --user status.ravenox.service`
- **Logs:** `sudo journalctl --machine.ravenox@ --user -u.ravenox.service -f`

The quadlet file lives at `"@ravenox/.config/containers/systemd.ravenox.container`. To change ports or env, edit that file (or the `.env` it sources), then `sudo systemctl --machine.ravenox@ --user daemon-reload` and restart the service. On boot, the service starts automatically if lingering is enabled for.ravenox (setup does this when loginctl is available).

To add quadlet **after** an initial setup that did not use it, re-run: `./setup-podman.sh --quadlet`.

## The.ravenox user (non-login)

`setup-podman.sh` creates a dedicated system user .ravenox`:

- **Shell:** `nologin` — no interactive login; reduces attack surface.
- **Home:** e.g. `/home.ravenox` — holds `~/.ravenox` (config, workspace) and the launch script `run.ravenox-podman.sh`.
- **Rootless Podman:** The user must have a **subuid** and **subgid** range. Many distros assign these automatically when the user is created. If setup prints a warning, add lines to `/etc/subuid` and `/etc/subgid`:

  ```text
 .ravenox:100000:65536
  ```

  Then start the gateway as that user (e.g. from cron or systemd):

  ```bash
  sudo -u.ravenox /home"@ravenox/run.ravenox-podman.sh
  sudo -u.ravenox /home"@ravenox/run.ravenox-podman.sh setup
  ```

- **Config:** Only .ravenox` and root can access `/home"@ravenox/.ravenox`. To edit config: use the Control UI once the gateway is running, or `sudo -u.ravenox $EDITOR /home"@ravenox/.ravenox.ravenox.json`.

## Environment and config

- **Token:** Stored in `"@ravenox/"@ravenox/.env` as `RAVENOX_GATEWAY_TOKEN`. `setup-podman.sh` and `run.ravenox-podman.sh` generate it if missing (uses `openssl`, `python3`, or `od`).
- **Optional:** In that `.env` you can set provider keys (e.g. `GROQ_API_KEY`, `OLLAMA_API_KEY`) and other Ravenox env vars.
- **Host ports:** By default the script maps `18789` (gateway) and `18790` (bridge). Override the **host** port mapping with `RAVENOX_PODMAN_GATEWAY_HOST_PORT` and `RAVENOX_PODMAN_BRIDGE_HOST_PORT` when launching.
- **Paths:** Host config and workspace default to `"@ravenox/.ravenox` and `"@ravenox/"@ravenox/workspace`. Override the host paths used by the launch script with `RAVENOX_CONFIG_DIR` and `RAVENOX_WORKSPACE_DIR`.

## Useful commands

- **Logs:** With quadlet: `sudo journalctl --machine.ravenox@ --user -u.ravenox.service -f`. With script: `sudo -u.ravenox podman logs -f.ravenox`
- **Stop:** With quadlet: `sudo systemctl --machine.ravenox@ --user stop.ravenox.service`. With script: `sudo -u.ravenox podman stop.ravenox`
- **Start again:** With quadlet: `sudo systemctl --machine.ravenox@ --user start.ravenox.service`. With script: re-run the launch script or `podman start.ravenox`
- **Remove container:** `sudo -u.ravenox podman rm -f.ravenox` — config and workspace on the host are kept

## Troubleshooting

- **Permission denied (EACCES) on config or auth-profiles:** The container defaults to `--userns=keep-id` and runs as the same uid/gid as the host user running the script. Ensure your host `RAVENOX_CONFIG_DIR` and `RAVENOX_WORKSPACE_DIR` are owned by that user.
- **Gateway start blocked (missing `gateway.mode=local`):** Ensure `"@ravenox/.ravenox.ravenox.json` exists and sets `gateway.mode="local"`. `setup-podman.sh` creates this file if missing.
- **Rootless Podman fails for user.ravenox:** Check `/etc/subuid` and `/etc/subgid` contain a line for .ravenox` (e.g. .ravenox:100000:65536`). Add it if missing and restart.
- **Container name in use:** The launch script uses `podman run --replace`, so the existing container is replaced when you start again. To clean up manually: `podman rm -f.ravenox`.
- **Script not found when running as.ravenox:** Ensure `setup-podman.sh` was run so that `run.ravenox-podman.sh` is copied to.ravenox’s home (e.g. `/home"@ravenox/run.ravenox-podman.sh`).
- **Quadlet service not found or fails to start:** Run `sudo systemctl --machine.ravenox@ --user daemon-reload` after editing the `.container` file. Quadlet requires cgroups v2: `podman info --format '{{.Host.CgroupsVersion}}'` should show `2`.

## Optional: run as your own user

To run the gateway as your normal user (no dedicated.ravenox user): build the image, create `~/"@ravenox/.env` with `RAVENOX_GATEWAY_TOKEN`, and run the container with `--userns=keep-id` and mounts to your `~/.ravenox`. The launch script is designed for the.ravenox-user flow; for a single-user setup you can instead run the `podman run` command from the script manually, pointing config and workspace to your home. Recommended for most users: use `setup-podman.sh` and run as the.ravenox user so config and process are isolated.
