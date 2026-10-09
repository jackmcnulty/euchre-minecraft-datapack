# #active = number of tables with someone seated. The tick function does no
# per-table work while this is 0.
scoreboard players set #active euchre.g 0
execute as @e[type=minecraft:marker,tag=euchre.table,scores={euchre.seated=1..}] run scoreboard players add #active euchre.g 1
