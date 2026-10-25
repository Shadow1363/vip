# VIP eliminated team -> spectator


$execute as @a[team=$(t),gamemode=!spectator] unless score $(t) internal matches 1.. run gamemode spectator @s
