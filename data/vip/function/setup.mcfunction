# VIP setup


# tellraw
tellraw @a [{text:" "},{text:"\nVIP Setup\n\n",color:"green",bold:true},{text:"Before the game begins, choose your team count and add people to all teams available.\n"},{text:"\n! GREEN only available for 3+ teams\n! YELLOW only available for 4+ teams\n\n",color:"gold",bold:true},{text:"Team count: "},{text:"2",color:"green",bold:true,hover_event:{action:"show_text",value:"Red, Blue (default)"},click_event:{action:"run_command",command:"/scoreboard players set team_count global 2"}},{text:" / "},{text:"3",color:"green",bold:true,hover_event:{action:"show_text",value:"Red, Blue, Green"},click_event:{action:"run_command",command:"/scoreboard players set team_count global 3"}},{text:" / "},{text:"4",color:"green",bold:true,hover_event:{action:"show_text",value:"Red, Blue, Green, Yellow"},click_event:{action:"run_command",command:"/scoreboard players set team_count global 4"}},{text:"\nAdd people to teams with "},{text:"/team join ",color:"gray"},{text:"[red/blue/green/yellow]",color:"dark_green"},{text:" [name]\n",color:"green"},{text:"\nOnce you're ready run /function vip:start\nAfter a game, run /function vip:reset to return to the lobby\n"}]


scoreboard players set setup internal 1
