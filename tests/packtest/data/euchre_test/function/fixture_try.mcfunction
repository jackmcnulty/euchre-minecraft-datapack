# At the fixture origin: build the floor, table and cushions. Succeeds only when
# the area is loaded and all four cushions exist.
execute unless loaded ~-2 ~ ~-2 run return fail
execute unless loaded ~2 ~ ~-2 run return fail
execute unless loaded ~-2 ~ ~2 run return fail
execute unless loaded ~2 ~ ~2 run return fail
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
kill @e[type=minecraft:cushion,tag=euchre_test.cushion,distance=..3]
execute positioned ~0.5 ~ ~-0.5 run function euchre_test:summon_cushion
execute positioned ~1.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~1.5 run function euchre_test:summon_cushion
execute positioned ~-0.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~0.5 store result score #cushions euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre_test.cushion,distance=..2]
execute unless score #cushions euchre.tmp matches 4 run return fail
return 1
