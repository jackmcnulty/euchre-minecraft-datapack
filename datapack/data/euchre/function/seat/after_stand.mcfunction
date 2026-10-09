# As/at the table marker, after a seat was freed (occupant's name in euchre:tmp name).
scoreboard players remove @s euchre.seated 1
execute if score @s euchre.seated matches ..-1 run scoreboard players set @s euchre.seated 0
# Mid-game, a player leaving stops the game. (Leaver handling with a grace
# period replaces this in a later milestone.)
execute unless score @s euchre.phase matches 0..1 run function euchre:game/abort
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" left the table.",color:"gray"}]
