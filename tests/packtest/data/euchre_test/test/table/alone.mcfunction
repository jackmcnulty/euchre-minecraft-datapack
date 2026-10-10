# @timeout 1200
# North orders up hearts alone. South (partner) sits out with no cards; the
# dealer (West) still picks up. Tricks have 3 cards and skip South. North takes
# only 2 tricks: euchred, so East/West score 2.
#   North: A-clubs 5, A-hearts 23, A-spades 11, A-diamonds 17, 9-clubs 0
#   East:  10-clubs 1, J-hearts 20, 9-spades 6, 9-diamonds 12, J-clubs 2
#   West:  J-spades 8, Q-hearts 21, Q-spades 9, Q-diamonds 15, K-spades 10 (+9-hearts, discarded)
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 1
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 3
execute positioned ~0.5 ~1 ~0.5 run dummy gn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ge spawn
execute positioned ~0.5 ~1 ~0.5 run dummy gs spawn
execute positioned ~0.5 ~1 ~0.5 run dummy gw spawn
dummy gn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy ge use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy gs use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy gw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]

execute store success score #ok euchre.tmp as gn at gn run function euchre:bid/act {value:3}
assert score #ok euchre.tmp matches 1
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=4,euchre.maker=0,euchre.alone=2,euchre.turn=3}]
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"gs",n:0}
execute if score #ok euchre.tmp matches 0 run fail "South sits out and holds no cards"
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:18}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W discard was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.turn=0}]
# South can't play while sitting out.
execute store success score #ok euchre.tmp as gs run function euchre:play/try {card:3}
assert score #ok euchre.tmp matches 0

execute store success score #ok euchre.tmp as gn run function euchre:play/try {card:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ge run function euchre:play/try {card:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 10-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
# South is skipped: it's West's turn after East.
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.turn=3}]
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:21}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=3,euchre.tricks0=0,euchre.tricks1=1}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=1}]
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:10}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W K-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as gn run function euchre:play/try {card:11}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ge run function euchre:play/try {card:6}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 9-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=1,euchre.tricks1=1}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=2}]
execute store success score #ok euchre.tmp as gn run function euchre:play/try {card:23}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ge run function euchre:play/try {card:20}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E J-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:8}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W J-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=1,euchre.tricks0=1,euchre.tricks1=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=3}]
execute store success score #ok euchre.tmp as ge run function euchre:play/try {card:12}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 9-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as gn run function euchre:play/try {card:17}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=2,euchre.tricks1=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=4}]
execute store success score #ok euchre.tmp as gn run function euchre:play/try {card:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N 9-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ge run function euchre:play/try {card:2}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E J-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as gw run function euchre:play/try {card:9}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=1,euchre.tricks0=2,euchre.tricks1=3}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
# North was euchred going alone: East/West score 2.
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2,euchre.pts0=0,euchre.pts1=2,euchre.alone=-1}]
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy gn leave
dummy ge leave
dummy gs leave
dummy gw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
