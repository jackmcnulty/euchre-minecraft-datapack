# As the bidder in round 1: the up card's suit becomes trump and the dealer
# picks the up card up, then discards.
function euchre:bid/announce_name
data modify storage euchre:tmp f set value {}
execute store result storage euchre:tmp f.led int 1 run scoreboard players get #up_suit euchre.tmp
function euchre:bid/suit_symbol with storage euchre:tmp f
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" orders up ",color:"green"},{storage:"euchre:tmp",nbt:"f.sym",color:"white"},{text:".",color:"green"}]
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:bid/after_order_up
return 1
