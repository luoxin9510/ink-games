// 冒险二:读进角色卡,打完再写回去。
INCLUDE _engine.ink

{t("荒原上的塔。阿岚 {level} 级,生命 {life},背包里 {inv_count(herb)} 把草药。", "The tower on the moor. Lan, level {level}, life {life}, {inv_count(herb)} herbs in the pack.")}
{ has_status("me", "wounded"):
    {t("旧伤还在隐隐作痛。", "The old wound still aches.")}
}
-> guard

=== guard ===
{t("塔门口站着一个石像守卫。", "A stone guardian stands at the door.")}
+ {inv_count(herb) > 0 && life < 10} [{t("先吃一把草药", "Eat some herbs first")}]
    ~ take(herb, 1)
    ~ life += 2
    -> guard
+ [{t("砍倒它", "Hew it down")} #check:might:10]
    { check("might", 10) >= 3:
        {t("石像碎了一地。", "The statue falls to pieces.")}
        ~ xp += 4
    - else:
        {t("石拳砸中了你,你只好退走。", "A stone fist strikes you; you fall back.")}
        ~ life -= 3
        ~ xp += 1
    }
+ [{t("从侧面的窗爬进去", "Climb in by a side window")} #check:wits:9]
    { check("wits", 9) >= 3:
        {t("你悄悄溜了进去,找到塔顶的宝箱。", "You slip in unseen and find the chest at the top.")}
        ~ gold += 6
        ~ xp += 3
    - else:
        {t("你从窗台上摔了下来。", "You fall from the sill.")}
        ~ life -= 2
    }
- {t("塔边的风很冷。阿岚往回走。", "The wind is cold by the tower. Lan turns for home.")} #sheet
-> END
