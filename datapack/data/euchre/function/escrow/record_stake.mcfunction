# As the player who just paid #took diamonds into table #tid's escrow.
function euchre:player/capture_name
data modify storage euchre:tmp entry set value {}
data modify storage euchre:tmp entry.uuid set from entity @s UUID
data modify storage euchre:tmp entry.name set from storage euchre:tmp name
execute store result storage euchre:tmp entry.amount int 1 run scoreboard players get #took euchre.tmp
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:escrow/append_entry with storage euchre:tmp q
scoreboard players operation #collected euchre.g += #took euchre.tmp
scoreboard players operation #held euchre.g += #took euchre.tmp
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp run scoreboard players operation @s euchre.pot += #took euchre.tmp
data modify storage euchre:tmp log set value {kind:"collect"}
data modify storage euchre:tmp log.uuid set from storage euchre:tmp entry.uuid
data modify storage euchre:tmp log.name set from storage euchre:tmp entry.name
data modify storage euchre:tmp log.amount set from storage euchre:tmp entry.amount
function euchre:escrow/log
