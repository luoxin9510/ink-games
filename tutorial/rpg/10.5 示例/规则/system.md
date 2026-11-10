---
version: "1.0"
pack:
  name: { zh: 10.5 示例规则, en: 10.5 example rules }
rules: { kind: sum, dice: [6, 6] }
languages: [zh, en]
skills:
  - { id: might, name: { zh: 力气, en: Might } }
  - { id: wits, name: { zh: 机灵, en: Wits } }
resources:
  - { id: life, name: { zh: 生命, en: Life }, min: 0, max: 10, initial: 6 }
  - { id: xp, name: { zh: 经验, en: Experience }, min: 0, max: 99, initial: 0 }
  - { id: gold, name: { zh: 金币, en: Gold }, min: 0, max: 99, initial: 3 }
levels: { resource: xp, at: [0, 4, 10] }
slots:
  - { id: weapon, name: { zh: 武器, en: Weapon } }
items:
  - { id: sword, name: { zh: 短剑, en: Short sword }, slot: weapon, modifiers: { might: 1 } }
  - { id: axe, name: { zh: 战斧, en: War axe }, slot: weapon, modifiers: { might: 2 } }
  - { id: herb, name: { zh: 草药, en: Herbs }, desc: { zh: 吃一把 +2 生命, en: "+2 life a handful" }, stack: true }
  - { id: brave, name: { zh: 天赋·勇猛, en: "Perk: Brave" }, modifiers: { might: 1 } }
  - { id: sharp, name: { zh: 天赋·敏锐, en: "Perk: Sharp" }, modifiers: { wits: 1 } }
statuses:
  - { id: wounded, name: { zh: 受伤, en: Wounded }, desc: { zh: 休息才能好, en: Heals with rest }, modifiers: { might: -1 }, rest: true }
---

# 10.5 示例的共用规则

三个故事(冒险一、营地、冒险二)都用 `system: ../规则` 叠在这上面。天赋是普通物品,带着就加值。
