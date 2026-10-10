# @timeout 1200
# Players from both teams disconnect mid-game and don't return: the game is
# cancelled. Online players are refunded at once; offline ones are owed their
# stake as a pending payout, delivered when they log back in.
# (Rejoin detection itself is vanilla's leave_game statistic, verified in-game.)
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #fixture_ready euchre.tmp matches 1
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:10,target:5}
assert score #r euchre.tmp matches 1
execute positioned ~0.5 ~1 ~0.5 run dummy on spawn
execute positioned ~0.5 ~1 ~0.5 run dummy oe spawn
execute positioned ~0.5 ~1 ~0.5 run dummy os spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ow spawn
item replace entity on inventory.0 with minecraft:diamond 15
item replace entity oe inventory.0 with minecraft:diamond 15
item replace entity os inventory.0 with minecraft:diamond 15
item replace entity ow inventory.0 with minecraft:diamond 15
dummy on use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy oe use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy os use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy ow use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=1}]
function euchre_test:ledger_snapshot
execute as on at on run function euchre:bid/act {value:30}
execute as oe at oe run function euchre:bid/act {value:30}
execute as os at os run function euchre:bid/act {value:30}
execute as ow at ow run function euchre:bid/act {value:30}
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.timer 1
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=3}]

dummy on leave
dummy oe leave
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=10}]
scoreboard players set @e[type=minecraft:marker,tag=euchre.table] euchre.deadline 0
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=0}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"os",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"online refund: os has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ow",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"online refund: ow has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store result score #n euchre.tmp run data get storage euchre:pending list
assert score #n euchre.tmp matches 2..
execute store success score #ok euchre.tmp run function euchre_test:ledger_delta {c:40,d:20,h:0,o:20}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after refunds with two players offline: ledger moved by collected "},{score:{name:"#dc",objective:"euchre.tmp"}},{text:" delivered "},{score:{name:"#dd",objective:"euchre.tmp"}},{text:" held "},{score:{name:"#dh",objective:"euchre.tmp"}},{text:" owed "},{score:{name:"#do",objective:"euchre.tmp"}},{text:"; expected 40/20/0/20 and a balanced ledger"}]

# They come back and are paid. A real player keeps their UUID across sessions;
# PackTest dummies get a fresh one, so point the pending entries at the new
# dummies to stand in for that, then run the delivery a rejoin triggers.
execute positioned ~0.5 ~1 ~0.5 run dummy on spawn
execute positioned ~0.5 ~1 ~0.5 run dummy oe spawn
data modify storage euchre:pending list[{name:"on"}].uuid set from entity on UUID
data modify storage euchre:pending list[{name:"oe"}].uuid set from entity oe UUID
execute as on at on run function euchre:escrow/deliver_pending
execute as oe at oe run function euchre:escrow/deliver_pending
assert not data storage euchre:pending list[{name:"on"}]
assert not data storage euchre:pending list[{name:"oe"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"on",n:10}
execute if score #ok euchre.tmp matches 0 run fail [{text:"pending delivered on rejoin: on has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 10"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"oe",n:10}
execute if score #ok euchre.tmp matches 0 run fail [{text:"pending delivered on rejoin: oe has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 10"}]
execute store success score #ok euchre.tmp run function euchre_test:ledger_delta {c:40,d:40,h:0,o:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after pending delivery: ledger moved by collected "},{score:{name:"#dc",objective:"euchre.tmp"}},{text:" delivered "},{score:{name:"#dd",objective:"euchre.tmp"}},{text:" held "},{score:{name:"#dh",objective:"euchre.tmp"}},{text:" owed "},{score:{name:"#do",objective:"euchre.tmp"}},{text:"; expected 40/40/0/0 and a balanced ledger"}]

execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
dummy on leave
dummy oe leave
dummy os leave
dummy ow leave
function euchre_test:unlock
