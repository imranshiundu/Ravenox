import type { RavenoxConfig } from "./config.js";

export function ensurePluginAllowlisted(cfg: RavenoxConfig, pluginId: string): RavenoxConfig {
  const allow = cfg.plugins?.allow;
  if (!Array.isArray(allow) || allow.includes(pluginId)) {
    return cfg;
  }
  return {
    ...cfg,
    plugins: {
      ...cfg.plugins,
      allow: [...allow, pluginId],
    },
  };
}
