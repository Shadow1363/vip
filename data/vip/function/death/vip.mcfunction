# VIP death tracking


tellraw @s ["",{text:"[",color:"dark_gray"},{text:"☠",color:"red"},{text:"] ",color:"dark_gray"},{text:"You died, your team is eliminated!",color:"red"}]

# based on team
function vip:team/each {fn:"eliminate"}


scoreboard players reset @s death
