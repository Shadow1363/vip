# VIP win
## macro: T = winning team's display name


scoreboard players set period internal 3
gamemode spectator @a[tag=!winner]

# title
title @a title {text:"GAME OVER!",color:"green",bold:true}
$execute unless score finale internal matches 1.. run title @a subtitle {text:"$(T) has won!"}
# FINALE
$execute if score finale internal matches 1.. run title @a subtitle {text:"$(T) has won the FINALE!"}

# playsound
execute as @a at @s run playsound ui.toast.challenge_complete player @s ~ ~ ~

# fireworks
effect give @a resistance infinite 255 true
execute as @a[tag=winner] at @s run summon firework_rocket ~ ~1 ~ {FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{flight_duration:1b,explosions:[{shape:"large_ball",colors:[I;3471405],fade_colors:[I;617238]}]}}}}

# reset
scoreboard players reset red internal
scoreboard players reset blue internal
scoreboard players reset green internal
scoreboard players reset yellow internal
