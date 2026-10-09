# As a table marker: remember the table centre for classify_cushion and
# spot_for_cushion, in TENTHS of a block. (Not hundredths: x100 overflows a
# 32-bit score beyond ~21.4 million blocks, and worlds extend to 30 million.
# x10 stays below 3e8 everywhere inside the world border.)
execute store result score #mx euchre.tmp run data get entity @s Pos[0] 10
execute store result score #mz euchre.tmp run data get entity @s Pos[2] 10
