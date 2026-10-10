# @timeout 1200
# South deals; North orders up alone, so the dealer is the partner who sits out.
# Nobody picks up: the up card is turned down and play starts at once, led by
# West (left of the dealer).
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #loaded euchre.tmp matches 1
function euchre_test:place_cushions
execute unless score #cushions euchre.tmp matches 4 run fail "fixture cushions missing"
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 1
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 2
execute positioned ~0.5 ~1 ~0.5 run dummy kn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ke spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ks spawn
execute positioned ~0.5 ~1 ~0.5 run dummy kw spawn
dummy kn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy ke use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy ks use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy kw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=3}]

execute store success score #ok euchre.tmp as kw at kw run function euchre:bid/act {value:1}
assert score #ok euchre.tmp matches 1
execute store success score #ok euchre.tmp as kn at kn run function euchre:bid/act {value:3}
assert score #ok euchre.tmp matches 1
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.maker=0,euchre.alone=2,euchre.turn=3,euchre.trump=3}]
assert not entity @e[type=minecraft:item_display,tag=euchre.card_shown]
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"ks",n:0}
execute if score #ok euchre.tmp matches 0 run fail "the dealer sitting out holds no cards"
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"kw",n:5}
execute if score #ok euchre.tmp matches 0 run fail "nobody picked up the up card"
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy kn leave
dummy ke leave
dummy ks leave
dummy kw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
