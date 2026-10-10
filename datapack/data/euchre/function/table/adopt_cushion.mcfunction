tag @s remove euchre.candidate
tag @s add euchre.seat
function euchre:table/protect_cushion
scoreboard players operation @s euchre.tid = #tid euchre.tmp
