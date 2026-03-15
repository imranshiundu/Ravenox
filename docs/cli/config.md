---
summary: "CLI reference for .ravenox config` (get/set/unset config values)"
read_when:
  - You want to read or edit config non-interactively
title: "config"
---

# .ravenox config`

Config helpers: get/set/unset values by path. Run without a subcommand to open
the configure wizard (same as .ravenox configure`).

## Examples

```bash
ravenox config get browser.executablePath
ravenox config set browser.executablePath "/usr/bin/google-chrome"
ravenox config set agents.defaults.heartbeat.every "2h"
ravenox config set agents.list[0].tools.exec.node "node-id-or-name"
ravenox config unset tools.web.search.apiKey
```

## Paths

Paths use dot or bracket notation:

```bash
ravenox config get agents.defaults.workspace
ravenox config get agents.list[0].id
```

Use the agent list index to target a specific agent:

```bash
ravenox config get agents.list
ravenox config set agents.list[1].tools.exec.node "node-id-or-name"
```

## Values

Values are parsed as JSON5 when possible; otherwise they are treated as strings.
Use `--json` to require JSON5 parsing.

```bash
ravenox config set agents.defaults.heartbeat.every "0m"
ravenox config set gateway.port 19001 --json
ravenox config set channels.whatsapp.groups '["*"]' --json
```

Restart the gateway after edits.
