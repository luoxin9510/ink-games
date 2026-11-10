// 10.4 示例:物品的数量、装备栏和状态。
INCLUDE _engine.ink

CONST SPEAR_PRICE = 6
CONST CLOAK_PRICE = 4
CONST ANTIDOTE_PRICE = 2
VAR stretch = 0

{t("沼泽边上有一家小铺子。你口袋里有 {gold} 枚金币。", "There is a little shop at the edge of the marsh. You have {gold} gold.")}
-> shop

// A shop is just choices: a price, gold taken, the item given.
=== shop ===
+ {gold >= SPEAR_PRICE && inv !? spear} [{t("买长矛({SPEAR_PRICE} 金币)", "Buy a spear ({SPEAR_PRICE} gold)")}]
    ~ gold -= SPEAR_PRICE
    ~ give(spear, 1)
    -> shop
+ {gold >= CLOAK_PRICE && inv !? cloak} [{t("买斗篷({CLOAK_PRICE} 金币)", "Buy a cloak ({CLOAK_PRICE} gold)")}]
    ~ gold -= CLOAK_PRICE
    ~ equip(cloak)
    -> shop
+ {gold >= ANTIDOTE_PRICE} [{t("买一瓶解毒剂({ANTIDOTE_PRICE} 金币)", "Buy an antidote ({ANTIDOTE_PRICE} gold)")}]
    ~ gold -= ANTIDOTE_PRICE
    ~ give(antidote, 1)
    -> shop
+ {inv ? spear && equipped !? spear} [{t("换上长矛", "Take up the spear")}]
    ~ equip(spear)
    -> shop
+ [{t("上路", "Set off")}]
    -> marsh

// Each stretch is a turn: poison bites, statuses count down.
=== marsh ===
~ stretch += 1
{ has_status("me", "poison"):
    {t("毒在发作。", "The poison burns.")}
    ~ life -= 1
}
~ tick_statuses()
{ life <= 0:
    {t("你倒在了泥里。", "You fall into the mud.")}
    -> END
}
{ stretch > 4:
    {t("你走出了沼泽,还剩 {life} 点生命、{inv_count(antidote)} 瓶解毒剂。", "You come out of the marsh with {life} life left; antidotes: {inv_count(antidote)}.")}
    -> END
}
{t("第 {stretch} 段路。", "Stretch {stretch}.")}
+ {has_status("me", "poison") && inv_count(antidote) > 0} [{t("喝一瓶解毒剂(还有 {inv_count(antidote)} 瓶)", "Drink an antidote ({inv_count(antidote)} left)")}]
    ~ take(antidote, 1)
    ~ clear_status("me", "poison")
    {t("毒解了。", "The poison is gone.")}
    -> marsh
+ [{t("往前走", "Walk on")}]
    -> meet

=== meet ===
{ stretch % 2 == 1:
    {t("一条蛇从草里窜出来。", "A snake darts out of the reeds.")}
    + [{t("打它", "Strike it")} #check:might:9]
        { check("might", 9) >= 3:
            {t("你把蛇赶走了。", "You drive the snake off.")}
        - else:
            {t("蛇咬了你一口。", "The snake bites you.")}
            ~ add_status("me", "poison", 3)
        }
        -> marsh
- else:
    {t("一座长满青苔的小神龛。", "A little shrine grown over with moss.")}
    + [{t("祈祷", "Pray")}]
        ~ add_status("me", "blessed", 3)
        ~ rest_statuses()
        {t("你觉得清醒了,身上的毒也退了。", "Your head clears, and the poison fades.")}
        -> marsh
    + [{t("从旁边绕过去", "Slip past")} #check:wits:10]
        { check("wits", 10) < 3:
            ~ life -= 1
            {t("你滑了一跤。", "You slip.")}
        }
        -> marsh
}
