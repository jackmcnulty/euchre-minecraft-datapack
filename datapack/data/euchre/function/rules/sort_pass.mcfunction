# Move the lowest-key card of euchre:tmp gh to euchre:tmp sorted; repeat.
execute unless data storage euchre:tmp gh[0] run return 0
data modify storage euchre:tmp ssl set from storage euchre:tmp gh
scoreboard players set #best euchre.tmp 2147483647
scoreboard players set #bi euchre.tmp 0
scoreboard players set #si euchre.tmp 0
function euchre:rules/sort_scan
execute store result storage euchre:tmp si.i int 1 run scoreboard players get #bi euchre.tmp
function euchre:rules/sort_take with storage euchre:tmp si
function euchre:rules/sort_pass
