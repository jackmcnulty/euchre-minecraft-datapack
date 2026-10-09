# Validate a requested config and the surroundings, then build the table.
# Inputs (euchre.tmp): #w wager, #t target, #sd stick_dealer, #gr grace seconds.
# Runs at the operator's position, which becomes the table centre.
# Returns 1 on success and fails (with a message) otherwise.

# --- Config ---
execute unless score #w euchre.tmp matches 0..256 run return run function euchre:util/fail {msg:"Wager must be 0 (free play) to 256 diamonds."}
execute unless score #t euchre.tmp matches 1..25 run return run function euchre:util/fail {msg:"Target must be 1 to 25 points."}
execute unless score #sd euchre.tmp matches 0..1 run return run function euchre:util/fail {msg:"stick_dealer must be 0 or 1."}
execute unless score #gr euchre.tmp matches 30..600 run return run function euchre:util/fail {msg:"grace_s must be 30 to 600 seconds."}
execute if score #w euchre.tmp matches 1.. if score #frozen euchre.g matches 1 run return run function euchre:util/fail {msg:"Wagered tables are disabled until an operator reviews the escrow ledger."}

# --- One table per world for now. The data model already supports more (every
# --- table entity carries an euchre.tid score); lifting this is a later feature.
execute if data storage euchre:tables list[0] run return run function euchre:util/fail {msg:"A Euchre table already exists. Remove it with euchre:remove_table first."}

# --- Exactly 4 unclaimed cushions within 3 blocks, one on each side ---
tag @e[type=minecraft:cushion,distance=..3,tag=!euchre.seat] add euchre.candidate
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate]
execute unless score #n euchre.tmp matches 4 run return run function euchre:table/setup/fail_cushions

summon minecraft:marker ~ ~ ~ {Tags:["euchre.entity","euchre.table","euchre.new"]}
execute as @e[type=minecraft:marker,tag=euchre.new,limit=1] run function euchre:table/setup/load_center
execute as @e[type=minecraft:cushion,tag=euchre.candidate] run function euchre:table/setup/classify_cushion

# Each of the 4 seats must have exactly one cushion.
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=0}]
execute unless score #n euchre.tmp matches 1 run return run function euchre:table/setup/fail_cushions
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=1}]
execute unless score #n euchre.tmp matches 1 run return run function euchre:table/setup/fail_cushions
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=2}]
execute unless score #n euchre.tmp matches 1 run return run function euchre:table/setup/fail_cushions
execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=3}]
execute unless score #n euchre.tmp matches 1 run return run function euchre:table/setup/fail_cushions

function euchre:table/setup/create
return 1
