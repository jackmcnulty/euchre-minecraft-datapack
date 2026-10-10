# As/at the table marker: team $(team) won. Split the pot between its two
# players. The pot comes from the escrow record, never from the config, so the
# payout can't exceed what was collected.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/load_entries with storage euchre:tmp q
scoreboard players set #pot euchre.tmp 0
function euchre:escrow/sum_entries
execute if score #pot euchre.tmp matches 0 run return 0
# Two shares that always add up to the pot exactly.
scoreboard players operation #share1 euchre.tmp = #pot euchre.tmp
scoreboard players operation #share1 euchre.tmp /= #2 euchre.g
scoreboard players operation #share2 euchre.tmp = #pot euchre.tmp
scoreboard players operation #share2 euchre.tmp -= #share1 euchre.tmp
$execute store result storage euchre:tmp q.seat int 1 run scoreboard players set #ws euchre.tmp $(team)
data modify storage euchre:tmp pay set value {reason:"winnings"}
function euchre:escrow/payee_from_seat with storage euchre:tmp q
execute store result storage euchre:tmp pay.amount int 1 run scoreboard players get #share1 euchre.tmp
function euchre:escrow/pay
scoreboard players add #ws euchre.tmp 2
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #ws euchre.tmp
data modify storage euchre:tmp pay set value {reason:"winnings"}
function euchre:escrow/payee_from_seat with storage euchre:tmp q
execute store result storage euchre:tmp pay.amount int 1 run scoreboard players get #share2 euchre.tmp
function euchre:escrow/pay
function euchre:escrow/clear_entries with storage euchre:tmp q
scoreboard players set @s euchre.pot 0
function euchre:escrow/assert
