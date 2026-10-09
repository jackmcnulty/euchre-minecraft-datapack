# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Two steps, because force-loaded chunks only load on the next tick (summoning
# into a chunk that isn't loaded yet silently does nothing):
#   function euchre_test:build_table
#   await delay 1
#   function euchre_test:place_cushions   (then check #cushions euchre.tmp is 4)
# Callers run setup positioned on the tabletop: ~0.5 ~1 ~0.5.
#
# The fixture can straddle a chunk border; GameTest only guarantees the test's own
# chunk ticks entities, and a cushion in a non-ticking chunk never lets its rider
# stand up. Force-load the neighbourhood (the test removes it again).
forceload add ~-2 ~-2 ~2 ~2
fill ~-1 ~-1 ~-1 ~1 ~-1 ~1 minecraft:smooth_stone
setblock ~ ~ ~ minecraft:oak_planks
