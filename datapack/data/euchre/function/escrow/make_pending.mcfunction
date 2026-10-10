# The recipient of euchre:tmp pay is offline: owe it to them.
data modify storage euchre:pending list append from storage euchre:tmp pay
scoreboard players operation #owed euchre.g += #amt euchre.tmp
data modify storage euchre:tmp log set value {kind:"owed"}
data modify storage euchre:tmp log.uuid set from storage euchre:tmp pay.uuid
data modify storage euchre:tmp log.name set from storage euchre:tmp pay.name
data modify storage euchre:tmp log.amount set from storage euchre:tmp pay.amount
function euchre:escrow/log
