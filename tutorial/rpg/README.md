# 做一个 RPG(Inkwright 教程第十章)

用 [Inkwright](https://github.com/luoxin9510/inkwright)(Obsidian 插件)在 ink 里做角色扮演游戏:会冒出来的敌人、小地城、规则包、物品和状态、成长和战役、回合战斗、叙事检定。每节有一个能玩的示例。示例都是双语的,网页上可以换语言。

读法:先读一节的笔记,再在网页上玩它的示例,最后把示例文件夹复制进自己的 Obsidian vault,打开 `main.ink`,在 Inkwright 的面板里改着玩。示例里引用的规则包在本仓库的 [`systems/`](../../systems/) 里。在 Obsidian 里用命令「安装规则包」可以把包下载到 `规则包/`;用「新建游戏」可以直接从包开一个新游戏。

| 节 | 讲什么 | 示例 |
|---|---|---|
| [10.1 实体](10.1%20实体.md) | `kinds:`、`spawn`、`stat`、`alive`、表里刷怪 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-1/) · [源文件](10.1%20示例/) |
| [10.2 小地城](10.2%20小地城.md) | 队伍 + 敌人 + 随机表,一个完整的小地城 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-2/) · [源文件](10.2%20示例/) |
| [10.3 用规则包](10.3%20用规则包.md) | `system:`、同 id 替换、「新建游戏」 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-3/) · [源文件](10.3%20示例/) |
| [10.4 物品、装备和状态](10.4%20物品、装备和状态.md) | 数量、装备栏、中毒这类状态 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-4/) · [源文件](10.4%20示例/) |
| [10.5 成长和战役](10.5%20成长和战役.md) | 经验、升级、角色卡、两次冒险 | [玩冒险一](https://luoxin9510.github.io/ink-games/rpg-10-5-well/) · [源文件](10.5%20示例/)(角色卡只能在 Obsidian 里写) |
| [10.6 回合战斗](10.6%20回合战斗.md) | 「回合战斗」包,一个故事打两场 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-6/) · [源文件](10.6%20示例/) |
| [10.7 叙事检定包](10.7%20叙事检定包.md) | 「叙事检定」包:检定、心声、同伴 | [玩](https://luoxin9510.github.io/ink-games/rpg-10-7/) · [源文件](10.7%20示例/) |

规则包本身也有能玩的模板:[回合战斗](https://luoxin9510.github.io/ink-games/turn-battle/)、[地城爬行](https://luoxin9510.github.io/ink-games/dungeon-crawl/)、[叙事检定](https://luoxin9510.github.io/ink-games/narrative-check/)。

教程里提到的路径(比如 `../../../规则包/turn-battle`)是 vault 里的写法;在这个仓库里,示例指向 `../../../systems/<包>`。
