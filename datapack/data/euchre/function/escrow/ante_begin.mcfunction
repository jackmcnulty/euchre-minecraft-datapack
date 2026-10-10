# As/at a wagered table marker with 4 players seated: everyone must confirm the
# stake before anything is taken.
execute if score #frozen euchre.g matches 1 run return run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Wagered games are paused until an operator reviews the escrow ledger.",color:"red"}]
scoreboard players set @s euchre.phase 1
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:escrow/ante_reset with storage euchre:tmp q
function euchre:table/display/update
function euchre:escrow/ante_prompt
