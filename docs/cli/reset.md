---
summary: "CLI reference for .ravenox reset` (reset local state/config)"
read_when:
  - You want to wipe local state while keeping the CLI installed
  - You want a dry-run of what would be removed
title: "reset"
---

# .ravenox reset`

Reset local config/state (keeps the CLI installed).

```bash
ravenox reset
ravenox reset --dry-run
ravenox reset --scope config+creds+sessions --yes --non-interactive
```
