# VIP timer


scoreboard players add time internal 1

execute if score time internal matches 20.. run scoreboard players add time_s internal 1
execute if score time internal matches 20.. run scoreboard players set time internal 0

# death times
execute as @a if score @s death_time matches 1.. run scoreboard players add @s death_time_t 1
# convert to s
execute as @a if score @s death_time matches 1.. if score @s death_time_t matches 20.. run scoreboard players add @s death_time 1
execute as @a if score @s death_time matches 1.. if score @s death_time_t matches 20.. run scoreboard players set @s death_time_t 0
# respawn after set time
execute as @a if score @s death_time >= death_time global run function vip:death/respawn
execute as @a if score @s death_time >= death_time global run scoreboard players reset @s death_time

# period
execute if score time_s internal matches 800 if score period internal matches 0 run worldborder set 20 2800
execute if score time_s internal matches 900 if score period internal matches 0 run function vip:main_game

execute if score time_s internal matches 1600 if score period internal matches 1 run worldborder set 125 1400

execute if score time_s internal matches 2800 if score period internal matches 1 run worldborder set 80 220

# time left
## grace period (0)
execute if score period internal matches 0 run scoreboard players operation time_left internal = 900 internal
execute if score period internal matches 0 run scoreboard players operation time_left internal -= time_s internal

# bossbar
## pre-game (-1)
execute if score period internal matches -1 run bossbar set vip:main name {"text":"The game will begin shortly!"}
execute if score period internal matches -1 run bossbar set vip:main color white
## grace period (0)
execute if score period internal matches 0 run bossbar set vip:main name ["",{"text":"Grace period \u0020 \u0020","color":"gold"},{"score":{"name":"time_left","objective":"internal"},"color":"gold","bold":true},{"text":" seconds left","color":"white"}]
execute if score period internal matches 0 run bossbar set vip:main max 900
execute if score period internal matches 0 run bossbar set vip:main color yellow
## main period (2)
execute if score period internal matches 1 run bossbar set vip:main name ["",{"text":"PROTECT THE VIP","color":"green","bold":true}]
execute if score period internal matches 1 run bossbar set vip:main max 1
## show for teams
execute if score period internal matches 1 run function vip:teams/bossbar

# actionbar for dead-spectating
execute as @a if score @s death_time matches 1.. run title @s actionbar ["",{"text":"You are dead, "},{"score":{"name":"@s","objective":"death_time"},"color":"green","bold":true},{"text":"/","color":"dark_green","bold":true},{"score":{"name":"death_time","objective":"global"},"color":"dark_green","bold":true},{"text":" seconds!"}]

# store value in bossbar
execute store result bossbar vip:main value run scoreboard players get time_s internal