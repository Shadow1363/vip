# VIP win for the remaining team


$execute if score $(t) internal matches 1 run tag @a[team=$(t)] add winner
$execute if score $(t) internal matches 1 run function vip:win {T:"$(T)"}
