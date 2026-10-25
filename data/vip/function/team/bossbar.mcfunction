# VIP team bossbar: VIP name + health, shown to the team while it is alive


$bossbar set vip:$(t) name {selector:"@a[team=$(t),tag=vip]",color:"$(t)",bold:true}
$execute store result bossbar vip:$(t) value run scoreboard players get @a[team=$(t),tag=vip,limit=1] health
$execute if score $(t) internal matches 1 run bossbar set vip:$(t) players @a[team=$(t)]
$execute unless score $(t) internal matches 1 run bossbar set vip:$(t) players
