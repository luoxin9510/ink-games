// 10.3 示例:用规则包做游戏。剧本只写开头和结尾,中间的地城由包里的 crawl 段落负责。
INCLUDE _engine.ink

~ crawl_rooms = 5
{t("父亲留下的地图上画着一座地城,最深处打了个叉。三兄妹只找到四支火把,还是下去了。", "Father's map shows a dungeon with a cross in its deepest hall. The three siblings found only four torches, and went down anyway.")}
-> crawl ->
{ crawl_result:
- "won":
    {t("督军倒下了。叉的位置上有一只箱子,加上路上捡的,一共 {gold} 枚金币。", "The warlord falls. Under the cross is a chest; with what they picked up on the way, {gold} gold.")}
- "left":
    {t("走到第 {depth} 间,他们回头了。带回 {gold} 枚金币,地图还留着。", "At room {depth} they turn back, with {gold} gold and the map still in hand.")}
- else:
    {t("火把灭了,地图掉在地上。", "The torches go out; the map falls to the floor.")}
}
-> END
