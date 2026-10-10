# As/at a seated player: make bidding choice $(value). The internal API behind
# the chat buttons; tests call it directly.
#   1 pass, 2 order up / 3 order up alone (round 1),
#   10+suit name that suit / 20+suit name it alone (round 2)
$scoreboard players set #act euchre.tmp $(value)
scoreboard players set #alone_bid euchre.tmp 0
execute unless entity @s[tag=euchre.seated] run return fail
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #seat euchre.tmp = @s euchre.seat

scoreboard players set #phase euchre.tmp -1
scoreboard players set #near euchre.tmp 0
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp run function euchre:bid/read_table
execute as @e[type=minecraft:marker,tag=euchre.table,distance=..8] if score @s euchre.tid = #tid euchre.tmp run scoreboard players set #near euchre.tmp 1
execute unless score #phase euchre.tmp matches 3 unless score #phase euchre.tmp matches 5 run return run function euchre:util/fail {msg:"There's no bidding right now."}
execute unless score #near euchre.tmp matches 1 run return run function euchre:util/fail {msg:"You're too far from the table."}
execute unless score #turn euchre.tmp = #seat euchre.tmp run return run function euchre:util/fail {msg:"It's not your turn to bid."}

execute if score #phase euchre.tmp matches 3 run return run function euchre:bid/round1
return run function euchre:bid/round2
