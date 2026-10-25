# VIP bossbars
## runs every tick


bossbar set vip:main players @a

## pre-game (-1)
execute if score period internal matches -1 run bossbar set vip:main name {text:"The game will begin shortly!",color:"white"}
execute if score period internal matches -1 run bossbar set vip:main color white
execute if score period internal matches -1 run bossbar set vip:main max 1
execute if score period internal matches -1 run bossbar set vip:main value 1
## grace period (0)
execute if score period internal matches 0 run bossbar set vip:main name ["",{text:"Grace period    ",color:"gold"},{score:{name:"time_left",objective:"internal"},color:"gold",bold:true},{text:" seconds left",color:"white"}]
execute if score period internal matches 0 run bossbar set vip:main max 900
execute if score period internal matches 0 run bossbar set vip:main color yellow
## main period (1)
execute if score period internal matches 1 run bossbar set vip:main name {text:"PROTECT THE VIP",color:"green",bold:true}
execute if score period internal matches 1 run bossbar set vip:main max 1

# store value in bossbar
execute if score period internal matches 0..2 store result bossbar vip:main value run scoreboard players get time_s internal

# team bossbars, shown to each playing team during the main game
execute if score period internal matches 1 run function vip:team/each {fn:"bossbar"}
execute unless score period internal matches 1 run bossbar set vip:red players
execute unless score period internal matches 1 run bossbar set vip:blue players
execute unless score period internal matches 1 run bossbar set vip:green players
execute unless score period internal matches 1 run bossbar set vip:yellow players
