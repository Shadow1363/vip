# Cut Clean: smelt dropped items
## macro: from = raw item id, to = smelted item id, n = count


$execute as @e[type=item] if items entity @s contents minecraft:$(from) at @s run function vip:extras/smelt_one {to:"$(to)",n:$(n)}
