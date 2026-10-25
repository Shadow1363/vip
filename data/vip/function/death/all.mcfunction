# VIP death tracking


tellraw @s ["",{text:"[",color:"dark_gray"},{text:"☠",color:"green"},{text:"] ",color:"dark_gray"},{text:"You died, but will respawn in ",color:"green"},{score:{name:"death_time",objective:"global"},color:"green"},{text:" seconds.",color:"green"}]

gamemode spectator @s

# based on team
function vip:team/each {fn:"tp_vip"}

execute if score respawn_loot global matches 1.. run give @s stone_axe[enchantments={"minecraft:vanishing_curse":1}]
execute if score respawn_loot global matches 1.. run give @s stone_pickaxe[enchantments={"minecraft:vanishing_curse":1}]
execute if score respawn_loot global matches 1.. run give @s leather_boots[enchantments={"minecraft:vanishing_curse":1}]

scoreboard players set @s death_time 1
scoreboard players reset @s death
