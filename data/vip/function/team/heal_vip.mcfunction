# VIP heal @s's VIP on a kill


$execute if entity @s[team=$(t)] run effect give @a[team=$(t),tag=vip] instant_health 1 0 true
$execute if entity @s[team=$(t)] run tellraw @a[team=$(t),tag=vip] ["",{text:"[",color:"dark_gray"},{text:"+2",color:"green",bold:true},{text:"♥",color:"dark_green"},{text:"] ",color:"dark_gray"},{text:"An enemy team member has been killed!",color:"green"}]
$execute if entity @s[team=$(t)] at @a[team=$(t),tag=vip] run playsound entity.arrow.hit_player player @a[team=$(t),tag=vip]
$execute if entity @s[team=$(t)] at @a[team=$(t),tag=vip] run playsound block.beacon.activate player @a[team=$(t),tag=vip]
