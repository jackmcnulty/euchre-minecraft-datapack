# Second step of the table fixture (see build_table).
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
execute positioned ~0.5 ~ ~-0.5 run function euchre_test:summon_cushion
execute positioned ~1.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~1.5 run function euchre_test:summon_cushion
execute positioned ~-0.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~0.5 store result score #cushions euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre_test.cushion,distance=..2]
