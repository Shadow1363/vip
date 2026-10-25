# VIP start


scoreboard players set start_confirmed internal 0

# team checks
execute if score team_count global matches ..2 if entity @a[team=red] if entity @a[team=blue] run scoreboard players set start_confirmed internal 1
execute if score team_count global matches 3 if entity @a[team=red] if entity @a[team=blue] if entity @a[team=green] run scoreboard players set start_confirmed internal 1
execute if score team_count global matches 4 if entity @a[team=red] if entity @a[team=blue] if entity @a[team=green] if entity @a[team=yellow] run scoreboard players set start_confirmed internal 1

execute unless score start_confirmed internal matches 1.. run tellraw @s ["",{"text":"[","color":"dark_gray"},{"text":"X","color":"red","bold":true},{"text":"] ","color":"dark_gray"},{"text":"Cannot start, check everyone is on a team (R+B for 2, R+B+G for 3, R+B+G+Y for 4).\n    If you are on an admin team, your gamemode will not be updated upon starting!","color":"green"}]

# if confirmed
execute if score start_confirmed internal matches 1.. run function vip:start_c