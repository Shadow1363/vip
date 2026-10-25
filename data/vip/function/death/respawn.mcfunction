# VIP death-time respawn


# once the user has been dead for 25s+

# effect
effect give @s resistance 3 255 true

# based on team
function vip:team/each {fn:"tp_vip"}

# tell them
tellraw @s ["",{text:"[",color:"dark_gray"},{text:"+",color:"green"},{text:"] ",color:"dark_gray"},{text:"You respawned, defend your VIP!",color:"green"}]

gamemode survival @s
