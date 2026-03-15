import { describe, expect, it } from "vitest";
import {
  buildParseArgv,
  getFlagValue,
  getCommandPath,
  getPrimaryCommand,
  getPositiveIntFlagValue,
  getVerboseFlag,
  hasHelpOrVersion,
  hasFlag,
  shouldMigrateState,
  shouldMigrateStateFromPath,
} from "./argv.js";

describe("argv helpers", () => {
  it("detects help/version flags", () => {
    expect(hasHelpOrVersion(["node", "ravenox", "--help"])).toBe(true);
    expect(hasHelpOrVersion(["node", "ravenox", "-V"])).toBe(true);
    expect(hasHelpOrVersion(["node", "ravenox", "status"])).toBe(false);
  });

  it("extracts command path ignoring flags and terminator", () => {
    expect(getCommandPath(["node", "ravenox", "status", "--json"], 2)).toEqual(["status"]);
    expect(getCommandPath(["node", "ravenox", "agents", "list"], 2)).toEqual(["agents", "list"]);
    expect(getCommandPath(["node", "ravenox", "status", "--", "ignored"], 2)).toEqual(["status"]);
  });

  it("returns primary command", () => {
    expect(getPrimaryCommand(["node", "ravenox", "agents", "list"])).toBe("agents");
    expect(getPrimaryCommand(["node", "ravenox"])).toBeNull();
  });

  it("parses boolean flags and ignores terminator", () => {
    expect(hasFlag(["node", "ravenox", "status", "--json"], "--json")).toBe(true);
    expect(hasFlag(["node", "ravenox", "--", "--json"], "--json")).toBe(false);
  });

  it("extracts flag values with equals and missing values", () => {
    expect(getFlagValue(["node", "ravenox", "status", "--timeout", "5000"], "--timeout")).toBe(
      "5000",
    );
    expect(getFlagValue(["node", "ravenox", "status", "--timeout=2500"], "--timeout")).toBe(
      "2500",
    );
    expect(getFlagValue(["node", "ravenox", "status", "--timeout"], "--timeout")).toBeNull();
    expect(getFlagValue(["node", "ravenox", "status", "--timeout", "--json"], "--timeout")).toBe(
      null,
    );
    expect(getFlagValue(["node", "ravenox", "--", "--timeout=99"], "--timeout")).toBeUndefined();
  });

  it("parses verbose flags", () => {
    expect(getVerboseFlag(["node", "ravenox", "status", "--verbose"])).toBe(true);
    expect(getVerboseFlag(["node", "ravenox", "status", "--debug"])).toBe(false);
    expect(getVerboseFlag(["node", "ravenox", "status", "--debug"], { includeDebug: true })).toBe(
      true,
    );
  });

  it("parses positive integer flag values", () => {
    expect(getPositiveIntFlagValue(["node", "ravenox", "status"], "--timeout")).toBeUndefined();
    expect(
      getPositiveIntFlagValue(["node", "ravenox", "status", "--timeout"], "--timeout"),
    ).toBeNull();
    expect(
      getPositiveIntFlagValue(["node", "ravenox", "status", "--timeout", "5000"], "--timeout"),
    ).toBe(5000);
    expect(
      getPositiveIntFlagValue(["node", "ravenox", "status", "--timeout", "nope"], "--timeout"),
    ).toBeUndefined();
  });

  it("builds parse argv from raw args", () => {
    const nodeArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node", "ravenox", "status"],
    });
    expect(nodeArgv).toEqual(["node", "ravenox", "status"]);

    const versionedNodeArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node-22", "ravenox", "status"],
    });
    expect(versionedNodeArgv).toEqual(["node-22", "ravenox", "status"]);

    const versionedNodeWindowsArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node-22.2.0.exe", "ravenox", "status"],
    });
    expect(versionedNodeWindowsArgv).toEqual(["node-22.2.0.exe", "ravenox", "status"]);

    const versionedNodePatchlessArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node-22.2", "ravenox", "status"],
    });
    expect(versionedNodePatchlessArgv).toEqual(["node-22.2", "ravenox", "status"]);

    const versionedNodeWindowsPatchlessArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node-22.2.exe", "ravenox", "status"],
    });
    expect(versionedNodeWindowsPatchlessArgv).toEqual(["node-22.2.exe", "ravenox", "status"]);

    const versionedNodeWithPathArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["/usr/bin/node-22.2.0", "ravenox", "status"],
    });
    expect(versionedNodeWithPathArgv).toEqual(["/usr/bin/node-22.2.0", "ravenox", "status"]);

    const nodejsArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["nodejs", "ravenox", "status"],
    });
    expect(nodejsArgv).toEqual(["nodejs", "ravenox", "status"]);

    const nonVersionedNodeArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["node-dev", "ravenox", "status"],
    });
    expect(nonVersionedNodeArgv).toEqual(["node", "ravenox", "node-dev", "ravenox", "status"]);

    const directArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["ravenox", "status"],
    });
    expect(directArgv).toEqual(["node", "ravenox", "status"]);

    const bunArgv = buildParseArgv({
      programName: "ravenox",
      rawArgs: ["bun", "src/entry.ts", "status"],
    });
    expect(bunArgv).toEqual(["bun", "src/entry.ts", "status"]);
  });

  it("builds parse argv from fallback args", () => {
    const fallbackArgv = buildParseArgv({
      programName: "ravenox",
      fallbackArgv: ["status"],
    });
    expect(fallbackArgv).toEqual(["node", "ravenox", "status"]);
  });

  it("decides when to migrate state", () => {
    expect(shouldMigrateState(["node", "ravenox", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "health"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "sessions"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "config", "get", "update"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "config", "unset", "update"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "models", "list"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "models", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "memory", "status"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "agent", "--message", "hi"])).toBe(false);
    expect(shouldMigrateState(["node", "ravenox", "agents", "list"])).toBe(true);
    expect(shouldMigrateState(["node", "ravenox", "message", "send"])).toBe(true);
  });

  it("reuses command path for migrate state decisions", () => {
    expect(shouldMigrateStateFromPath(["status"])).toBe(false);
    expect(shouldMigrateStateFromPath(["config", "get"])).toBe(false);
    expect(shouldMigrateStateFromPath(["models", "status"])).toBe(false);
    expect(shouldMigrateStateFromPath(["agents", "list"])).toBe(true);
  });
});
