# @timeout 1200
# A hand that ends after trick 4, once its result is decided (issue #1). Hearts
# are trump (North orders up), North leads. North wins three trump tricks: 3-0
# still allows a march, so play goes on. East wins the fourth: 3-1 can only score
# the makers 1, so the hand ends there with no fifth trick, and the deal moves on.
#   North (kn): J-hearts 20, J-diamonds 14, A-hearts 23, 9-clubs 0, 9-spades 6
#   East  (ke): 10-clubs 1, J-clubs 2, Q-clubs 3, K-clubs 4, A-clubs 5
#   South (ks): 10-spades 7, J-spades 8, Q-spades 9, K-spades 10, A-spades 11
#   West  (kw): 9-diamonds 12, 10-diamonds 13, Q-diamonds 15, K-diamonds 16, A-diamonds 17
#   kitty: 9-hearts 18 (up card), 10-hearts 19, Q-hearts 21, K-hearts 22
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
execute if score #r euchre.tmp matches 0 run fail [{text:"setup refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
data modify storage euchre:debug rig set value [20,14,23,0,6, 1,2,3,4,5, 7,8,9,10,11, 12,13,15,16,17, 18,19,21,22]
data modify storage euchre:debug dealer set value 3

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
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3,euchre.turn=0}]

# North orders up hearts; West (dealer) picks up the 9 of hearts and discards it.
execute as kn run trigger euchre.act set 2
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=4}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.trump=3,euchre.maker=0}]
execute store success score #ok euchre.tmp as kw run function euchre:play/try {card:18}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W discard was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.turn=0}]

# --- Trick 1: North leads the right bower.
execute store success score #ok euchre.tmp as kn run function euchre:play/try {card:20}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N J-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ke run function euchre:play/try {card:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 10-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ks run function euchre:play/try {card:7}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S 10-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as kw run function euchre:play/try {card:12}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W 9-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=1,euchre.tricks1=0}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=1}]

# --- Trick 2: the left bower.
execute store success score #ok euchre.tmp as kn run function euchre:play/try {card:14}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N J-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ke run function euchre:play/try {card:2}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E J-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ks run function euchre:play/try {card:8}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S J-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as kw run function euchre:play/try {card:13}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W 10-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=2,euchre.tricks1=0}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=2}]

# --- Trick 3: A-hearts. 3-0 is not decided: a march (2 points) is still possible.
execute store success score #ok euchre.tmp as kn run function euchre:play/try {card:23}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ke run function euchre:play/try {card:3}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E Q-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ks run function euchre:play/try {card:9}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S Q-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as kw run function euchre:play/try {card:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=3,euchre.tricks1=0}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=3}]

# --- Trick 4: North leads 9-clubs; East's A-clubs wins. 3-1: decided.
execute store success score #ok euchre.tmp as kn run function euchre:play/try {card:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N 9-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ke run function euchre:play/try {card:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E A-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as ks run function euchre:play/try {card:10}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S K-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as kw run function euchre:play/try {card:16}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W K-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=1,euchre.tricks0=3,euchre.tricks1=1}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1

# The hand ends without a fifth trick: the makers score 1 and North deals next.
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2,euchre.dealer=0}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.pts0=1,euchre.pts1=0,euchre.trickno=4}]
assert not entity @e[type=minecraft:item_display,tag=euchre.trick_card]
# Nobody keeps their last card, in their inventory or in the stored hand.
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"kn",n:0}
execute if score #ok euchre.tmp matches 0 run fail "kn should hold no cards after the hand ended early"
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"ke",n:0}
execute if score #ok euchre.tmp matches 0 run fail "ke should hold no cards after the hand ended early"
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"ks",n:0}
execute if score #ok euchre.tmp matches 0 run fail "ks should hold no cards after the hand ended early"
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"kw",n:0}
execute if score #ok euchre.tmp matches 0 run fail "kw should hold no cards after the hand ended early"
execute store result score #n euchre.tmp run data get storage euchre:tables list[0].game.hands[0]
execute unless score #n euchre.tmp matches 0 run fail "stored hand 0 should be empty"
execute store result score #n euchre.tmp run data get storage euchre:tables list[0].game.hands[1]
execute unless score #n euchre.tmp matches 0 run fail "stored hand 1 should be empty"
execute store result score #n euchre.tmp run data get storage euchre:tables list[0].game.hands[2]
execute unless score #n euchre.tmp matches 0 run fail "stored hand 2 should be empty"
execute store result score #n euchre.tmp run data get storage euchre:tables list[0].game.hands[3]
execute unless score #n euchre.tmp matches 0 run fail "stored hand 3 should be empty"

# Clean up.
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy kn leave
dummy ke leave
dummy ks leave
dummy kw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
