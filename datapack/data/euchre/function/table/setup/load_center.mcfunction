# As a table marker: remember the table centre (in hundredths of a block) for
# classify_cushion and spot_for_cushion.
execute store result score #mx euchre.tmp run data get entity @s Pos[0] 100
execute store result score #mz euchre.tmp run data get entity @s Pos[2] 100
