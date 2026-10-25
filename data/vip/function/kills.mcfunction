# VIP kills


# based on team
execute if entity @s[team=red] run effect give @a[team=red,tag=vip] instant_health 1 0 true
execute if entity @s[team=red] run tellraw @a[team=red,tag=vip] ["",{"text":"[","color":"dark_gray"},{"text":"+2","color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":"] ","color":"dark_gray"},{"text":"An enemy team member has been killed!","color":"green"}]
execute if entity @s[team=red] at @a[team=red,tag=vip] run playsound entity.arrow.hit_player player @a[team=red,tag=vip]
execute if entity @s[team=red] at @a[team=red,tag=vip] run playsound block.beacon.activate player @a[team=red,tag=vip]

execute if entity @s[team=blue] run effect give @a[team=blue,tag=vip] instant_health 1 0 true
execute if entity @s[team=blue] run tellraw @a[team=blue,tag=vip] ["",{"text":"[","color":"dark_gray"},{"text":"+2","color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":"] ","color":"dark_gray"},{"text":"An enemy team member has been killed!","color":"green"}]
execute if entity @s[team=blue] at @a[team=blue,tag=vip] run playsound entity.arrow.hit_player player @a[team=blue,tag=vip]
execute if entity @s[team=blue] at @a[team=blue,tag=vip] run playsound block.beacon.activate player @a[team=blue,tag=vip]

execute if entity @s[team=green] run effect give @a[team=green,tag=vip] instant_health 1 0 true
execute if entity @s[team=green] run tellraw @a[team=green,tag=vip] ["",{"text":"[","color":"dark_gray"},{"text":"+2","color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":"] ","color":"dark_gray"},{"text":"An enemy team member has been killed!","color":"green"}]
execute if entity @s[team=green] at @a[team=green,tag=vip] run playsound entity.arrow.hit_player player @a[team=green,tag=vip]
execute if entity @s[team=green] at @a[team=green,tag=vip] run playsound block.beacon.activate player @a[team=green,tag=vip]

execute if entity @s[team=yellow] run effect give @a[team=yellow,tag=vip] instant_health 1 0 true
execute if entity @s[team=yellow] run tellraw @a[team=yellow,tag=vip] ["",{"text":"[","color":"dark_gray"},{"text":"+2","color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":"] ","color":"dark_gray"},{"text":"An enemy team member has been killed!","color":"green"}]
execute if entity @s[team=yellow] at @a[team=yellow,tag=vip] run playsound entity.arrow.hit_player player @a[team=yellow,tag=vip]
execute if entity @s[team=yellow] at @a[team=yellow,tag=vip] run playsound block.beacon.activate player @a[team=yellow,tag=vip]


scoreboard players reset @s kill