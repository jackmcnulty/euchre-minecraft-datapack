# As the bidder: pass to the next player, or end the round after 4 passes.
function euchre:bid/announce_name
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" passes.",color:"gray"}]
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:bid/after_pass
return 1
