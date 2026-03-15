import esbuild from 'esbuild';
import path from 'node:path';
import fs from 'node:fs';

const entries = [
  "src/index.ts",
  "src/entry.ts",
  "src/cli/daemon-cli.ts",
  "src/infra/warning-filter.ts",
  "src/plugin-sdk/index.ts",
  "src/plugin-sdk/account-id.ts",
  "src/extensionAPI.ts",
  "src/hooks/llm-slug-generator.ts",
];

async function build() {
  console.log("Starting esbuild...");
  
  for (const entry of entries) {
    const relativePath = entry.replace("src/", "").replace(".ts", ".js");
    const outfile = path.join("dist", relativePath);
    console.log(`Building ${entry} -> ${outfile}`);
    
    try {
      const outDir = path.dirname(outfile);
      if (!fs.existsSync(outDir)) {
        fs.mkdirSync(outDir, { recursive: true });
      }
      await esbuild.build({
        entryPoints: [entry],
        bundle: true,
        platform: "node",
        format: "esm",
        target: "node22",
        outfile: outfile,
        external: [
          "node:*",
          "@buape/carbon",
          "playwright-core",
          "@whiskeysockets/baileys",
          "sharp",
          "sqlite-vec",
          "canvas",
          "node-llama-cpp",
          "jiti",
          "fsevents",
          "v8-compile-cache-lib",
          "better-sqlite3"
        ],
        loader: {
           ".node": "copy",
           ".html": "text"
        },
        banner: {
          js: `import { createRequire } from 'module'; const require = createRequire(import.meta.url);`,
        },
      });
    } catch (err) {
      console.error(`Failed to build ${entry}:`, err);
    }
  }
  
  console.log("esbuild complete.");
}

build();
