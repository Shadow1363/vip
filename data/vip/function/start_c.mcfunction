# VIP start
## if eligible


# title
title @a title {text:"STARTED",color:"green",bold:true}
title @a subtitle {text:"You have 15 minutes to prepare with loot before your team's VIP is chosen."}

# playsound
execute as @a at @s run playsound entity.generic.explode player @s ~ ~ ~
execute as @a at @s run playsound block.note_block.pling player @s ~ ~ ~

# count players
## only teams within team_count play; the rest stay unset
scoreboard players reset red internal
scoreboard players reset blue internal
scoreboard players reset green internal
scoreboard players reset yellow internal
execute if entity @a[team=red] run scoreboard players set red internal 1
execute if entity @a[team=blue] run scoreboard players set blue internal 1
execute if score team_count global matches 3.. if entity @a[team=green] run scoreboard players set green internal 1
execute if score team_count global matches 4.. if entity @a[team=yellow] run scoreboard players set yellow internal 1

execute if score finale internal matches 1.. run worldborder set 2400 3
execute unless score finale internal matches 1.. run worldborder set 1600 3

# set period
scoreboard players set period internal 0
