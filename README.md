# ink games

Interactive fiction written in [ink](https://www.inklestudios.com/ink/), playable in your browser. Most games are bilingual (中文 / English) with a language switch.

**Play: https://luoxin9510.github.io/ink-games/**

用 ink 写的文字游戏，打开网页就能玩；大多数是中英双语，可以随时切换语言。

## Games / 游戏

Coming soon. / 敬请期待。

## How they are made / 怎么做出来的

Each game is written in Obsidian with [Inkwright](https://github.com/luoxin9510/inkwright), a plugin for writing, playtesting and debugging ink. Before a game is published, CI plays **every branch in every language** and fails if any path hits a runtime error. Then it exports each game as a single web page and publishes it to GitHub Pages.

每个游戏都是在 Obsidian 里用 [Inkwright](https://github.com/luoxin9510/inkwright) 写的。发布前，CI 会把每个游戏的**每条分支、每种语言**都走一遍，任何一条路线出错都不会发布。走完后，每个游戏会导出成一个独立网页，发布到 GitHub Pages。

## Layout

- `games/<slug>/` — the ink source of a game; `main.ink` is the entry point.
- `games.json` — the list of published games: `slug`, `title`, `description`, `languages`, and `vault` (the game's folder in the Obsidian vault it is synced from).
- `scripts/sync-from-vault.sh <slug>` — copies a game from the vault into `games/<slug>/`.
- `scripts/build-site.mjs` — checks and exports every game into `_site/` (needs a checkout of Inkwright at `$INKWRIGHT`, default `../inkwright`).

Thanks to [inkle](https://www.inklestudios.com/) for ink.
