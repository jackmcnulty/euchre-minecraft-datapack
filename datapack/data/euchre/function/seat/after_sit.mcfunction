# As/at the table marker, after a player sat down (their name is in euchre:tmp name).
scoreboard players add @s euchre.seated 1
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" sat down.",color:"gray"}]
execute if score @s euchre.seated matches 4 run function euchre:table/on_full
