# Second half of build_table: the builder places 4 cushions and leaves.
item replace entity builder weapon.mainhand with minecraft:white_cushion 4
dummy builder use block ~ ~-1 ~-1 up
dummy builder use block ~1 ~-1 ~ up
dummy builder use block ~ ~-1 ~1 up
dummy builder use block ~-1 ~-1 ~ up
dummy builder leave
execute positioned ~0.5 ~ ~0.5 run tag @e[type=minecraft:cushion,distance=..2] add euchre_test.cushion
execute positioned ~0.5 ~ ~0.5 store result score #cushions euchre.tmp if entity @e[type=minecraft:cushion,distance=..2]
