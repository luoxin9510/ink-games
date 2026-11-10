# ink-games (public)

Public repo of the user's ink games, published to https://luoxin9510.github.io/ink-games/ by `.github/workflows/pages.yml`.

- Source of truth is the Obsidian vault `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ink-games` (iCloud, also edited on the phone); never put a git repo inside it. Write and playtest there with the Inkwright plugin (see the vault's own CLAUDE.md for the agent API).
- Publish a game: add it to `games.json` (`slug` = URL-safe English name, `vault` = folder in the vault, `languages` = ["zh","en"] for bilingual games, `title`, `description`), run `scripts/sync-from-vault.sh <slug>`, add it to the README's game list, open a PR. CI plays every branch in each language (`check-ink --all`) and must pass.
- Local build: `INKWRIGHT=../inkwright node scripts/build-site.mjs` (needs `npm ci` in ~/Developer/inkwright).
- Games are bilingual: `VAR 语言 = "zh"` + `{双("中文", "English")}` (see the vault's `游戏/雨夜来客/双语.ink`).
- Commits/PRs in English. Story text is the user's creative work: draft with them, don't publish without their OK.
- Rule packs: `systems/<id>/` = Inkwright's `packs/<id>/` copied as is (template `_engine.ink` included, not listed in `files:`); after changing a pack in inkwright, copy it here (`rsync -a --exclude='.*' ../inkwright/packs/<id>/ systems/<id>/`), run `node scripts/systems.mjs --write`, and merge the inkwright change first (the build compares with inkwright main). The plugin's "Install rule pack" reads `systems/index.json` and each `system.md`'s `files:` from the raw URLs of main.
- Tutorial chapter 10 (`tutorial/rpg/`) is copied from the vault's `教程/第十章 做一个 RPG/` (written by Claude for the plugin, not the user's stories); in the examples' `game.md` the pack path is `../../../systems/<id>` instead of the vault's `../../../规则包/<id>`. games.json entries with `path` build from these folders.
