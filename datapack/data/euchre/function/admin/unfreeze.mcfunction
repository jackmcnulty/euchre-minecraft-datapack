# Operator: resume wagered games after reviewing a ledger mismatch.
scoreboard players set #frozen euchre.g 0
data modify storage euchre:tmp log set value {kind:"unfreeze",amount:0}
data modify storage euchre:tmp log.uuid set from entity @s UUID
function euchre:player/capture_name
data modify storage euchre:tmp log.name set from storage euchre:tmp name
function euchre:escrow/log
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Wagered games are enabled again.",color:"green"}]
