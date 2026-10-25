# VIP teleport @s to their team's VIP


$execute if entity @s[team=$(t)] run tp @s @a[team=$(t),tag=vip,limit=1]
