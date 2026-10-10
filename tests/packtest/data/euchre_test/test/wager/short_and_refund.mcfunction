# @timeout 1200
# Atomic collection: one player is short, so NOTHING is taken from anyone.
# Once they can pay, everyone confirms again and exactly 10 is taken from each.
# Removing the table then refunds every stake exactly.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
function euchre_test:build_table
await score #loaded euchre.tmp matches 1
function euchre_test:place_cushions
execute unless score #cushions euchre.tmp matches 4 run fail "fixture cushions missing"
execute store success score #r euchre.tmp positioned ~0.5 ~1 ~0.5 run function euchre:setup_custom {wager:10,target:5}
assert score #r euchre.tmp matches 1
execute positioned ~0.5 ~1 ~0.5 run dummy wn spawn
execute positioned ~0.5 ~1 ~0.5 run dummy we spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ws spawn
execute positioned ~0.5 ~1 ~0.5 run dummy ww spawn
item replace entity wn inventory.0 with minecraft:diamond 15
item replace entity we inventory.0 with minecraft:diamond 15
item replace entity ws inventory.0 with minecraft:diamond 15
item replace entity ww inventory.0 with minecraft:diamond 5
dummy wn use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=0},limit=1]
dummy we use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=1},limit=1]
dummy ws use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=2},limit=1]
dummy ww use entity @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=3},limit=1]
await entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=1}]
function euchre_test:ledger_snapshot
execute as wn at wn run function euchre:bid/act {value:30}
execute as we at we run function euchre:bid/act {value:30}
execute as ws at ws run function euchre:bid/act {value:30}
execute as ww at ww run function euchre:bid/act {value:30}
# West couldn't pay: nobody lost anything, and the table still waits for stakes.
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"wn",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"short ante: wn has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"we",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"short ante: we has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ws",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"short ante: ws has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ww",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"short ante: ww has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 5"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=1,euchre.pot=0}]
assert data storage euchre:tables list[0]{ante:[0b,0b,0b,0b]}
execute store success score #ok euchre.tmp run function euchre_test:ledger_delta {c:0,d:0,h:0,o:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"short ante: ledger moved by collected "},{score:{name:"#dc",objective:"euchre.tmp"}},{text:" delivered "},{score:{name:"#dd",objective:"euchre.tmp"}},{text:" held "},{score:{name:"#dh",objective:"euchre.tmp"}},{text:" owed "},{score:{name:"#do",objective:"euchre.tmp"}},{text:"; expected 0/0/0/0 and a balanced ledger"}]

# West tops up; everyone confirms again.
item replace entity ww inventory.1 with minecraft:diamond 10
execute as wn at wn run function euchre:bid/act {value:30}
execute as we at we run function euchre:bid/act {value:30}
execute as ws at ws run function euchre:bid/act {value:30}
execute as ww at ww run function euchre:bid/act {value:30}
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"wn",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after collection: wn has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 5"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"we",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after collection: we has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 5"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ws",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after collection: ws has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 5"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ww",n:5}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after collection: ww has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 5"}]
assert entity @e[type=minecraft:marker,tag=euchre.table,scores={euchre.phase=2,euchre.pot=40}]
execute store success score #ok euchre.tmp run function euchre_test:ledger_delta {c:40,d:0,h:40,o:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after collection: ledger moved by collected "},{score:{name:"#dc",objective:"euchre.tmp"}},{text:" delivered "},{score:{name:"#dd",objective:"euchre.tmp"}},{text:" held "},{score:{name:"#dh",objective:"euchre.tmp"}},{text:" owed "},{score:{name:"#do",objective:"euchre.tmp"}},{text:"; expected 40/0/40/0 and a balanced ledger"}]

# Removing the table refunds every stake.
execute positioned ~0.5 ~1 ~0.5 run function euchre:remove_table
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"wn",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"refund: wn has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"we",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"refund: we has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ws",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"refund: ws has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:plain_diamonds {name:"ww",n:15}
execute if score #ok euchre.tmp matches 0 run fail [{text:"refund: ww has "},{score:{name:"#pd",objective:"euchre.tmp"}},{text:" plain diamonds, expected 15"}]
execute store success score #ok euchre.tmp run function euchre_test:ledger_delta {c:40,d:40,h:0,o:0}
execute if score #ok euchre.tmp matches 0 run fail [{text:"after refunds: ledger moved by collected "},{score:{name:"#dc",objective:"euchre.tmp"}},{text:" delivered "},{score:{name:"#dd",objective:"euchre.tmp"}},{text:" held "},{score:{name:"#dh",objective:"euchre.tmp"}},{text:" owed "},{score:{name:"#do",objective:"euchre.tmp"}},{text:"; expected 40/40/0/0 and a balanced ledger"}]
kill @e[type=minecraft:cushion,tag=euchre_test.cushion]
forceload remove ~-2 ~-2 ~2 ~2
dummy wn leave
dummy we leave
dummy ws leave
dummy ww leave
function euchre_test:unlock
