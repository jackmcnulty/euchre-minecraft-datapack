# Summon a cushion here, the way placing one would: a cushion is a block-attached
# entity and needs block_pos at creation (without it the game logs "Block-attached
# entity at invalid position" and removes it at its next support check). Commands
# can't print absolute coordinates directly, so read them off a probe marker.
summon minecraft:marker ~ ~ ~ {Tags:["euchre_test.probe"]}
execute store result storage euchre_test:t c.x int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[0]
execute store result storage euchre_test:t c.y int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[1]
# Like an item frame, a cushion records the block it is attached to: the one below.
execute store result score #y euchre.tmp run data get storage euchre_test:t c.y
scoreboard players remove #y euchre.tmp 1
execute store result storage euchre_test:t c.yb int 1 run scoreboard players get #y euchre.tmp
execute store result storage euchre_test:t c.z int 1 run data get entity @e[type=minecraft:marker,tag=euchre_test.probe,limit=1] Pos[2]
kill @e[type=minecraft:marker,tag=euchre_test.probe]
function euchre_test:summon_cushion_at with storage euchre_test:t c
