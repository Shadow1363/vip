# VIP main loop


# setup
execute as @a unless score setup internal matches 1.. run function vip:setup

# dead
execute if score period internal matches 1 run function vip:team/each {fn:"spectate"}

# track deaths
execute unless score period internal matches 1 run scoreboard players reset @a death
execute if score period internal matches 1 as @a[tag=!vip] at @s if score @s death matches 1.. run function vip:death/all
execute if score period internal matches 1 as @a[tag=vip] at @s if score @s death matches 1.. run function vip:death/vip

# win condition
execute if score period internal matches 1 run function vip:win_check

# kills
execute as @a if score @s kill matches 1.. if score kill_health global matches 1.. run function vip:kills
execute as @a if score @s kill matches 1.. run scoreboard players reset @s kill

# timer
execute if score period internal matches 0..2 run function vip:time
function vip:bossbar

# extras
execute if score cut_clean global matches 1.. run function vip:extras/cut_clean
execute if score speed_uhc global matches 1.. run function vip:extras/speed_uhc
execute if score speed_uhc global matches 1.. if score patch_grindstone_exploit global matches 1.. run function vip:extras/grindstone

# VIP
execute if score period internal matches 1 run effect give @a[tag=vip] glowing 1 255 true
execute if score period internal matches 1 run effect give @a[tag=vip] slowness 1 0 true
execute if score period internal matches 1 run title @a[tag=vip] actionbar ["",{text:"You are your team's "},{text:"VIP",color:"green",bold:true},{text:" - if you die, your team dies."}]
# non-VIP
execute if score period internal matches 1 run function vip:team/each {fn:"actionbar"}

# period checks
function vip:last_login
