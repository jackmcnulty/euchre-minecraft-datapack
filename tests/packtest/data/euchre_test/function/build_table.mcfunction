# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Callers run setup positioned on the tabletop: ~0.5 ~1 ~0.5.
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
summon minecraft:cushion ~0.5 ~ ~-0.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~1.5 ~ ~0.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~0.5 ~ ~1.5 {Tags:["euchre_test.cushion"]}
summon minecraft:cushion ~-0.5 ~ ~0.5 {Tags:["euchre_test.cushion"]}
