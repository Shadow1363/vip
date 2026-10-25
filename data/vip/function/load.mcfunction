# VIP prepare
# runs on every /reload


# scoreboards
scoreboard objectives add global dummy
scoreboard objectives add internal dummy
scoreboard objectives add last_login dummy
scoreboard objectives add kill playerKillCount

# numbers
scoreboard players set 900 internal 900

# bossbar
bossbar add vip:main ""

# death
scoreboard objectives add death deathCount
# death times
scoreboard objectives add death_time dummy
scoreboard objectives add death_time_t dummy

# bossbars
bossbar add vip:red ""
bossbar set vip:red color red
bossbar set vip:red max 40

bossbar add vip:blue ""
bossbar set vip:blue color blue
bossbar set vip:blue max 40

bossbar add vip:green ""
bossbar set vip:green color green
bossbar set vip:green max 40

bossbar add vip:yellow ""
bossbar set vip:yellow color yellow
bossbar set vip:yellow max 40

# teams
team add red
team add blue
team add green
team add yellow
## admin bypass
team add admin

# display vip health
scoreboard objectives add health health

# defaults
execute unless score defaults internal matches 1.. run function vip:defaults