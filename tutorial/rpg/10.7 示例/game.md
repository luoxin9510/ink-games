---
system: { path: "../../../systems/narrative-check", version: 1 }
# 规则、难度、五种技能、恐惧和体力、同伴的恐惧和信任都来自包。下面是这个游戏自己的:
# 洞察力换了一个声音(同 id 替换),加了一种资源(蜡烛),两个角色。
skills:
  - { id: insight, name: { zh: 洞察力, en: Insight }, voice: { stance: { zh: 书架在动。, en: "The shelves moved." }, color: "#b07cd8" } }
resources:
  - { id: candle, name: { zh: 蜡烛, en: Candle }, min: 0, max: 3, initial: 3 }
characters:
  - { id: me, name: { zh: 我, en: Me }, skills: { reason: 3, stamina: 2, charm: 4, insight: 4, strength: 2 } }
  - { id: zhou, playable: false, name: { zh: 阿周, en: Zhou }, skills: { reason: 2, stamina: 3, charm: 3, insight: 2, strength: 4 }, companion: { fear: 40, trust: 40 } }
---

# 10.7 示例:停电的图书馆

用「叙事检定」规则包(`systems/narrative-check/`)。游戏只写了自己的东西:洞察力的声音、一种资源(蜡烛,3 根)、两个角色。改完运行「生成游戏引擎 ink」。
