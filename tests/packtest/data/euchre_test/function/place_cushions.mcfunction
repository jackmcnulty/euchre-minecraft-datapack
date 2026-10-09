# Second half of build_table: the builder places 4 cushions and leaves.
# Dummies log in at the world origin; bring the builder within reach, looking down.
tp builder ~0.5 ~1 ~0.5 0 90
item replace entity builder weapon.mainhand with minecraft:white_cushion 4
dummy builder use block ~ ~-1 ~-1 up
dummy builder use block ~1 ~-1 ~ up
dummy builder use block ~ ~-1 ~1 up
dummy builder use block ~-1 ~-1 ~ up
dummy builder leave
