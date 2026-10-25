# Cut Clean: swap @s item entity for its smelted version


$item replace entity @s contents with minecraft:$(to) $(n)
data merge entity @s {PickupDelay:12s,Motion:[0.0d,0.05d,0.0d]}
particle minecraft:smoke ~ ~ ~ 0 0 0 0.01 30
