// Two battles in one story: spawn the foes, -> battle ->, read battle_result; HP, MP, potions and poison carry over
// unless the story changes them (the rest below).
INCLUDE _engine.ink

{t("骑士、法师和牧师要在天黑前翻过山口。林子里传来狼嚎。", "The knight, the mage and the cleric must cross the pass before dark. Wolves howl in the woods.")}
~ spawn("foe", "wolf")
~ spawn("foe", "wolf")
~ spawn("foe", "goblin")
-> battle ->
{ battle_result == "lost":
    -> fallen
}
{t("狼群散了。你们在山口下的岩洞里歇了一夜,法力回满了,伤也好了些。", "The pack scatters. You spend the night in a cave below the pass: MP back in full, wounds a little better.")}
~ rest(1)
{t("天亮时到了石桥。桥下坐着一个巨魔,旁边的萨满摇着骨铃。", "At dawn you reach the stone bridge. A troll sits under it, a shaman shaking a bone rattle beside it.")}
* [{t("冲过去", "Charge")}]
    ~ spawn("foe", "troll")
    ~ spawn("foe", "shaman")
    -> battle ->
    { battle_result == "lost":
        -> fallen
    }
    {t("巨魔倒在桥下。你们过了山口,还剩 {potions} 瓶药水。", "The troll falls under the bridge. You cross the pass with {potions} potions left.")}
    -> END
* [{t("绕远路(多走一天,药水少一瓶)", "Go the long way round (a day more, one potion used up)")}]
    ~ potions = MAX(potions - 1, 0)
    {t("你们绕过石桥,多走了一天,还剩 {potions} 瓶药水。", "You go round the bridge, a day longer, with {potions} potions left.")}
    -> END

= fallen
{t("天黑了,山口上没有人走过去。", "Night falls, and nobody crosses the pass.")}
-> END

// A night's rest for the k-th standing hero and those after: MP back in full, 4 HP.
=== function rest(k) ===
~ temp who = nth_one("party", k)
{ who != "":
    ~ set_stat(who, "mp", stat(who, "mp_max"))
    ~ set_stat(who, "hp", MIN(stat(who, "hp") + 4, stat(who, "hp_max")))
    ~ rest(k + 1)
}
