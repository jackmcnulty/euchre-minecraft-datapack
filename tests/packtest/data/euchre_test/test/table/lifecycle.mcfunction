# @timeout 1200
# Table setup validation, seating via real cushion clicks, standing, leaving,
# and removal. One sequential test, because tables are global state.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock

# --- Config validation: every bad request is refused and creates nothing ---
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 0
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:-1,target:5}
assert score #r euchre.tmp matches 0
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:257,target:5}
assert score #r euchre.tmp matches 0
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:10,target:0}
assert score #r euchre.tmp matches 0
# Missing key and non-integer: the macro itself refuses to run (verification item o).
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:10}
assert score #r euchre.tmp matches 0
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:"ten",target:5}
assert score #r euchre.tmp matches 0
assert not data storage euchre:tables list[0]
assert not entity @e[type=minecraft:marker,tag=euchre.table]

# --- Setup with 4 cushions ---
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
summon minecraft:marker ~0.5 ~1 ~0.5 {Tags:["euchre_test.centre"]}
execute positioned ~0.5 ~1 ~0.5 store result score #n euchre.tmp if entity @e[type=minecraft:cushion,distance=..3]
execute unless score #n euchre.tmp matches 4 run fail [{text:"expected 4 cushions near the table, found "},{score:{name:"#n",objective:"euchre.tmp"}}]
data modify storage euchre:tmp last_error set value ""
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:0,target:7}
execute if score #r euchre.tmp matches 0 run fail [{text:"setup refused: "},{storage:"euchre:tmp",nbt:"last_error"},{text:" centre="},{entity:"@e[type=minecraft:marker,tag=euchre_test.centre,limit=1]",nbt:"Pos"},{text:" found="},{storage:"euchre:tmp",nbt:"cushion_report"}]
assert data storage euchre:tables list[0].config{wager:0,target:7,stick_dealer:1b,grace_s:120}
execute store result score #n euchre.tmp if entity @e[type=minecraft:interaction,tag=euchre.spot]
assert score #n euchre.tmp matches 4
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.seat]
assert score #n euchre.tmp matches 4
# The north cushion (-Z of the table) became seat 0, the east one seat 1.
execute positioned ~0.5 ~ ~-0.5 run assert entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},distance=..0.6]
execute positioned ~1.5 ~ ~0.5 run assert entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},distance=..0.6]
execute store result score #n euchre.tmp if entity @e[type=minecraft:text_display,tag=euchre.seat_label]
assert score #n euchre.tmp matches 4
# Labels float above the cushions, off the tabletop: the north one is above the north cushion.
execute positioned ~0.5 ~2.4 ~-0.5 run assert entity @e[type=minecraft:text_display,tag=euchre.seat_label,scores={euchre.seat=0},distance=..0.3]
assert entity @e[type=minecraft:text_display,tag=euchre.board]

# A second table is refused.
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
assert score #r euchre.tmp matches 0

# --- Sitting by right-clicking a cushion (advancement path, item f) ---
execute positioned ~0.5 ~1 ~0.5 run dummy pn spawn
dummy pn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
await entity @a[name=pn,tag=euchre.seated,scores={euchre.seat=0}]
# (An NBT path can't follow an index with a {filter}, so copy the seat out first.)
data modify storage euchre_test:t seat set from storage euchre:tables list[0].seats[0]
assert data storage euchre_test:t seat{name:"pn"}
assert data storage euchre:tables list[0].seats[0].uuid
assert score #active euchre.g matches 1..

# --- A full hotbar is refused (and the player's items are untouched) ---
execute positioned ~0.5 ~1 ~0.5 run dummy pe spawn
item replace entity pe hotbar.0 with minecraft:stone
item replace entity pe hotbar.1 with minecraft:stone
item replace entity pe hotbar.2 with minecraft:stone
item replace entity pe hotbar.3 with minecraft:stone
item replace entity pe hotbar.4 with minecraft:stone
dummy pe use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
await delay 5
assert not entity @a[name=pe,tag=euchre.seated]
assert not data storage euchre:tables list[0].seats[1].pid
execute store result score #n euchre.tmp run clear pe minecraft:stone 0
assert score #n euchre.tmp matches 5

# Make room; now they can sit.
clear pe minecraft:stone
dummy pe use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
await entity @a[name=pe,tag=euchre.seated,scores={euchre.seat=1}]

# --- Standing up (sneak) frees the seat ---
dummy pn sneak true
await not entity @a[name=pn,tag=euchre.seated]
dummy pn sneak false
assert not data storage euchre:tables list[0].seats[0].pid

# --- Disconnecting frees the seat ---
# Vanilla saves a vehicle with its rider on logout, so pe's cushion leaves too
# (it would come back with them on rejoin). Only 3 cushions stay at the table.
dummy pe leave
await not data storage euchre:tables list[0].seats[1].pid
assert score #active euchre.g matches 0
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre_test.cushion]
assert score #n euchre.tmp matches 3

# --- Removal: our entities go, the builder's cushions stay (untagged) ---
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
assert score #r euchre.tmp matches 1
assert not data storage euchre:tables list[0]
assert not entity @e[tag=euchre.entity]
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre_test.cushion,tag=!euchre.seat]
assert score #n euchre.tmp matches 3

kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
dummy pn leave
kill @e[type=minecraft:marker,tag=euchre_test.centre]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
