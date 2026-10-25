# VIP setup


# tellraw
tellraw @a [{"text":" "},{"text":"\nVIP Setup\n\n","color":"green","bold":true},{"text":"Before the game begins, choose your team count and add people to all teams available.\n"},{"text":"\n! GREEN only available for 3+ teams\n! YELLOW only available for 4+ teams\n\n","color":"gold","bold":true},{"text":"Team count: "},{"text":"2","color":"green","bold":true,"hoverEvent":{"action":"show_text","contents":[{"text":"Red, Blue (default)"}]},"clickEvent":{"action":"run_command","value":"/scoreboard players set team_count global 2"}},{"text":" / "},{"text":"3","color":"green","bold":true,"hoverEvent":{"action":"show_text","contents":[{"text":"Red, Blue, Green"}]},"clickEvent":{"action":"run_command","value":"/scoreboard players set team_count global 3"}},{"text":" / "},{"text":"4","color":"green","bold":true,"hoverEvent":{"action":"show_text","contents":[{"text":"Red, Blue, Green, Yellow"}]},"clickEvent":{"action":"run_command","value":"/scoreboard players set team_count global 4"}},{"text":"\nAdd people to teams with "},{"text":"/team join ","color":"gray"},{"text":"[red/blue/green/yellow]","color":"dark_green"},{"text":" [name]\n","color":"green"},{"text":"\nOnce you're ready run /function vip:start\n"}]


scoreboard players set setup internal 1