import type {
  AnyAgentTool,
  RavenoxPluginApi,
  RavenoxPluginToolFactory,
} from "../../src/plugins/types.js";
import { createLobsterTool } from "./src/lobster-tool.js";

export default function register(api: RavenoxPluginApi) {
  api.registerTool(
    ((ctx) => {
      if (ctx.sandboxed) {
        return null;
      }
      return createLobsterTool(api) as AnyAgentTool;
    }) as RavenoxPluginToolFactory,
    { optional: true },
  );
}
