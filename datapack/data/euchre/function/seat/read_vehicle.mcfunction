# As a player: #tid/#seat of the table cushion they're riding (#tid = 0 if none).
scoreboard players set #tid euchre.tmp 0
scoreboard players set #seat euchre.tmp -1
execute on vehicle if entity @s[type=minecraft:cushion,tag=euchre.seat] run scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute on vehicle if entity @s[type=minecraft:cushion,tag=euchre.seat] run scoreboard players operation #seat euchre.tmp = @s euchre.seat
