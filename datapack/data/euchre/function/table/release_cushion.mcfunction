tag @s remove euchre.seat
# It's an ordinary cushion again: breakable as usual.
data merge entity @s {Invulnerable:0b}
scoreboard players reset @s euchre.tid
scoreboard players reset @s euchre.seat
