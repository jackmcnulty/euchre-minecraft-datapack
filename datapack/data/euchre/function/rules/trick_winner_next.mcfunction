execute unless data storage euchre:tmp tl[0] run return 0
execute store result score #card euchre.tmp run data get storage euchre:tmp tl[0].card
function euchre:rules/power
execute if score #power euchre.tmp > #best euchre.tmp run execute store result score #winner euchre.tmp run data get storage euchre:tmp tl[0].seat
execute if score #power euchre.tmp > #best euchre.tmp run scoreboard players operation #best euchre.tmp = #power euchre.tmp
data remove storage euchre:tmp tl[0]
function euchre:rules/trick_winner_next
