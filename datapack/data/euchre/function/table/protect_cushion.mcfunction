# As a cushion adopted as a seat: make it invulnerable, so a player punching it
# by accident (easy to do mid-game) doesn't break it. Creative-mode players can
# still break it on purpose; pistons, lava and losing the block underneath still
# break it too (vanilla rules for block-attached entities). Undone by
# table/release_cushion when the table lets go of it.
data merge entity @s {Invulnerable:1b}
