---
rules: { kind: sum, dice: [6, 6] }
languages: [zh, en]
skills:
  - { id: might, name: { zh: 力气, en: Might } }
  - { id: wits, name: { zh: 机灵, en: Wits } }
characters:
  - { id: walker, name: { zh: 旅人, en: Walker }, skills: { might: 1, wits: 1 }, items: [dagger], counts: { antidote: 1 } }
resources:
  - { id: life, name: { zh: 生命, en: Life }, min: 0, max: 6, initial: 6 }
  - { id: gold, name: { zh: 金币, en: Gold }, min: 0, max: 99, initial: 10 }
slots:
  - { id: weapon, name: { zh: 武器, en: Weapon } }
  - { id: body, name: { zh: 身上, en: Body } }
items:
  - { id: dagger, name: { zh: 匕首, en: Dagger }, slot: weapon, modifiers: { might: 1 } }
  - { id: spear, name: { zh: 长矛, en: Spear }, slot: weapon, modifiers: { might: 2 } }
  - { id: cloak, name: { zh: 斗篷, en: Cloak }, slot: body, modifiers: { wits: 1 } }
  - { id: antidote, name: { zh: 解毒剂, en: Antidote }, desc: { zh: 解掉中毒, en: Cures poison }, stack: true }
statuses:
  - { id: poison, name: { zh: 中毒, en: Poisoned }, desc: { zh: 每走一段 -1 生命, en: "-1 life a stretch" }, rest: true }
  - { id: blessed, name: { zh: 祝福, en: Blessed }, modifiers: { wits: 2 } }
---

# 10.4 示例:穿过沼泽

物品有数量(解毒剂)、有装备栏(武器、身上),状态(中毒、祝福)。商店是普通的选项:价格写在剧本里,`gold` 是资源。
