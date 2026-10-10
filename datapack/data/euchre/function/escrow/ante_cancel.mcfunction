# As/at a table marker in the ante when a player left: back to waiting.
scoreboard players set @s euchre.phase 0
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/ante_reset with storage euchre:tmp q
