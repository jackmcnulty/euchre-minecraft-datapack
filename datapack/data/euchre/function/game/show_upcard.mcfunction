# As/at a table marker: show the up card lying face up in the middle of the table.
execute positioned ~ ~0.02 ~ summon minecraft:item_display run function euchre:card/init_shown
execute store result storage euchre:tmp gc.id int 1 run scoreboard players get @s euchre.upcard
execute store result storage euchre:tmp gc.tid int 1 run scoreboard players get @s euchre.tid
execute store result storage euchre:tmp gc.nonce int 1 run scoreboard players get @s euchre.nonce
function euchre:card/lookup with storage euchre:tmp gc
execute as @e[type=minecraft:item_display,tag=euchre.card_new] run function euchre:gen/card_to_contents with storage euchre:tmp gc
tag @e[type=minecraft:item_display,tag=euchre.card_new] remove euchre.card_new
