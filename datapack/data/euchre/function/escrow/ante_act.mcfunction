# As/at a seated player during the ante (#act: 30 confirm, 31 leave).
execute if score #act euchre.tmp matches 31 run return run function euchre:escrow/ante_leave
execute unless score #act euchre.tmp matches 30 run return run function euchre:util/fail {msg:"Confirm your stake or leave the table."}
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
function euchre:escrow/ante_mark with storage euchre:tmp q
function euchre:bid/announce_name
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" confirmed their stake.",color:"gray"}]
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:escrow/ante_check
return 1
