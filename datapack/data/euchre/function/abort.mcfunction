# Operator: cancel the game at the nearest table (within 8 blocks) and refund every stake.
execute unless entity @e[type=minecraft:marker,tag=euchre.table,distance=..8] run return run function euchre:util/fail {msg:"No Euchre table within 8 blocks."}
data modify storage euchre:tmp reason set value "An operator cancelled the game. Any stakes were refunded."
execute as @e[type=minecraft:marker,tag=euchre.table,distance=..8,sort=nearest,limit=1] at @s run function euchre:game/abort
return 1
