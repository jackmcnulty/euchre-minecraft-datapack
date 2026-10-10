# Remove the nearest Euchre table (within 8 blocks of you). Players are stood
# up, our helper entities are deleted, and the builder's cushions are released
# untouched. Any stakes in escrow are refunded first.
execute unless entity @e[type=minecraft:marker,tag=euchre.table,distance=..8] run return run function euchre:util/fail {msg:"No Euchre table within 8 blocks."}
execute as @e[type=minecraft:marker,tag=euchre.table,distance=..8,sort=nearest,limit=1] at @s run function euchre:table/remove
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Table removed.",color:"green"}]
return 1
