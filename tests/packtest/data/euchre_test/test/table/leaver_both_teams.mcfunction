# @timeout 1200
# Players from both teams leave and don't return: the game is cancelled rather
# than forfeited, and both held seats are freed.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #loaded euchre.tmp matches 1
function euchre_test:place_cushions
execute unless score #cushions euchre.tmp matches 4 run fail "fixture cushions missing"
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 1
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 3
execute positioned ~0.5 ~1 ~0.5 run dummy an spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ae spawn
execute positioned ~0.5 ~1 ~0.5 run dummy as spawn
execute positioned ~0.5 ~1 ~0.5 run dummy aw spawn
dummy an use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy ae use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy as use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy aw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]

dummy an sneak true
dummy ae sneak true
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=10,euchre.seated=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.deadline 0
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=0,euchre.seated=2}]
assert not data storage euchre:tables list[0].seats[0].pid
assert not data storage euchre:tables list[0].seats[1].pid
assert data storage euchre:tables list[0].seats[2].pid
assert not data storage euchre:tables list[0].game
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"as",n:0}
execute if score #ok euchre.tmp matches 0 run fail "cards should be cleared when the game is cancelled"
dummy an sneak false
dummy ae sneak false
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy an leave
dummy ae leave
dummy as leave
dummy aw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
