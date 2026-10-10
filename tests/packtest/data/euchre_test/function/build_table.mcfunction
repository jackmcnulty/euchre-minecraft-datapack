# Fixture: a 1x1 table with a cushion on each side, built around the test origin.
#   floor (y-1): 3x3 smooth stone; table block at the origin; cushions N/E/S/W.
# Usage (callers hold euchre_test:lock):
#   function euchre_test:build_table
#   await score #fixture_ready euchre.tmp matches 1
# then run setup positioned on the tabletop: ~0.5 ~1 ~0.5.
#
# The fixture can straddle a chunk border. Force-load the neighbourhood (the test
# removes it again); the chunks load a few ticks later, and summoning into a
# chunk that isn't loaded yet silently does nothing. So fixture_poll retries
# every tick, from a marker at the origin (which is in the test's own, loaded
# chunk), until all four cushions really exist.
forceload add ~-2 ~-2 ~2 ~2
scoreboard players set #fixture_ready euchre.tmp 0
kill @e[type=minecraft:marker,tag=euchre_test.origin]
summon minecraft:marker ~ ~ ~ {Tags:["euchre_test.origin"]}
function euchre_test:fixture_poll
