# VIP main game


# randomly pick vip
execute if score team_count global matches ..2 run function vip:pick/2
execute if score team_count global matches 3 run function vip:pick/3
execute if score team_count global matches 4 run function vip:pick/4

# title
title @a[tag=!vip] title {"text":"DEFEND YOUR VIP","color":"green","bold":true}
title @a[team=red,tag=!vip] subtitle ["",{"text":"Defend "},{"selector":"@a[team=red,tag=vip]"},{"text":" for your team."}]
title @a[team=blue,tag=!vip] subtitle ["",{"text":"Defend "},{"selector":"@a[team=blue,tag=vip]"},{"text":" for your team."}]
title @a[team=green,tag=!vip] subtitle ["",{"text":"Defend "},{"selector":"@a[team=green,tag=vip]"},{"text":" for your team."}]
title @a[team=yellow,tag=!vip] subtitle ["",{"text":"Defend "},{"selector":"@a[team=yellow,tag=vip]"},{"text":" for your team."}]
# vip-dependent
title @a[tag=vip] title {"text":"YOU ARE THE VIP","color":"green","bold":true}
title @a[tag=vip] subtitle ["",{"text":"If you die, your team dies."}]

# playsound
execute as @a at @s run playsound entity.player.levelup player @s ~ ~ ~
execute as @a at @s run playsound block.note_block.pling player @s ~ ~ ~

# gamerules
gamerule fallDamage true

effect give @a[tag=vip] health_boost 9999 4 true
effect give @a regeneration 1 255 true


scoreboard players set period internal 1