# VIP non-VIP subtitle on selection


$title @a[team=$(t),tag=!vip] subtitle ["",{text:"Defend "},{selector:"@a[team=$(t),tag=vip]"},{text:" for your team."}]
