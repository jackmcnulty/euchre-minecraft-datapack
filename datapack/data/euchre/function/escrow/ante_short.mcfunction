# As/at the table marker: someone couldn't pay. Nothing was taken; everyone
# confirms again once the short player is ready.
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Not everyone has the stake right now, so nothing was taken. Confirm again when ready.",color:"yellow"}]
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/ante_reset with storage euchre:tmp q
function euchre:escrow/ante_prompt
