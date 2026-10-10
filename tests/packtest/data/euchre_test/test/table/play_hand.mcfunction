# @timeout 1200
# A complete hand from a rigged deck. Hearts are trump (the up card's suit), North
# leads. Card ids: suit*6 + rank, suits clubs/spades/diamonds/hearts, ranks
# 9,10,J,Q,K,A. Covers: a real click on a card spot, turn order, refusals
# (out of turn, not your card, not following suit),
# trumping in, both bowers, the left bower counting as trump, and trick counts.
#
#   North (hn): A-clubs 5, A-hearts 23, A-spades 11, A-diamonds 17, 9-clubs 0
#   East  (he): 10-clubs 1, J-hearts 20 (right bower), 9-spades 6, 9-diamonds 12, J-clubs 2
#   South (hs): Q-clubs 3, J-diamonds 14 (left bower), 10-spades 7, 10-diamonds 13, K-clubs 4
#   West  (hw): J-spades 8, Q-hearts 21, Q-spades 9, Q-diamonds 15, K-spades 10
#   kitty: 9-hearts 18 (up card), 10-hearts 19, K-diamonds 16, K-hearts 22
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
execute if score #r euchre.tmp matches 0 run fail [{text:"setup refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
data modify storage euchre:debug rig set value [5,23,11,17,0, 1,20,6,12,2, 3,14,7,13,4, 8,21,9,15,10, 18,19,16,22]
data modify storage euchre:debug dealer set value 3

execute positioned ~0.5 ~1 ~0.5 run dummy hn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy he spawn
execute positioned ~0.5 ~1 ~0.5 run dummy hs spawn
execute positioned ~0.5 ~1 ~0.5 run dummy hw spawn
dummy hn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy he use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy hs use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy hw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3}]
# West dealt, so North (left of the dealer) bids first. West's label says so.
execute unless entity @e[type=minecraft:text_display,tag=euchre.seat_label,scores={euchre.seat=3}] run fail "no label for West"
execute as @e[type=minecraft:text_display,tag=euchre.seat_label,scores={euchre.seat=3}] unless function euchre_test:label_says_dealer run fail [{text:"the dealer's seat label should say Dealer; it has: "},{entity:"@e[type=minecraft:text_display,tag=euchre.seat_label,scores={euchre.seat=3},limit=1]",nbt:"text"}]
execute as @e[type=minecraft:text_display,tag=euchre.seat_label,scores={euchre.seat=0}] if function euchre_test:label_says_dealer run fail "only the dealer's label says Dealer"
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.dealer=3,euchre.turn=0}]

# --- Bidding: North orders up hearts by pressing the chat button (/trigger) ---
execute as hn run trigger euchre.act set 2
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=4}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.trump=3,euchre.maker=0,euchre.turn=3}]
assert not entity @e[type=minecraft:item_display,tag=euchre.card_shown]
# West (dealer) picked up the 9 of hearts and discards it again.
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"hw",n:6}
execute if score #ok euchre.tmp matches 0 run fail "the dealer should hold 6 cards after picking up"
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:5}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:18}
execute if score #ok euchre.tmp matches 0 run fail [{text:"discard refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
# Play starts left of the dealer: North leads.
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.turn=0}]

# --- Refusals: out of turn, and a card that isn't in your hand ---
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:1}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:1}
assert score #ok euchre.tmp matches 0

# --- Trick 1: North leads A-clubs by actually clicking their spot (it's in the
# --- selected hotbar slot 0). West has no clubs and trumps with Q-hearts.
dummy hn use entity @e[type=minecraft:interaction,tag=euchre.spot,scores={euchre.seat=0},limit=1]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.turn=1,euchre.led=0}]
execute store result score #n euchre.tmp run clear hn minecraft:debug_stick[custom_data~{euchre:{card:5}}] 0
assert score #n euchre.tmp matches 0
assert entity @e[type=minecraft:item_display,tag=euchre.trick_card]
# North's card lies face up, turned so its top points at the table centre
# (south, yaw 0): it reads upright from North's seat.
assert entity @e[type=minecraft:item_display,tag=euchre.trick_card,y_rotation=-1..1]
execute store result score #n euchre.tmp run data get entity @e[type=minecraft:item_display,tag=euchre.trick_card,limit=1] transformation.left_rotation[0] 1000
assert score #n euchre.tmp matches 700..710
# East holds a club, so trumping with the right bower is refused.
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:20}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:1}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 10-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:3}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S Q-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:21}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=3,euchre.tricks0=0,euchre.tricks1=1}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=1}]

# --- Trick 2: West leads K-spades; North's A-spades wins.
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:10}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W K-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:11}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:6}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 9-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:7}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S 10-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=1,euchre.tricks1=1}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=2}]

# --- Trick 3: trump led. A-hearts < left bower (J-diamonds) < right bower (J-hearts).
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:23}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:20}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E J-hearts was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
# Trump led: South must follow with the left bower (J-diamonds), not 10-spades.
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:7}
assert score #ok euchre.tmp matches 0
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:14}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S J-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:8}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W J-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=1,euchre.tricks0=1,euchre.tricks1=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=3}]

# --- Trick 4: East leads diamonds; North's A-diamonds wins.
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:12}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E 9-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:13}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S 10-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:17}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N A-diamonds was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=0,euchre.tricks0=2,euchre.tricks1=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=6,euchre.trickno=4}]

# --- Trick 5: North leads 9-clubs; South's K-clubs wins. Team A takes 3 tricks.
execute store success score #ok euchre.tmp as hn run function euchre:play/try {card:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"N 9-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as he run function euchre:play/try {card:2}
execute if score #ok euchre.tmp matches 0 run fail [{text:"E J-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hs run function euchre:play/try {card:4}
execute if score #ok euchre.tmp matches 0 run fail [{text:"S K-clubs was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
execute store success score #ok euchre.tmp as hw run function euchre:play/try {card:9}
execute if score #ok euchre.tmp matches 0 run fail [{text:"W Q-spades was refused: "},{storage:"euchre:tmp",nbt:"last_error"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=7,euchre.leader=2,euchre.tricks0=3,euchre.tricks1=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1

# Everyone's hand is empty; the next hand is dealt by North.
execute store result score #n euchre.tmp run clear hn minecraft:debug_stick[custom_data~{euchre:{}}] 0
assert score #n euchre.tmp matches 0
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2,euchre.dealer=0}]
# North's team made trump and took 3 tricks: 1 point.
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.pts0=1,euchre.pts1=0}]
assert not entity @e[type=minecraft:item_display,tag=euchre.trick_card]

# Clean up.
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy hn leave
dummy he leave
dummy hs leave
dummy hw leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
