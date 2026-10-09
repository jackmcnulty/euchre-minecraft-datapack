# As a player riding a free seat (#tid/#seat and euchre:tmp q are set): take it.
function euchre:player/identify
scoreboard players operation @s euchre.tid = #tid euchre.tmp
scoreboard players operation @s euchre.seat = #seat euchre.tmp
tag @s add euchre.seated
execute store result storage euchre:tmp q.pid int 1 run scoreboard players get @s euchre.pid
data modify storage euchre:tmp q.name set from storage euchre:tmp name
function euchre:seat/claim with storage euchre:tmp q
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:seat/after_sit
