---
system: { path: "../../../systems/dungeon-crawl", version: 1 }
# 下面两项替换规则包里的同名内容,其余(规则、怪物、表)都用包的。
resources:
  - { id: torches, name: { zh: 火把, en: Torches }, min: 0, max: 12, initial: 4 }
party:
  name: { zh: 三兄妹, en: The siblings }
  stats:
    - { id: life, name: { zh: 生命, en: Life }, max: life_max }
    - { id: life_max, hidden: true }
    - { id: might, name: { zh: 力气, en: Might } }
    - { id: guard, name: { zh: 护甲, en: Guard } }
  down: life
  members:
    - { id: elder, name: { zh: 大哥, en: Eldest }, stats: { life: 7, life_max: 7, might: 2, guard: 1 } }
    - { id: middle, name: { zh: 二姐, en: Middle }, stats: { life: 6, life_max: 6, might: 2, guard: 1 } }
    - { id: youngest, name: { zh: 小妹, en: Youngest }, stats: { life: 5, life_max: 5, might: 1, guard: 1 } }
---

# 10.3 示例:三兄妹下地城

规则、怪物和表都来自「地城爬行」规则包(`systems/dungeon-crawl/`)。这里只换了两样:队伍换成三兄妹,火把只带 4 支。地城只有 5 间(`main.ink` 里的 `crawl_rooms`)。改完运行「生成游戏引擎 ink」。
