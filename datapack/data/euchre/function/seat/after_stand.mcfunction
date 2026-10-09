# As/at the table marker, after a seat was freed (occupant's name in euchre:tmp name).
scoreboard players remove @s euchre.seated 1
execute if score @s euchre.seated matches ..-1 run scoreboard players set @s euchre.seated 0
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" left the table.",color:"gray"}]
