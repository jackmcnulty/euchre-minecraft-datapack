# Adopt a candidate cushion for seat $(seat) if that seat's cushion is gone and
# exactly one candidate sits on that side.
$execute as @e[type=minecraft:cushion,tag=euchre.seat,scores={euchre.seat=$(seat)}] if score @s euchre.tid = #tid euchre.tmp run return 0
$execute store result score #n euchre.tmp if entity @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=$(seat)}]
execute unless score #n euchre.tmp matches 1 run return 0
$execute as @e[type=minecraft:cushion,tag=euchre.candidate,scores={euchre.seat=$(seat)}] run function euchre:table/adopt_cushion
scoreboard players add #adopted euchre.tmp 1
