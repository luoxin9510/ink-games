// A narrative game on the pack: checks on choices, voices, fear, a companion's fear and trust, clamp() from the pack.
INCLUDE _engine.ink

{t("闭馆铃响过很久了。灯一盏一盏灭掉,最后只剩你和阿周,还有三根蜡烛。", "The closing bell went long ago. The lights went out one by one; now it is just you, Zhou and three candles.")}
-> stacks

=== stacks ===
~ candle -= 1
{t("蜡烛还剩 {candle} 根。阿周贴着你走。", "{candle} candles left. Zhou stays close.")}
{t("书架之间的过道比白天长。", "The aisles between the shelves are longer than in daylight.")} #voice:insight
* [{t("数一数走过了几排书架", "Count the rows you have passed")} #check:insight:normal]
    { check("insight", 10) >= 3:
        {t("十二排。可是这一层只有十排。你记下了多出来的那两排的编号。", "Twelve rows. This floor only has ten. You note the numbers on the two extra ones.")}
        ~ fear += 10
        -> exit(true)
    - else:
        {t("数到第九排你就乱了。阿周在后面问你还要走多久。", "You lose count at nine. Behind you, Zhou asks how much further.")}
        ~ fear += 25
        ~ fear_zhou = clamp(fear_zhou + 15, 0, 100)
        -> exit(false)
    }
* [{t("和阿周说说话", "Talk to Zhou")} #check:charm:easy]
    { check("charm", 8) >= 3:
        {t("你们说起期末考试,说着说着就笑了。过道好像也没那么长了。", "You talk about the exams and end up laughing. The aisle doesn't seem so long now.")}
        ~ trust_zhou = clamp(trust_zhou + 20, 0, 100)
        ~ fear_zhou = clamp(fear_zhou - 20, 0, 100)
    - else:
        {t("你的声音在书架间回了三遍,第三遍不是你的声音。阿周不说话了。", "Your voice comes back from the shelves three times, and the third time it is not yours. Zhou goes quiet.")}
        ~ fear_zhou = clamp(fear_zhou + 25, 0, 100)
    }
    -> exit(false)

=== exit(counted) ===
~ candle -= 1
{t("楼梯口到了。门是锁着的。", "The stairs. The door is locked.")}
{t("别慌,总有别的出口。", "Don't panic. There's always another way out.")} #voice:reason
* {counted} [{t("去多出来的那两排书架找", "Search the two extra rows")}]
    {t("第十一排的最底层,有一本借阅卡上写着你名字的书。书后面是一扇小门。", "On the bottom shelf of row eleven is a book with your name on its loan card. Behind it, a small door.")}
    -> out
* [{t("一起撞门", "Break the door down together")} #check:strength:hard]
    { check("strength", 12) >= 3 || trust_zhou >= 60:
        {t("你们一起撞上去,第二下门开了。", "You hit it together; it gives on the second try.")}
        -> out
    - else:
        ~ hp -= 3
        {t("门纹丝不动,你的肩膀先撑不住了。最后一根蜡烛也灭了。", "The door doesn't budge, and your shoulder gives first. The last candle goes out.")}
        -> END
    }

= out
{t("外面是街灯。恐惧 {fear};阿周的恐惧 {fear_zhou},信任 {trust_zhou}。", "Streetlights outside. Fear {fear}; Zhou's fear {fear_zhou}, trust {trust_zhou}.")}
-> END
