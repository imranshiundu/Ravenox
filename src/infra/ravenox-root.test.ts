import path from "node:path";
import { pathToFileURL } from "node:url";
import { beforeEach, describe, expect, it, vi } from "vitest";

type FakeFsEntry = { kind: "file"; content: string } | { kind: "dir" };

const VITEST_FS_BASE = path.join(path.parse(process.cwd()).root, "_.ravenox_vitest__");
const FIXTURE_BASE = path.join(VITEST_FS_BASE, .ravenox-root");

const state = vi.hoisted(() => ({
  entries: new Map<string, FakeFsEntry>(),
  realpaths: new Map<string, string>(),
}));

const abs = (p: string) => path.resolve(p);
const fx = (...parts: string[]) => path.join(FIXTURE_BASE, ...parts);
const vitestRootWithSep = `${abs(VITEST_FS_BASE)}${path.sep}`;
const isFixturePath = (p: string) => {
  const resolved = abs(p);
  return resolved === vitestRootWithSep.slice(0, -1) || resolved.startsWith(vitestRootWithSep);
};

function setFile(p: string, content = "") {
  state.entries.set(abs(p), { kind: "file", content });
}

vi.mock("node:fs", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs")>();
  const wrapped = {
    ...actual,
    existsSync: (p: string) =>
      isFixturePath(p) ? state.entries.has(abs(p)) : actual.existsSync(p),
    readFileSync: (p: string, encoding?: unknown) => {
      if (!isFixturePath(p)) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return actual.readFileSync(p as any, encoding as any) as unknown;
      }
      const entry = state.entries.get(abs(p));
      if (!entry || entry.kind !== "file") {
        throw new Error(`ENOENT: no such file, open '${p}'`);
      }
      return encoding ? entry.content : Buffer.from(entry.content, "utf-8");
    },
    statSync: (p: string) => {
      if (!isFixturePath(p)) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return actual.statSync(p as any) as unknown;
      }
      const entry = state.entries.get(abs(p));
      if (!entry) {
        throw new Error(`ENOENT: no such file or directory, stat '${p}'`);
      }
      return {
        isFile: () => entry.kind === "file",
        isDirectory: () => entry.kind === "dir",
      };
    },
    realpathSync: (p: string) =>
      isFixturePath(p) ? (state.realpaths.get(abs(p)) ?? abs(p)) : actual.realpathSync(p),
  };
  return { ...wrapped, default: wrapped };
});

vi.mock("node:fs/promises", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs/promises")>();
  const wrapped = {
    ...actual,
    readFile: async (p: string, encoding?: unknown) => {
      if (!isFixturePath(p)) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return (await actual.readFile(p as any, encoding as any)) as unknown;
      }
      const entry = state.entries.get(abs(p));
      if (!entry || entry.kind !== "file") {
        throw new Error(`ENOENT: no such file, open '${p}'`);
      }
      return entry.content;
    },
  };
  return { ...wrapped, default: wrapped };
});

describe("resolveRavenoxPackageRoot", () => {
  beforeEach(() => {
    state.entries.clear();
    state.realpaths.clear();
  });

  it("resolves package root from .bin argv1", async () => {
    const { resolveRavenoxPackageRootSync } = await import("..ravenox-root.js");

    const project = fx("bin-scenario");
    const argv1 = path.join(project, "node_modules", ".bin", .ravenox");
    const pkgRoot = path.join(project, "node_modules", .ravenox");
    setFile(path.join(pkgRoot, "package.json"), JSON.stringify({ name: .ravenox" }));

    expect(resolveRavenoxPackageRootSync({ argv1 })).toBe(pkgRoot);
  });

  it("resolves package root via symlinked argv1", async () => {
    const { resolveRavenoxPackageRootSync } = await import("..ravenox-root.js");

    const project = fx("symlink-scenario");
    const bin = path.join(project, "bin", .ravenox");
    const realPkg = path.join(project, "real-pkg");
    state.realpaths.set(abs(bin), abs(path.join(realPkg, .ravenox.mjs")));
    setFile(path.join(realPkg, "package.json"), JSON.stringify({ name: .ravenox" }));

    expect(resolveRavenoxPackageRootSync({ argv1: bin })).toBe(realPkg);
  });

  it("prefers moduleUrl candidates", async () => {
    const { resolveRavenoxPackageRootSync } = await import("..ravenox-root.js");

    const pkgRoot = fx("moduleurl");
    setFile(path.join(pkgRoot, "package.json"), JSON.stringify({ name: .ravenox" }));
    const moduleUrl = pathToFileURL(path.join(pkgRoot, "dist", "index.js")).toString();

    expect(resolveRavenoxPackageRootSync({ moduleUrl })).toBe(pkgRoot);
  });

  it("returns null for non.ravenox package roots", async () => {
    const { resolveRavenoxPackageRootSync } = await import("..ravenox-root.js");

    const pkgRoot = fx("not.ravenox");
    setFile(path.join(pkgRoot, "package.json"), JSON.stringify({ name: "not.ravenox" }));

    expect(resolveRavenoxPackageRootSync({ cwd: pkgRoot })).toBeNull();
  });

  it("async resolver matches sync behavior", async () => {
    const { resolveRavenoxPackageRoot } = await import("..ravenox-root.js");

    const pkgRoot = fx("async");
    setFile(path.join(pkgRoot, "package.json"), JSON.stringify({ name: .ravenox" }));

    await expect(resolveRavenoxPackageRoot({ cwd: pkgRoot })).resolves.toBe(pkgRoot);
  });
});
