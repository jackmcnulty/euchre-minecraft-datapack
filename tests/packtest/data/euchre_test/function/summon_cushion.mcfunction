# Summon a cushion here as if it had been placed.
# A cushion is block-attached (like a painting): it records the block it occupies
# in block_pos and pops off at its next support check (every 100 ticks) if that
# is invalid. /summon loads the entity data while the entity is still at the
# world origin and only then moves it, so a block_pos millions of blocks away
# (GameTest runs tests far out) is rejected as "invalid position". Giving Pos in
# the data as well keeps the two together. Commands can't print absolute
# coordinates, so read them off a probe marker.
summon minecraft:marker ~ ~ ~ {Tags:["euchre_test.probe"]}
data modify storage euchre_test:t c.pos set from entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos
execute store result storage euchre_test:t c.x int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[0]
execute store result storage euchre_test:t c.y int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[1]
execute store result storage euchre_test:t c.z int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[2]
kill @e[type=minecraft:marker,tag=euchre_test.probe]
function euchre_test:summon_cushion_at with storage euchre_test:t c
