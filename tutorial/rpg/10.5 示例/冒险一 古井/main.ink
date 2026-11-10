// 冒险一:英雄从这里出发,结尾写出角色卡。
INCLUDE _engine.ink

{t("村口的古井里传出怪声。阿岚握紧短剑,顺着绳子爬了下去。", "Strange sounds rise from the old well. Lan grips her short sword and climbs down the rope.")}
-> rats

=== rats ===
{t("井底的水洼边挤着一群老鼠。", "Rats crowd the puddle at the bottom.")}
+ [{t("赶走它们", "Drive them off")} #check:might:8]
    { check("might", 8) >= 3:
        {t("老鼠四散逃开。", "The rats scatter.")}
    - else:
        {t("被咬了好几口。", "They bite you more than once.")}
        ~ life -= 2
        ~ add_status("me", "wounded", 0)
    }
    ~ xp += 2
- -> tunnel

=== tunnel ===
{t("一条窄道通向一具旧骸骨,骨头边上靠着一把战斧。", "A narrow tunnel leads to old bones, a war axe leaning beside them.")}
+ [{t("拿起战斧", "Take the axe")}]
    ~ give(axe, 1)
    ~ xp += 2
    {t("战斧很沉,但比短剑顺手。", "It is heavy, but it suits you better than the sword.")}
+ [{t("什么也不碰", "Touch nothing")}]
    ~ xp += 2
-
{t("窄道尽头有光。你爬出来,已经在村子的另一头。", "Light at the end of the tunnel. You climb out on the far side of the village.")}
{t("阿岚回到村里,天黑了。", "Lan comes back to the village as night falls.")} #sheet
-> END
