# @timeout 1200
# Both bidding rounds with stick-the-dealer (the default): everyone passes the
# up card (9 of hearts), it's turned down, hearts can't be named, the stuck
# dealer may not pass and names spades.
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
execute positioned ~0.5 ~1 ~0.5 run dummy bn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy be spawn
execute positioned ~0.5 ~1 ~0.5 run dummy bs spawn
execute positioned ~0.5 ~1 ~0.5 run dummy bw spawn
dummy bn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy be use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy bs use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy bw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]
# Round 1. Out of turn is refused; naming a suit isn't a round-1 choice.
execute store success score #ok euchre.tmp as be at be run function euchre:bid/act {value:1}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as bn at bn run function euchre:bid/act {value:13}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as bn at bn run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as be at be run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as bs at bs run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as bw at bw run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
# Round 2 starts left of the dealer, with the up card turned down.
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=5,euchre.turn=0}]
assert not entity @e[type=minecraft:item_display,tag=euchre.card_shown]
# Hearts (the turned-down suit) can't be named; ordering up is over.
execute store success score #ok euchre.tmp as bn at bn run function euchre:bid/act {value:13}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as bn at bn run function euchre:bid/act {value:2}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as bn at bn run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as be at be run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as bs at bs run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
# The dealer is stuck: passing is refused; naming spades alone works, and
# their partner East sits out.
execute store success score #ok euchre.tmp as bw at bw run function euchre:bid/act {value:1}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as bw at bw run function euchre:bid/act {value:21}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W names spades refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trump=1,euchre.maker=3,euchre.alone=1,euchre.turn=0}]
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"be",n:0}
execute if score #ok euchre.tmp matches 0 run fail "the partner of a lone maker holds no cards"
assert not data storage euchre:tables list[0].game.hands[1][0]
# Nobody picked anything up: everyone still holds 5 cards.
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"bw",n:5}
execute if score #ok euchre.tmp matches 0 run fail "the dealer should still hold 5 cards"
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy bn leave
dummy be leave
dummy bs leave
dummy bw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
