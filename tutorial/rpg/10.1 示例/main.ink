// 10.1 实体:game.md 的 kinds 声明一种"会冒出来、会被消灭"的东西(这里是地窖里的老鼠)。
// spawn 刷出一只并返回它的 id;stat / add_stat 读写它的属性;生命到 0 就自动移走(remove: life);
// alive 数还剩几只;pick_one 挑一只(random 走这一局的骰子,lowest:life 挑最弱的);name_of 是它在面板上的名字。
// 随机表的一行可以写 spawn: 模板(和 count、stats),spawn_from("表") 就按掷到的行刷出来。
INCLUDE _engine.ink
VAR rounds = 0

{t("地窖的门一开,黑暗里有东西在动。", "The cellar door opens; something moves in the dark.")}
-> spawn_some

=== spawn_some ===
// spawn_from 掷「地窖」表,按那一行的 spawn/count 刷出老鼠,返回掷出的点数,好用 table_text 讲出来。
~ temp r = spawn_from("cellar")
{t("冒出来{table_text("cellar", r)}。", "Out comes {table_text("cellar", r)}.")}
-> fight

=== fight ===
{ alive("foe") == 0: -> cleared }
{ hp <= 0: -> beaten }
~ temp weakest = pick_one("foe", "lowest:life")
+ [{t("打{name_of(weakest)}", "Hit {name_of(weakest)}")} #check:might:8]
    { check("might", 8) >= 3:
        ~ add_stat(weakest, "life", -1)
        {t("打中了。", "A hit.")}
    - else:
        {t("落空了。", "A miss.")}
    }
    -> bites
+ [{t("退出去,关上门", "Back out and shut the door")}]
    {t("你关上门,听着里面窸窸窣窣。", "You shut the door and listen to the scratching.")}
    -> END

=== bites ===
// 每只活着的老鼠都咬一口:随机挑一只来咬,咬的次数 = 剩几只。
~ temp n = alive("foe")
{ n > 0:
    ~ temp biter = pick_one("foe", "random")
    ~ hp -= stat(biter, "bite") * n
    {t("{name_of(biter)}它们扑上来,你掉了 {n} 点体力。", "{name_of(biter)} and the rest lunge; you lose {n} health.")}
}
~ rounds += 1
{ rounds == 2 && alive("foe") > 0: -> spawn_some }
-> fight

=== cleared ===
{t("地窖安静了。", "The cellar goes quiet.")}
-> END

=== beaten ===
{t("你爬出地窖,今天就到这里。", "You crawl out of the cellar. That is enough for today.")}
-> END
