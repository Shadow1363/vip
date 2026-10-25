# VIP death-time respawn


# once the user has been dead for 25s+

# effect
effect give @s resistance 3 255 true

# based on team
execute if entity @s[team=red] run tp @s @a[team=red,tag=vip,limit=1]
execute if entity @s[team=blue] run tp @s @a[team=blue,tag=vip,limit=1]
execute if entity @s[team=green] run tp @s @a[team=green,tag=vip,limit=1]
execute if entity @s[team=yellow] run tp @s @a[team=yellow,tag=vip,limit=1]

# tell them
tellraw @s ["",{"text":"[","color":"dark_gray"},{"text":"+","color":"green"},{"text":"] ","color":"dark_gray"},{"text":"You respawned, defend your VIP!","color":"green"}]

gamemode survival @s