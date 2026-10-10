# As/at a table marker: tear the table down completely.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp

# Refund any stakes before anything else is torn down.
function euchre:escrow/refund_all

# Stand up everyone seated here.
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:table/remove_player
# Release the builder's cushions: drop our tags and scores, never the entity.
execute as @e[type=minecraft:cushion,tag=euchre.seat] if score @s euchre.tid = #tid euchre.tmp run function euchre:table/release_cushion
# Delete the storage record and our own entities (including this marker).
function euchre:table/remove_record with storage euchre:tmp q
execute as @e[tag=euchre.entity] if score @s euchre.tid = #tid euchre.tmp run kill @s
function euchre:recount_active
