// 营地:读进角色卡,休息、买东西、升级,离开时写回角色卡。
INCLUDE _engine.ink

VAR slept = false

{t("营火边,阿岚数了数口袋:{gold} 枚金币,{inv_count(herb)} 把草药。", "By the fire, Lan counts what is left: {gold} gold, {inv_count(herb)} herbs.")}
-> camp

=== camp ===
+ {not slept} [{t("睡一觉(生命回满,伤好了)", "Sleep (life back to full, wounds heal)")}]
    ~ slept = true
    ~ life = 10
    ~ rest_statuses()
    -> camp
+ {gold >= 2} [{t("买一把草药(2 金币)", "Buy herbs (2 gold)")}]
    ~ gold -= 2
    ~ give(herb, 1)
    -> camp
+ {level_up_ready()} [{t("升级:天赋·勇猛(力气 +1)", "Level up: Brave (+1 might)")}]
    ~ level_up()
    ~ give(brave, 1)
    -> camp
+ {level_up_ready()} [{t("升级:天赋·敏锐(机灵 +1)", "Level up: Sharp (+1 wits)")}]
    ~ level_up()
    ~ give(sharp, 1)
    -> camp
+ {inv ? axe && equipped !? axe} [{t("换上战斧", "Take up the axe")}]
    ~ equip(axe)
    -> camp
+ [{t("收拾行装,出发", "Pack up and go")}]
    {t("天亮了,阿岚 {level} 级,背着行装上路。", "Morning. Lan, level {level}, sets out.")} #sheet
    -> END
