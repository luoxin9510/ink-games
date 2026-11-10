---
system: { path: "../../../systems/turn-battle", version: 1 }
# 只加了一瓶药水(3 瓶),其余(规则、小队、敌人)都用包的。
resources:
  - { id: potions, name: { zh: 药水, en: Potions }, min: 0, max: 9, initial: 3 }
---

# 10.6 示例:过山

规则、小队和敌人都来自「回合战斗」规则包(`systems/turn-battle/`)。这里只把药水换成 3 瓶。一个故事里打两场:先是狼,然后是桥下的巨魔;中间歇一夜,法力回满、生命 +4。改完运行「生成游戏引擎 ink」。
