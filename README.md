# ink games

Interactive fiction written in [ink](https://www.inklestudios.com/ink/), playable in your browser. Most games are bilingual (中文 / English) with a language switch.

**Play: https://luoxin9510.github.io/ink-games/**

用 ink 写的文字游戏，打开网页就能玩；大多数是中英双语，可以随时切换语言。

## Games / 游戏

Tutorial examples and rule-pack templates for now; the games list is on the site. / 目前是教程示例和规则包的模板,列表见网站。

## Rule packs / 规则包

[\`systems/\`](systems/) holds Inkwright's first-party rule packs (turn battle, dungeon crawl, narrative checks). In Obsidian, Inkwright's command "Install rule pack" downloads one into your vault; "New game" starts a game on it.

[\`systems/\`](systems/) 里是 Inkwright 的第一方规则包(回合战斗、地城爬行、叙事检定)。在 Obsidian 里用 Inkwright 的命令「安装规则包」下载到 vault,「新建游戏」直接用它开新游戏。

## Tutorial / 教程

[\`tutorial/rpg/\`](tutorial/rpg/) — 做一个 RPG (Inkwright tutorial chapter 10, in Chinese), each section with an example you can play on the site.

## How they are made / 怎么做出来的

Each game is written in Obsidian with [Inkwright](https://github.com/luoxin9510/inkwright), a plugin for writing, playtesting and debugging ink. Before a game is published, CI plays **every branch in every language** and fails if any path hits a runtime error. Then it exports each game as a single web page and publishes it to GitHub Pages.

每个游戏都是在 Obsidian 里用 [Inkwright](https://github.com/luoxin9510/inkwright) 写的。发布前，CI 会把每个游戏的**每条分支、每种语言**都走一遍，任何一条路线出错都不会发布。走完后，每个游戏会导出成一个独立网页，发布到 GitHub Pages。

## Layout

- `games/<slug>/` — the ink source of a game; `main.ink` is the entry point.
- `games.json` — the list of published games: `slug`, `title`, `description`, `languages`, and either `vault` (the game's folder in the Obsidian vault it is synced from) or `path` (the game's folder in this repo, for pack templates and tutorial examples).
- `systems/<id>/` — rule packs; each `system.md` lists its files (`files:`), `systems/index.json` lists the packs (`node scripts/systems.mjs --write`). The first-party packs are copies of Inkwright's `packs/` and the build checks they match.
- `tutorial/rpg/` — tutorial chapter 10 and its examples.
- `scripts/sync-from-vault.sh <slug>` — copies a game from the vault into `games/<slug>/`.
- `scripts/build-site.mjs` — checks and exports every game into `_site/` (needs a checkout of Inkwright at `$INKWRIGHT`, default `../inkwright`).

Thanks to [inkle](https://www.inklestudios.com/) for ink.
