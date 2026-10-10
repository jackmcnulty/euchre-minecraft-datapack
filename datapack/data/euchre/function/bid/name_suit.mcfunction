# As the bidder in round 2: #named becomes trump.
function euchre:bid/announce_name
data modify storage euchre:tmp f set value {}
execute store result storage euchre:tmp f.led int 1 run scoreboard players get #named euchre.tmp
function euchre:bid/suit_symbol with storage euchre:tmp f
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" names ",color:"green"},{storage:"euchre:tmp",nbt:"f.sym",color:"white"},{text:" trump.",color:"green"}]
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:bid/after_name
return 1
