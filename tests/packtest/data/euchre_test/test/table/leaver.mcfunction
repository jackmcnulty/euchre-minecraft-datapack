# @timeout 1200
# A player who stands up mid-game pauses it and gets their seat (and cards) back
# when they sit down again. The second time they stay away past the grace
# period, so their team forfeits.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 1
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 3
execute positioned ~0.5 ~1 ~0.5 run dummy ln spawn
execute positioned ~0.5 ~1 ~0.5 run dummy le spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ls spawn
execute positioned ~0.5 ~1 ~0.5 run dummy lw spawn
dummy ln use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy le use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy ls use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy lw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]

# North stands up during bidding: the game pauses, the seat is held.
dummy ln sneak true
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=10,euchre.resume=3,euchre.seated=3}]
dummy ln sneak false
assert data storage euchre:tables list[0].seats[0].away
assert data storage euchre:tables list[0].seats[0].pid
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"ln",n:0}
execute if score #ok euchre.tmp matches 0 run fail "cards stay with the table while their holder is away"
# Bidding is frozen while paused.
execute store success score #ok euchre.tmp as le at le run function euchre:bid/act {value:1}
assert score #ok euchre.tmp matches 0

# North sits back down: the game resumes where it was, with North to bid.
dummy ln use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0,euchre.seated=4}]
assert not data storage euchre:tables list[0].seats[0].away
await delay 11
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"ln",n:5}
execute if score #ok euchre.tmp matches 0 run fail "the returning player should get their 5 cards back"

# North stands up again and doesn't come back in time: Team A forfeits.
dummy ln sneak true
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=10}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.deadline 0
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=9,euchre.seated=3}]
assert not data storage euchre:tables list[0].seats[0].pid
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"le",n:0}
execute if score #ok euchre.tmp matches 0 run fail "cards should be cleared after the forfeit"
# With only 3 players left, no new game starts after the pause.
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=0}]
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy ln leave
dummy le leave
dummy ls leave
dummy lw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
