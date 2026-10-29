// Build the GitHub Pages site: every game in games.json is checked (every branch, in each
// language it supports) and exported to _site/<slug>/index.html, plus an index page.
// Needs a checkout of luoxin9510/inkwright with dependencies installed, at $INKWRIGHT (default ../inkwright).
import { execFileSync } from "node:child_process";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { resolve } from "node:path";

const inkwright = resolve(process.env.INKWRIGHT ?? "../inkwright");
const games = JSON.parse(readFileSync("games.json", "utf8"));
const run = (script, args) =>
  execFileSync("npm", ["run", "--silent", script, "--", ...args], { cwd: inkwright, stdio: "inherit" });

mkdirSync("_site", { recursive: true });
for (const g of games) {
  const dir = resolve("games", g.slug);
  for (const lang of g.languages ?? ["zh"]) run("check-ink", [dir, "--all", "--quiet", "--lang", lang]);
  run("export-web", [resolve(dir, "main.ink"), resolve("_site", g.slug, "index.html"), "--lang", g.languages?.[0] ?? "zh", "--id", g.slug]);
}

const esc = (s) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
const cards = games.map((g) => `
  <a class="game" href="${esc(g.slug)}/">
    <h2>${esc(g.title)}</h2>
    <p>${esc(g.description ?? "")}</p>
  </a>`).join("") || `<p class="empty">Coming soon. / 敬请期待。</p>`;
writeFileSync("_site/index.html", `<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ink games</title>
<style>
:root { --bg: #fbfaf7; --fg: #222; --muted: #777; --accent: #7a4fd0; --line: #ddd; }
@media (prefers-color-scheme: dark) { :root { --bg: #1c1b1f; --fg: #e6e3ea; --muted: #8a8690; --accent: #b79cff; --line: #3a3840; } }
body { margin: 0; background: var(--bg); color: var(--fg); font: 17px/1.7 -apple-system, "PingFang SC", "Noto Sans CJK SC", system-ui, sans-serif; }
main { max-width: 44em; margin: 0 auto; padding: 40px 16px 64px; }
h1 { margin: 0 0 .2em; }
.sub { color: var(--muted); margin: 0 0 2em; }
.game { display: block; padding: 16px 20px; margin-bottom: 12px; border: 1px solid var(--line); border-radius: 10px; color: inherit; text-decoration: none; }
.game:hover { border-color: var(--accent); }
.game h2 { margin: 0; font-size: 1.15em; color: var(--accent); }
.game p { margin: .3em 0 0; color: var(--muted); }
footer { margin-top: 3em; color: var(--muted); font-size: .85em; }
a { color: var(--accent); }
</style>
</head>
<body>
<main>
<h1>ink games</h1>
<p class="sub">Interactive fiction written in <a href="https://www.inklestudios.com/ink/">ink</a>, playable in your browser. / 用 ink 写的文字游戏，打开就能玩。</p>
${cards}
<footer>Made with <a href="https://github.com/luoxin9510/inkwright">Inkwright</a>, an Obsidian plugin for writing ink. Source: <a href="https://github.com/luoxin9510/ink-games">luoxin9510/ink-games</a>.</footer>
</main>
</body>
</html>
`);
console.log(`built _site with ${games.length} game(s)`);
