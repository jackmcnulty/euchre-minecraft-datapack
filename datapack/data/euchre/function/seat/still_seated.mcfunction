# As a seated player: succeeds if they're still riding their own seat's cushion.
scoreboard players operation #pt euchre.tmp = @s euchre.tid
scoreboard players operation #ps euchre.tmp = @s euchre.seat
execute on vehicle if entity @s[type=minecraft:cushion,tag=euchre.seat] if score @s euchre.tid = #pt euchre.tmp if score @s euchre.seat = #ps euchre.tmp run return 1
return fail
