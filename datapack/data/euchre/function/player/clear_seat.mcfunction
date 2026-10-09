# As a player: drop all per-seat state. Storage is updated by the caller.
tag @s remove euchre.seated
scoreboard players reset @s euchre.tid
scoreboard players reset @s euchre.seat
