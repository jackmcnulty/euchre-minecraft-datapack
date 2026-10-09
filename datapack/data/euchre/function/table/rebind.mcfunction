# As/at a table marker: adopt unclaimed cushions for seats that lost theirs.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
function euchre:table/setup/load_center
tag @e[type=minecraft:cushion,distance=..3,tag=!euchre.seat] add euchre.candidate
execute as @e[type=minecraft:cushion,tag=euchre.candidate] run function euchre:table/setup/classify_cushion
scoreboard players set #adopted euchre.tmp 0
function euchre:table/rebind_seat {seat:0}
function euchre:table/rebind_seat {seat:1}
function euchre:table/rebind_seat {seat:2}
function euchre:table/rebind_seat {seat:3}
scoreboard players reset @e[type=minecraft:cushion,tag=euchre.candidate] euchre.seat
tag @e[type=minecraft:cushion,tag=euchre.candidate] remove euchre.candidate
# How many seats still have no cushion?
scoreboard players set #missing euchre.tmp 4
execute as @e[type=minecraft:cushion,tag=euchre.seat] if score @s euchre.tid = #tid euchre.tmp run scoreboard players remove #missing euchre.tmp 1
