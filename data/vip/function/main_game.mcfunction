# VIP main game


# randomly pick vip
function vip:team/each {fn:"pick"}

# title
title @a[tag=!vip] title {text:"DEFEND YOUR VIP",color:"green",bold:true}
function vip:team/each {fn:"subtitle"}
# vip-dependent
title @a[tag=vip] title {text:"YOU ARE THE VIP",color:"green",bold:true}
title @a[tag=vip] subtitle {text:"If you die, your team dies."}

# playsound
execute as @a at @s run playsound entity.player.levelup player @s ~ ~ ~
execute as @a at @s run playsound block.note_block.pling player @s ~ ~ ~

# gamerules
gamerule minecraft:fall_damage true

effect give @a[tag=vip] health_boost infinite 4 true
effect give @a regeneration 1 255 true


scoreboard players set period internal 1
