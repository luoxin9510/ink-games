---
rules: { kind: sum, dice: [6, 6] }
languages: [zh, en]
skills:
  - { id: might, name: { zh: 力气, en: Might } }
resources:
  - { id: hp, name: { zh: 体力, en: Health }, min: 0, max: 6, initial: 6 }
characters:
  - { id: you, name: { zh: 看店的, en: The shopkeeper }, skills: { might: 1 } }
kinds:
  - id: foe
    name: { zh: 地窖里的东西, en: In the cellar }
    stats:
      - { id: life, name: { zh: 生命, en: Life }, max: life_max }
      - { id: life_max, hidden: true }
      - { id: bite, name: { zh: 咬, en: Bite } }
    remove: life
    templates:
      - { id: rat, name: { zh: 老鼠, en: Rat }, stats: { life: 1, life_max: 1, bite: 1 } }
      - { id: big_rat, name: { zh: 大老鼠, en: Big rat }, stats: { life: 3, life_max: 3, bite: 1 } }
tables:
  - id: cellar
    name: { zh: 地窖, en: Cellar }
    rows:
      - { range: 1-3, zh: 一只老鼠, en: a rat, spawn: rat }
      - { range: 4-5, zh: 两只老鼠, en: two rats, spawn: rat, count: 2 }
      - { range: 6, zh: 一只大老鼠, en: a big rat, spawn: big_rat }
---

# 10.1 示例:地窖

地窖里有东西。每一轮掷一次「地窖」表刷出敌人,打到一只不剩,或者体力耗光。
