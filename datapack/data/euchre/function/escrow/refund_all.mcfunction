# As/at a table marker: give every stake in its escrow back to whoever paid it.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/load_entries with storage euchre:tmp q
function euchre:escrow/refund_next
function euchre:escrow/clear_entries with storage euchre:tmp q
scoreboard players set @s euchre.pot 0
function euchre:escrow/assert
