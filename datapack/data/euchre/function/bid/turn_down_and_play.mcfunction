# As/at the table marker: remove the up card from the table and start play.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
function euchre:play/begin
