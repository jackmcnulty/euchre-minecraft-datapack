execute unless data storage euchre:tmp ssl[0] run return 0
execute store result score #card euchre.tmp run data get storage euchre:tmp ssl[0]
function euchre:rules/sort_key
execute if score #key euchre.tmp < #best euchre.tmp run scoreboard players operation #bi euchre.tmp = #si euchre.tmp
execute if score #key euchre.tmp < #best euchre.tmp run scoreboard players operation #best euchre.tmp = #key euchre.tmp
scoreboard players add #si euchre.tmp 1
data remove storage euchre:tmp ssl[0]
function euchre:rules/sort_scan
