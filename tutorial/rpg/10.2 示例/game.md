---
rules: { kind: sum, dice: [6] }
languages: [zh, en]
skills:
  - { id: grit, name: { zh: 胆量, en: Grit } }
characters:
  - { id: you, name: { zh: 你们, en: You }, skills: { grit: 0 } }
resources:
  - { id: salt, name: { zh: 盐, en: Salt }, min: 0, max: 20, initial: 0 }
party:
  name: { zh: 下矿的人, en: The crew }
  stats:
    - { id: life, name: { zh: 生命, en: Life }, max: life_max }
    - { id: life_max, hidden: true }
    - { id: might, name: { zh: 力气, en: Might } }
  down: life
  members:
    - { id: miner, name: { zh: 矿工, en: Miner }, stats: { life: 5, life_max: 5, might: 2 } }
    - { id: prentice, name: { zh: 学徒, en: Apprentice }, stats: { life: 3, life_max: 3, might: 1 } }
    - { id: hound, name: { zh: 猎犬, en: Hound }, stats: { life: 3, life_max: 3, might: 1 } }
kinds:
  - id: foe
    name: { zh: 坑道里的东西, en: In the tunnel }
    stats:
      - { id: life, name: { zh: 生命, en: Life }, max: life_max }
      - { id: life_max, hidden: true }
      - { id: bite, name: { zh: 伤害, en: Harm } }
    remove: life
    templates:
      - { id: bat, name: { zh: 蝙蝠, en: Bat }, stats: { life: 1, life_max: 1, bite: 1 } }
      - { id: worm, name: { zh: 盐虫, en: Salt worm }, stats: { life: 2, life_max: 2, bite: 1 } }
      - { id: wisp, name: { zh: 矿灵, en: Mine wisp }, stats: { life: 3, life_max: 3, bite: 2 } }
      - { id: king, name: { zh: 盐王, en: Salt King }, stats: { life: 7, life_max: 7, bite: 2 } }
tables:
  - id: tunnel
    name: { zh: 坑道, en: Tunnel }
    dice: d6
    rows:
      - { range: 1, zh: 空荡荡的岔道, en: an empty side passage }
      - { range: 2, zh: 一群蝙蝠, en: a flock of bats, spawn: bat, count: d3+1 }
      - { range: 3, zh: 两条盐虫, en: two salt worms, spawn: worm, count: 2 }
      - { range: 4, id: vein, zh: 一道白花花的盐脉, en: a glittering salt vein }
      - { range: 5, zh: 一团矿灵, en: a mine wisp, spawn: wisp }
      - { range: 6, zh: 一条老盐虫, en: an old salt worm, spawn: worm, stats: { life: 4, life_max: 4, bite: 2 } }
---

# 10.2 示例:旧盐矿

三个人下一座废了的盐矿。每往下一层掷一次「坑道」表:可能空着,可能有盐,可能有东西。打的时候挑一个人出手,打最弱的那只;然后每只活着的东西随机咬一个还站着的人。第五层是盐王。随时可以带着盐爬上去。

`kinds`(敌人)、`party`(队伍)和 `spawn_from`(表里刷怪)一起用,没有一行战斗代码在引擎里。
