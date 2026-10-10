# @timeout 1200
# With stick_dealer off, passing twice around the table redeals: the deal
# passes to the next player.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #loaded euchre.tmp matches 1
function euchre_test:place_cushions
execute unless score #cushions euchre.tmp matches 4 run fail "fixture cushions missing"
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_advanced {wager:0,target:5,stick_dealer:0,grace_s:120}
assert score #r euchre.tmp matches 1
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 3
execute positioned ~0.5 ~1 ~0.5 run dummy rn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy re spawn
execute positioned ~0.5 ~1 ~0.5 run dummy rs spawn
execute positioned ~0.5 ~1 ~0.5 run dummy rw spawn
dummy rn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy re use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy rs use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy rw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]
execute store success score #ok euchre.tmp as rn at rn run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as re at re run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as rs at rs run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as rw at rw run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as rn at rn run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as re at re run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as rs at rs run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as rw at rw run function euchre:bid/act {value:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W (dealer) pass refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2,euchre.dealer=0}]
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy rn leave
dummy re leave
dummy rs leave
dummy rw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
