# VIP win check
## the last team still alive (1) wins; teams not playing are unset and ignored


scoreboard players set alive internal 0
function vip:team/each {fn:"count_alive"}

execute if score alive internal matches 1 run function vip:team/each {fn:"win_if_alive"}
