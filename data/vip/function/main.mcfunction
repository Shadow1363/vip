# VIP main loop


# setup
execute as @a unless score setup internal matches 1.. run function vip:setup

# dead
execute if score period internal matches 1 as @a[team=red,gamemode=!spectator] unless score red internal matches 1.. run gamemode spectator @s
execute if score period internal matches 1 as @a[team=blue,gamemode=!spectator] unless score blue internal matches 1.. run gamemode spectator @s
execute if score period internal matches 1 as @a[team=green,gamemode=!spectator] unless score green internal matches 1.. run gamemode spectator @s
execute if score period internal matches 1 as @a[team=yellow,gamemode=!spectator] unless score yellow internal matches 1.. run gamemode spectator @s

# track deaths
execute unless score period internal matches 1 run scoreboard players reset @a death
execute if score period internal matches 1 as @a[tag=!vip] at @s if score @s death matches 1.. run function vip:death/all
execute if score period internal matches 1 as @a[tag=vip] at @s if score @s death matches 1.. run function vip:death/vip

# team count
execute if score period internal matches 1 if score team_count global matches ..2 run function vip:teams/2
execute if score period internal matches 1 if score team_count global matches 3 run function vip:teams/3
execute if score period internal matches 1 if score team_count global matches 4 run function vip:teams/4

# kills
execute as @a if score @s kill matches 1.. if score kill_health global matches 1.. run function vip:kills
execute as @a if score @s kill matches 1.. run scoreboard players reset @s kill

# timer
execute if score period internal matches 0..2 run function vip:time
bossbar set vip:main players @a

# extras
execute if score cut_clean global matches 1.. run function vip:extras/cut_clean
execute if score speed_uhc global matches 1.. run function vip:extras/speed_uhc
execute if score speed_uhc global matches 1.. if score patch_grindstone_exploit global matches 1.. run function vip:extras/grindstone

# VIP
execute if score period internal matches 1 run effect give @a[tag=vip] glowing 1 255 true
execute if score period internal matches 1 run effect give @a[tag=vip] slowness 1 0 true
execute if score period internal matches 1 run title @a[tag=vip] actionbar ["",{"text":"You are your team's "},{"text":"VIP","color":"green","bold":true},{"text":" - if you die, your team dies."}]
# non-VIP
execute as @a[team=red,tag=!vip] unless score @s death_time matches 1.. if score period internal matches 1 run title @s actionbar ["",{"text":"Defend "},{"selector":"@a[team=red,tag=vip]"},{"text":" ("},{"score":{"name":"@a[team=red,tag=vip,limit=1]","objective":"health"},"color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":") to keep your team alive."}]
execute as @a[team=blue,tag=!vip] unless score @s death_time matches 1.. if score period internal matches 1 run title @s actionbar ["",{"text":"Defend "},{"selector":"@a[team=blue,tag=vip]"},{"text":" ("},{"score":{"name":"@a[team=blue,tag=vip,limit=1]","objective":"health"},"color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":") to keep your team alive."}]
execute as @a[team=green,tag=!vip] unless score @s death_time matches 1.. if score period internal matches 1 run title @s actionbar ["",{"text":"Defend "},{"selector":"@a[team=green,tag=vip]"},{"text":" ("},{"score":{"name":"@a[team=green,tag=vip,limit=1]","objective":"health"},"color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":") to keep your team alive."}]
execute as @a[team=yellow,tag=!vip] unless score @s death_time matches 1.. if score period internal matches 1 run title @s actionbar ["",{"text":"Defend "},{"selector":"@a[team=yellow,tag=vip]"},{"text":" ("},{"score":{"name":"@a[team=yellow,tag=vip,limit=1]","objective":"health"},"color":"green","bold":true},{"text":"♥","color":"dark_green"},{"text":") to keep your team alive."}]

# period checks
function vip:last_login