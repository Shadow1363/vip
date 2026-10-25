# VIP death tracking


tellraw @s ["",{"text":"[","color":"dark_gray"},{"text":"☠","color":"red"},{"text":"] ","color":"dark_gray"},{"text":"You died, your team is eliminated!","color":"red"}]

# based on team
execute if entity @s[team=red] run scoreboard players set red internal 0
execute if entity @s[team=red] run title @a title {"text":"ELIMINATION","color":"green","bold":true}
execute if entity @s[team=red] run title @a subtitle {"text":"Red has been eliminated."}

execute if entity @s[team=blue] run scoreboard players set blue internal 0
execute if entity @s[team=blue] run title @a title {"text":"ELIMINATION","color":"green","bold":true}
execute if entity @s[team=blue] run title @a subtitle {"text":"Blue has been eliminated."}

execute if entity @s[team=green] run scoreboard players set green internal 0
execute if entity @s[team=green] run title @a title {"text":"ELIMINATION","color":"green","bold":true}
execute if entity @s[team=green] run title @a subtitle {"text":"Green has been eliminated."}

execute if entity @s[team=yellow] run scoreboard players set yellow internal 0
execute if entity @s[team=yellow] run title @a title {"text":"ELIMINATION","color":"green","bold":true}
execute if entity @s[team=yellow] run title @a subtitle {"text":"Yellow has been eliminated."}


scoreboard players reset @s death