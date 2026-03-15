import type { RavenoxPluginApi } from .ravenox/plugin-sdk";
import { emptyPluginConfigSchema } from .ravenox/plugin-sdk";
import { createDiagnosticsOtelService } from "./src/service.js";

const plugin = {
  id: "diagnostics-otel",
  name: "Diagnostics OpenTelemetry",
  description: "Export diagnostics events to OpenTelemetry",
  configSchema: emptyPluginConfigSchema(),
  register(api: RavenoxPluginApi) {
    api.registerService(createDiagnosticsOtelService());
  },
};

export default plugin;
