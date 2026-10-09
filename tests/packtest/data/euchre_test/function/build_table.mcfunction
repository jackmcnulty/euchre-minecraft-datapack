# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Callers run setup positioned on the tabletop: ~0.5 ~1 ~0.5.
# Only callers holding euchre_test:lock may use it (the builder name is shared).
#
# The fixture can straddle a chunk border; GameTest only guarantees the test's own
# chunk ticks entities, and a cushion in a non-ticking chunk never lets its rider
# stand up. Force-load the neighbourhood (the test removes it again).
forceload add ~-2 ~-2 ~2 ~2
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks

# Cushions are placed the way a builder would: right-clicking the floor with a
# cushion. (Summoned cushions lack a valid attachment and pop off at their first
# support check, 100 ticks later.)
execute positioned ~0.5 ~1 ~0.5 run dummy builder spawn
item replace entity builder weapon.mainhand with minecraft:white_cushion 4
dummy builder use block ~ ~-1 ~-1 up
dummy builder use block ~1 ~-1 ~ up
dummy builder use block ~ ~-1 ~1 up
dummy builder use block ~-1 ~-1 ~ up
dummy builder leave
execute positioned ~0.5 ~ ~0.5 run tag @e[type=minecraft:cushion,distance=..2] add euchre_test.cushion
