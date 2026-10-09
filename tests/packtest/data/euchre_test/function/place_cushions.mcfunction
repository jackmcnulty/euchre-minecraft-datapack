# Second half of build_table: the builder places 4 cushions and leaves.
item replace entity builder weapon.mainhand with minecraft:white_cushion 4
dummy builder use block ~ ~-1 ~-1 up
dummy builder use block ~1 ~-1 ~ up
dummy builder use block ~ ~-1 ~1 up
dummy builder use block ~-1 ~-1 ~ up
dummy builder leave
