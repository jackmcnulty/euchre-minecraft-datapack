# @timeout 1200
# Four players sit, the table deals from a rigged deck, hands are kept in step
# with storage, strays are removed, and a player leaving stops the game.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #loaded euchre.tmp matches 1
function euchre_test:place_cushions
execute unless score #cushions euchre.tmp matches 4 run fail [{text:"fixture placed "},{score:{name:"#cushions",objective:"euchre.tmp"}},{text:" cushions, expected 4"}]
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup
execute if score #r euchre.tmp matches 0 run fail [{text:"setup refused: "},{storage:"euchre:tmp",nbt:"last_error"}]

# Rig the deck: seat s is dealt cards 5s..5s+4 and card 20 is turned up.
data modify storage euchre:debug rig set value [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]

execute positioned ~0.5 ~1 ~0.5 run dummy dn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy de spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ds spawn
execute positioned ~0.5 ~1 ~0.5 run dummy dw spawn
dummy dn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy de use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy ds use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy dw use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]

# Full table -> shuffling pause -> deal -> bidding. Skip the 2 s pause: the
# fixture's summoned cushions only last ~100 ticks (see summon_cushion).
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3}]
# The up card (20) lies face up on the table.
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.upcard=20}]
assert entity @e[type=minecraft:item_display,tag=euchre.card_shown]

# Each player holds exactly their 5 cards.
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dn",n:5}
execute if score #ok euchre.tmp matches 0 run fail "dn should hold 5 cards"
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dw",n:5}
execute if score #ok euchre.tmp matches 0 run fail "dw should hold 5 cards"
execute store result score #n euchre.tmp run clear dn minecraft:debug_stick[custom_data~{euchre:{card:0}}] 0
assert score #n euchre.tmp matches 1
execute store result score #n euchre.tmp run clear dw minecraft:debug_stick[custom_data~{euchre:{card:19}}] 0
assert score #n euchre.tmp matches 1
execute store result score #n euchre.tmp run clear dn minecraft:debug_stick[custom_data~{euchre:{card:5}}] 0
assert score #n euchre.tmp matches 0

# Dropping a card: the item on the ground is removed and the card comes back.
dummy dn drop
await not entity @e[type=minecraft:item,distance=..8]
# Reconcile runs every 10 ticks.
await delay 11
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dn",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"dn should hold 5 cards again, has "},{score:{name:"#hc",objective:"euchre.tmp"}},{text:"; phase="},{score:{name:"@e[type=minecraft:marker,tag=euchre.table,limit=1]",objective:"euchre.phase"}},{text:"; seated="},{selector:"@a[tag=euchre.seated]"},{text:"; table seated count="},{score:{name:"@e[type=minecraft:marker,tag=euchre.table,limit=1]",objective:"euchre.seated"}},{text:"; cushions="},{selector:"@e[type=minecraft:cushion,tag=euchre_test.cushion]"}]
execute store result score #n euchre.tmp run clear dn minecraft:debug_stick[custom_data~{euchre:{card:0}}] 0
assert score #n euchre.tmp matches 1

# A smuggled duplicate is removed; the hand is back to exactly 5 distinct cards.
item replace entity dn hotbar.8 with minecraft:debug_stick[custom_data={euchre:{card:1,tid:1,nonce:1}}]
await delay 11
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dn",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"dn should hold 5 cards again, has "},{score:{name:"#hc",objective:"euchre.tmp"}},{text:"; phase="},{score:{name:"@e[type=minecraft:marker,tag=euchre.table,limit=1]",objective:"euchre.phase"}},{text:"; seated="},{selector:"@a[tag=euchre.seated]"},{text:"; table seated count="},{score:{name:"@e[type=minecraft:marker,tag=euchre.table,limit=1]",objective:"euchre.seated"}},{text:"; cushions="},{selector:"@e[type=minecraft:cushion,tag=euchre_test.cushion]"}]
execute store result score #n euchre.tmp run clear dn minecraft:debug_stick[custom_data~{euchre:{card:1}}] 0
assert score #n euchre.tmp matches 1

# Someone who is not seated can't keep a card.
execute positioned ~0.5 ~1 ~0.5 run dummy dx spawn
item replace entity dx hotbar.0 with minecraft:debug_stick[custom_data={euchre:{card:3,tid:1,nonce:1}}]
# The stray sweep runs every 20 ticks.
await delay 21
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dx",n:0}
execute if score #ok euchre.tmp matches 0 run fail "dx should hold no cards"
dummy dx leave

# A player leaving mid-game stops it and takes everyone's cards back.
dummy dw leave
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=0}]
execute store success score #ok euchre.tmp run function euchre_test:has_cards {name:"dn",n:0}
execute if score #ok euchre.tmp matches 0 run fail "dn should hold no cards after the abort"
assert not entity @e[type=minecraft:item_display,tag=euchre.card_shown]

# Clean up.
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
dummy dn leave
dummy de leave
dummy ds leave
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
function euchre_test:unlock
