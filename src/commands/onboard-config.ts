import type { RavenoxConfig } from "../config/config.js";

export function applyOnboardingLocalWorkspaceConfig(
  baseConfig: RavenoxConfig,
  workspaceDir: string,
): RavenoxConfig {
  return {
    ...baseConfig,
    agents: {
      ...baseConfig.agents,
      defaults: {
        ...baseConfig.agents?.defaults,
        workspace: workspaceDir,
      },
    },
    gateway: {
      ...baseConfig.gateway,
      mode: "local",
    },
  };
}
