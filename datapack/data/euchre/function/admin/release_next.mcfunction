execute unless data storage euchre:tmp pl[0] run return 0
data modify storage euchre:tmp pay set from storage euchre:tmp pl[0]
data modify storage euchre:tmp pay.reason set value "released_to_operator"
execute store result score #amt euchre.tmp run data get storage euchre:tmp pay.amount
scoreboard players operation #owed euchre.g -= #amt euchre.tmp
tag @s add euchre.payee
data modify storage euchre:tmp gv set value {}
data modify storage euchre:tmp gv.amount set from storage euchre:tmp pay.amount
function euchre:gen/escrow_give with storage euchre:tmp gv
tag @s remove euchre.payee
scoreboard players operation #delivered euchre.g += #amt euchre.tmp
data modify storage euchre:tmp log set value {kind:"released_to_operator"}
data modify storage euchre:tmp log.uuid set from storage euchre:tmp pay.uuid
data modify storage euchre:tmp log.name set from storage euchre:tmp pay.name
data modify storage euchre:tmp log.amount set from storage euchre:tmp pay.amount
function euchre:escrow/log
data remove storage euchre:tmp pl[0]
function euchre:admin/release_next
