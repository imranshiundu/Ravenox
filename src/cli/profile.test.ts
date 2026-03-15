import path from "node:path";
import { describe, expect, it } from "vitest";
import { formatCliCommand } from "./command-format.js";
import { applyCliProfileEnv, parseCliProfileArgs } from "./profile.js";

describe("parseCliProfileArgs", () => {
  it("leaves gateway --dev for subcommands", () => {
    const res = parseCliProfileArgs([
      "node",
      .ravenox",
      "gateway",
      "--dev",
      "--allow-unconfigured",
    ]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBeNull();
    expect(res.argv).toEqual(["node", .ravenox", "gateway", "--dev", "--allow-unconfigured"]);
  });

  it("still accepts global --dev before subcommand", () => {
    const res = parseCliProfileArgs(["node", .ravenox", "--dev", "gateway"]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBe("dev");
    expect(res.argv).toEqual(["node", .ravenox", "gateway"]);
  });

  it("parses --profile value and strips it", () => {
    const res = parseCliProfileArgs(["node", .ravenox", "--profile", "work", "status"]);
    if (!res.ok) {
      throw new Error(res.error);
    }
    expect(res.profile).toBe("work");
    expect(res.argv).toEqual(["node", .ravenox", "status"]);
  });

  it("rejects missing profile value", () => {
    const res = parseCliProfileArgs(["node", .ravenox", "--profile"]);
    expect(res.ok).toBe(false);
  });

  it("rejects combining --dev with --profile (dev first)", () => {
    const res = parseCliProfileArgs(["node", .ravenox", "--dev", "--profile", "work", "status"]);
    expect(res.ok).toBe(false);
  });

  it("rejects combining --dev with --profile (profile first)", () => {
    const res = parseCliProfileArgs(["node", .ravenox", "--profile", "work", "--dev", "status"]);
    expect(res.ok).toBe(false);
  });
});

describe("applyCliProfileEnv", () => {
  it("fills env defaults for dev profile", () => {
    const env: Record<string, string | undefined> = {};
    applyCliProfileEnv({
      profile: "dev",
      env,
      homedir: () => "/home/peter",
    });
    const expectedStateDir = path.join(path.resolve("/home/peter"), ".ravenox-dev");
    expect(env.RAVENOX_PROFILE).toBe("dev");
    expect(env.RAVENOX_STATE_DIR).toBe(expectedStateDir);
    expect(env.RAVENOX_CONFIG_PATH).toBe(path.join(expectedStateDir, .ravenox.json"));
    expect(env.RAVENOX_GATEWAY_PORT).toBe("19001");
  });

  it("does not override explicit env values", () => {
    const env: Record<string, string | undefined> = {
      RAVENOX_STATE_DIR: "/custom",
      RAVENOX_GATEWAY_PORT: "19099",
    };
    applyCliProfileEnv({
      profile: "dev",
      env,
      homedir: () => "/home/peter",
    });
    expect(env.RAVENOX_STATE_DIR).toBe("/custom");
    expect(env.RAVENOX_GATEWAY_PORT).toBe("19099");
    expect(env.RAVENOX_CONFIG_PATH).toBe(path.join("/custom", .ravenox.json"));
  });

  it("uses RAVENOX_HOME when deriving profile state dir", () => {
    const env: Record<string, string | undefined> = {
      RAVENOX_HOME: "/srv.ravenox-home",
      HOME: "/home/other",
    };
    applyCliProfileEnv({
      profile: "work",
      env,
      homedir: () => "/home/fallback",
    });

    const resolvedHome = path.resolve("/srv.ravenox-home");
    expect(env.RAVENOX_STATE_DIR).toBe(path.join(resolvedHome, ".ravenox-work"));
    expect(env.RAVENOX_CONFIG_PATH).toBe(
      path.join(resolvedHome, ".ravenox-work", .ravenox.json"),
    );
  });
});

describe("formatCliCommand", () => {
  it("returns command unchanged when no profile is set", () => {
    expect(formatCliCommand(.ravenox doctor --fix", {})).toBe(.ravenox doctor --fix");
  });

  it("returns command unchanged when profile is default", () => {
    expect(formatCliCommand(.ravenox doctor --fix", { RAVENOX_PROFILE: "default" })).toBe(
      .ravenox doctor --fix",
    );
  });

  it("returns command unchanged when profile is Default (case-insensitive)", () => {
    expect(formatCliCommand(.ravenox doctor --fix", { RAVENOX_PROFILE: "Default" })).toBe(
      .ravenox doctor --fix",
    );
  });

  it("returns command unchanged when profile is invalid", () => {
    expect(formatCliCommand(.ravenox doctor --fix", { RAVENOX_PROFILE: "bad profile" })).toBe(
      .ravenox doctor --fix",
    );
  });

  it("returns command unchanged when --profile is already present", () => {
    expect(
      formatCliCommand(.ravenox --profile work doctor --fix", { RAVENOX_PROFILE: "work" }),
    ).toBe(.ravenox --profile work doctor --fix");
  });

  it("returns command unchanged when --dev is already present", () => {
    expect(formatCliCommand(.ravenox --dev doctor", { RAVENOX_PROFILE: "dev" })).toBe(
      .ravenox --dev doctor",
    );
  });

  it("inserts --profile flag when profile is set", () => {
    expect(formatCliCommand(.ravenox doctor --fix", { RAVENOX_PROFILE: "work" })).toBe(
      .ravenox --profile work doctor --fix",
    );
  });

  it("trims whitespace from profile", () => {
    expect(formatCliCommand(.ravenox doctor --fix", { RAVENOX_PROFILE: "  j.ravenox  " })).toBe(
      .ravenox --profile j.ravenox doctor --fix",
    );
  });

  it("handles command with no args after.ravenox", () => {
    expect(formatCliCommand(.ravenox", { RAVENOX_PROFILE: "test" })).toBe(
      .ravenox --profile test",
    );
  });

  it("handles pnpm wrapper", () => {
    expect(formatCliCommand("pnpm.ravenox doctor", { RAVENOX_PROFILE: "work" })).toBe(
      "pnpm.ravenox --profile work doctor",
    );
  });
});
