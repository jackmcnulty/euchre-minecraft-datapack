# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Callers run setup positioned on the tabletop: ~0.5 ~1 ~0.5, and check that
# #cushions euchre.tmp is 4.
#
# The fixture can straddle a chunk border; GameTest only guarantees the test's own
# chunk ticks entities, and a cushion in a non-ticking chunk never lets its rider
# stand up. Force-load the neighbourhood (the test removes it again).
forceload add ~-2 ~-2 ~2 ~2
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
execute positioned ~0.5 ~ ~-0.5 run function euchre_test:summon_cushion
execute positioned ~1.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~1.5 run function euchre_test:summon_cushion
execute positioned ~-0.5 ~ ~0.5 run function euchre_test:summon_cushion
execute positioned ~0.5 ~ ~0.5 store result score #cushions euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre_test.cushion,distance=..2]
