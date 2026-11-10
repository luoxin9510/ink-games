// The rule-system packs in systems/<id>/, which Inkwright's "Install rule pack" downloads. Checks that each pack's
// system.md lists exactly its files (`files:`; the template's generated _engine.ink is left out), that a first-party
// pack is the same as Inkwright's packs/<id>/, and that systems/index.json lists every pack with its version, name and
// description. `--write` rewrites index.json instead of checking it.
// Needs a checkout of luoxin9510/inkwright with dependencies installed, at $INKWRIGHT (default ../inkwright).
import { createRequire } from "node:module";
import { existsSync, readdirSync, readFileSync, statSync, writeFileSync } from "node:fs";
import { join, relative, resolve } from "node:path";

const inkwright = resolve(process.env.INKWRIGHT ?? "../inkwright");
const { parse } = createRequire(join(inkwright, "package.json"))("yaml");
const ROOT = "systems";
const problems = [];

const walk = (dir) => readdirSync(dir).filter((n) => !n.startsWith(".")).flatMap((n) => {
  const p = join(dir, n);
  return statSync(p).isDirectory() ? walk(p) : [p];
});
const frontmatter = (text) => {
  const m = /^---\r?\n([\s\S]*?)\r?\n---/.exec(text);
  return m ? parse(m[1]) : null;
};

const packs = [];
for (const id of readdirSync(ROOT).sort()) {
  const dir = join(ROOT, id);
  if (!statSync(dir).isDirectory()) continue;
  if (!/^[a-z0-9]+(?:-[a-z0-9]+)*$/.test(id)) problems.push(`${id}: a pack id is lower-case letters, digits and dashes`);
  const files = walk(dir).map((p) => relative(dir, p).split("\\").join("/")).sort();
  const fm = frontmatter(readFileSync(join(dir, "system.md"), "utf8")) ?? {};
  const listed = Array.isArray(fm.files) ? [...fm.files].sort() : null;
  const want = files.filter((f) => f !== "system.md" && f !== "template/_engine.ink");
  if (!listed) problems.push(`${id}: system.md has no files: list`);
  else if (JSON.stringify(listed) !== JSON.stringify(want)) problems.push(`${id}: files: lists ${JSON.stringify(listed)}, the folder has ${JSON.stringify(want)}`);
  if (typeof fm.version !== "string") problems.push(`${id}: version must be a quoted string`);
  const upstream = join(inkwright, "packs", id);
  if (existsSync(upstream)) {
    const theirs = walk(upstream).map((p) => relative(upstream, p).split("\\").join("/")).sort();
    if (JSON.stringify(theirs) !== JSON.stringify(files)) problems.push(`${id}: files differ from inkwright/packs/${id}`);
    for (const f of files.filter((f) => theirs.includes(f))) {
      if (readFileSync(join(dir, f), "utf8") !== readFileSync(join(upstream, f), "utf8")) problems.push(`${id}/${f}: differs from inkwright/packs/${id}/${f}`);
    }
  }
  packs.push({ id, version: String(fm.version ?? ""), name: fm.pack?.name ?? id, description: fm.pack?.description ?? "" });
}

const index = `${JSON.stringify({ packs }, null, 2)}\n`;
const indexPath = join(ROOT, "index.json");
if (process.argv.includes("--write")) writeFileSync(indexPath, index);
else if (!existsSync(indexPath) || readFileSync(indexPath, "utf8") !== index) problems.push("systems/index.json is out of date: run node scripts/systems.mjs --write");

if (problems.length > 0) {
  console.error(problems.join("\n"));
  process.exit(1);
}
console.log(`systems: ${packs.length} pack(s) ok`);
