# As/at the table marker: collect once all four have confirmed.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/ante_count with storage euchre:tmp q
execute if score #confirmed euchre.tmp matches 4 run function euchre:escrow/collect_all
