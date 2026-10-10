# @timeout 1200
# A seated player whose departure the table never noticed (the server stopped
# first, e.g. quitting single player) comes back: vanilla seats them on their
# cushion again and on_rejoin clears their stale tags. They must be re-seated
# WITHOUT being counted twice.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 1
execute positioned ~0.5 ~1 ~0.5 run dummy sr spawn
dummy sr use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
await entity @a[name=sr,tag=euchre.seated]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.seated=1}]

# Simulate the rejoin in one tick, as on_rejoin does: stale state cleared, then
# the player (still on their cushion) is checked again.
execute as sr run function euchre:player/clear_seat
execute as sr at sr run function euchre:seat/check_sit
assert entity @a[name=sr,tag=euchre.seated]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.seated=1}]

execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy sr leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
