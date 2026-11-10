// 10.2 小地城:队伍(party)、敌人(kinds)、表里刷怪(spawn_from)拼在一起。
// 队员的 id(miner、prentice、hound)和怪物的 id 一样能用 stat / add_stat / name_of;
// pick_one("party", "random") 挑一个还站着的队员,alive("party") 数还站着几个。
INCLUDE _engine.ink
VAR depth = 0

{t("旧盐矿的井口吹上来一股咸风。三个人点上灯,往下走。", "A salty wind comes up the old mine shaft. Three of you light the lamps and go down.")}
-> deeper

=== deeper ===
~ depth += 1
{ depth >= 5:
    {t("最底下一层,盐壁上坐着一个白色的东西。", "On the lowest level something white sits against the salt wall.")}
    ~ spawn("foe", "king")
    -> fight
}
~ temp r = spawn_from("tunnel")
{t("第 {depth} 层:{table_text("tunnel", r)}。", "Level {depth}: {table_text("tunnel", r)}.")}
{ table_id("tunnel", r) == "vein":
    ~ salt += 3
    {t("凿下来三袋盐。", "You chip off three sacks of salt.")}
}
-> fight

=== fight ===
{ alive("party") == 0: -> lost }
{ alive("foe") == 0: -> clear }
~ temp target = pick_one("foe", "lowest:life")
+ {stat("miner", "life") > 0} [{t("矿工抡镐,打{name_of(target)}", "The miner swings at {name_of(target)}")}]
    -> strike("miner", target)
+ {stat("prentice", "life") > 0} [{t("学徒扔石头,打{name_of(target)}", "The apprentice throws a stone at {name_of(target)}")}]
    -> strike("prentice", target)
+ {stat("hound", "life") > 0} [{t("猎犬扑{name_of(target)}", "The hound goes for {name_of(target)}")}]
    -> strike("hound", target)
+ [{t("往回跑", "Run back up")}]
    -> fled

=== strike(who, target) ===
// 掷 d6 加力气,每满 3 点打掉一点生命。
~ temp harm = (roll("1d6") + stat(who, "might")) / 3
{ harm > 0:
    ~ add_stat(target, "life", 0 - harm)
    {t("{name_of(who)}打中了,{harm} 点。", "{name_of(who)} hits for {harm}.")}
- else:
    {t("{name_of(who)}落空了。", "{name_of(who)} misses.")}
}
~ foes_bite(1)
-> fight

// 第 k 只活着的东西咬一个随机的、还站着的队员,然后轮到下一只。
=== function foes_bite(k) ===
{ k > alive("foe") || alive("party") == 0:
    ~ return
}
~ temp biter = nth_one("foe", k)
~ temp victim = pick_one("party", "random")
~ add_stat(victim, "life", 0 - stat(biter, "bite"))
{t("{name_of(biter)}咬了{name_of(victim)}。", "{name_of(biter)} bites {name_of(victim)}.")}
{ stat(victim, "life") <= 0:
    {t("{name_of(victim)}倒下了。", "{name_of(victim)} goes down.")}
}
~ foes_bite(k + 1)

=== clear ===
{ depth >= 5:
    {t("盐王碎成一地白渣。你们带着 {salt} 袋盐爬出井口。", "The Salt King crumbles to white grit. You climb out with {salt} sacks of salt.")}
    -> END
}
+ [{t("再往下走", "Go deeper")}]
    -> deeper
+ [{t("带着盐上去", "Take the salt up")}]
    {t("你们带着 {salt} 袋盐回到地面。", "You come back up with {salt} sacks of salt.")}
    -> END

=== fled ===
{t("你们丢下灯往上爬。带出来 {salt} 袋盐。", "You drop the lamps and climb. You bring out {salt} sacks of salt.")}
-> END

=== lost ===
{t("灯一盏一盏灭了。盐矿又安静了。", "The lamps go out one by one. The mine is quiet again.")}
-> END
