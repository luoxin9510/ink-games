# ink-games (public)

Public repo of the user's ink games, published to https://luoxin9510.github.io/ink-games/ by `.github/workflows/pages.yml`.

- Source of truth is the Obsidian vault `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ink-games` (iCloud, also edited on the phone); never put a git repo inside it. Write and playtest there with the Inkwright plugin (see the vault's own CLAUDE.md for the agent API).
- Publish a game: add it to `games.json` (`slug` = URL-safe English name, `vault` = folder in the vault, `languages` = ["zh","en"] for bilingual games, `title`, `description`), run `scripts/sync-from-vault.sh <slug>`, add it to the README's game list, open a PR. CI plays every branch in each language (`check-ink --all`) and must pass.
- Local build: `INKWRIGHT=../inkwright node scripts/build-site.mjs` (needs `npm ci` in ~/Developer/inkwright).
- Games are bilingual: `VAR 语言 = "zh"` + `{双("中文", "English")}` (see the vault's `游戏/雨夜来客/双语.ink`).
- Commits/PRs in English. Story text is the user's creative work: draft with them, don't publish without their OK.
