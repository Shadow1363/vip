# VIP reset
## returns everyone to the lobby so another game can be started


# state
scoreboard players set period internal -1
scoreboard players set time internal 0
scoreboard players set time_s internal 0
scoreboard players reset time_left internal
scoreboard players reset red internal
scoreboard players reset blue internal
scoreboard players reset green internal
scoreboard players reset yellow internal

# players (* includes offline players; tags are cleared for rejoiners in last_login)
tag @a remove vip
tag @a remove winner
scoreboard players reset * death_time
scoreboard players reset * death_time_t
scoreboard players reset * death
scoreboard players reset * kill
scoreboard players reset * last_login
effect clear @a

# world
worldborder set 10
gamerule minecraft:fall_damage false
