# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Callers run setup positioned on the tabletop: ~0.5 ~1 ~0.5.
# The fixture can straddle a chunk border; GameTest only guarantees the test's own
# chunk ticks entities, and a cushion in a non-ticking chunk never lets its rider
# stand up. Force-load the neighbourhood (the test removes it again).
forceload add ~-2 ~-2 ~2 ~2
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
summon minecraft:cushion ~0.5 ~ ~-0.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~1.5 ~ ~0.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~0.5 ~ ~1.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~-0.5 ~ ~0.5 {Tags:["euchre_test.cushion"]}
# A summoned cushion has no block_pos (a placed one does), and cushions break
# if the block at block_pos has nothing under it, checked every 100 ticks. Point
# each one at the block it actually occupies. (`data get` floors coordinates.)
execute as @e[type=minecraft:cushion,tag=euchre_test.cushion,distance=..3] run function euchre_test:fix_block_pos
