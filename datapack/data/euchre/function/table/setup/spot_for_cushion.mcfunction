# As a claimed cushion: place this seat's card spot on the tabletop, 45% of the
# way from the table centre towards the cushion, at tabletop height (the marker's
# y). 45% keeps the spot on a 1x1 table (cushion 1 block away -> spot 0.45 in)
# and spreads the spots out on larger tables.
execute store result score #dx euchre.tmp run data get entity @s Pos[0] 100
execute store result score #dz euchre.tmp run data get entity @s Pos[2] 100
scoreboard players operation #dx euchre.tmp -= #mx euchre.tmp
scoreboard players operation #dz euchre.tmp -= #mz euchre.tmp
scoreboard players operation #dx euchre.tmp *= #45 euchre.g
scoreboard players operation #dz euchre.tmp *= #45 euchre.g
scoreboard players operation #dx euchre.tmp /= #100 euchre.g
scoreboard players operation #dz euchre.tmp /= #100 euchre.g
scoreboard players operation #seat euchre.tmp = @s euchre.seat

# Hundredths -> blocks for the macro (e.g. 45 -> 0.45).
execute store result storage euchre:tmp spot.ox double 0.01 run scoreboard players get #dx euchre.tmp
execute store result storage euchre:tmp spot.oz double 0.01 run scoreboard players get #dz euchre.tmp
execute at @e[type=minecraft:marker,tag=euchre.new,limit=1] run function euchre:table/setup/summon_spot with storage euchre:tmp spot
