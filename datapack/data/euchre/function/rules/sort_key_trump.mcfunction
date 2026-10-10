# Trump cards sort first, by power (20 right bower .. 12 the nine): key 40 - power.
scoreboard players operation #trump euchre.tmp = #sorttrump euchre.tmp
scoreboard players operation #led euchre.tmp = #sorttrump euchre.tmp
function euchre:rules/power
execute unless score #eff euchre.tmp = #trump euchre.tmp run return 0
scoreboard players set #key euchre.tmp 40
scoreboard players operation #key euchre.tmp -= #power euchre.tmp
