execute unless data storage euchre:tmp gh[0] run return 0
execute store result score #c euchre.tmp run data get storage euchre:tmp gh[0]
execute if score #c euchre.tmp = #card euchre.tmp run return run scoreboard players operation #idx euchre.tmp = #i euchre.tmp
scoreboard players add #i euchre.tmp 1
data remove storage euchre:tmp gh[0]
function euchre:rules/hand_index_next
