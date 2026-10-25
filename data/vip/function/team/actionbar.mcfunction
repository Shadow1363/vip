# VIP non-VIP actionbar


$execute as @a[team=$(t),tag=!vip] unless score @s death_time matches 1.. run title @s actionbar ["",{text:"Defend "},{selector:"@a[team=$(t),tag=vip]"},{text:" ("},{score:{name:"@a[team=$(t),tag=vip,limit=1]",objective:"health"},color:"green",bold:true},{text:"♥",color:"dark_green"},{text:") to keep your team alive."}]
