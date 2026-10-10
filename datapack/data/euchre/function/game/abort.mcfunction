# As/at a table marker: cancel the current game with no winner. The reason is in
# euchre:tmp reason. (Wagered tables refund every stake here, in a later milestone.)
function euchre:game/cleanup
scoreboard players set @s euchre.phase 0
scoreboard players set @s euchre.timer -1
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"reason",color:"yellow"}]
