# VIP eliminate @s's team


$execute if entity @s[team=$(t)] run scoreboard players set $(t) internal 0
$execute if entity @s[team=$(t)] run title @a title {text:"ELIMINATION",color:"green",bold:true}
$execute if entity @s[team=$(t)] run title @a subtitle {text:"$(T) has been eliminated."}
