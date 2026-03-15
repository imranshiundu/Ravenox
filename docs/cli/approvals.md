---
summary: "CLI reference for .ravenox approvals` (exec approvals for gateway or node hosts)"
read_when:
  - You want to edit exec approvals from the CLI
  - You need to manage allowlists on gateway or node hosts
title: "approvals"
---

# .ravenox approvals`

Manage exec approvals for the **local host**, **gateway host**, or a **node host**.
By default, commands target the local approvals file on disk. Use `--gateway` to target the gateway, or `--node` to target a specific node.

Related:

- Exec approvals: [Exec approvals](/tools/exec-approvals)
- Nodes: [Nodes](/nodes)

## Common commands

```bash
ravenox approvals get
ravenox approvals get --node <id|name|ip>
ravenox approvals get --gateway
```

## Replace approvals from a file

```bash
ravenox approvals set --file ./exec-approvals.json
ravenox approvals set --node <id|name|ip> --file ./exec-approvals.json
ravenox approvals set --gateway --file ./exec-approvals.json
```

## Allowlist helpers

```bash
ravenox approvals allowlist add "~/Projects/**/bin/rg"
ravenox approvals allowlist add --agent main --node <id|name|ip> "/usr/bin/uptime"
ravenox approvals allowlist add --agent "*" "/usr/bin/uname"

ravenox approvals allowlist remove "~/Projects/**/bin/rg"
```

## Notes

- `--node` uses the same resolver as .ravenox nodes` (id, name, ip, or id prefix).
- `--agent` defaults to `"*"`, which applies to all agents.
- The node host must advertise `system.execApprovals.get/set` (macOS app or headless node host).
- Approvals files are stored per host at `~/"@ravenox/exec-approvals.json`.
