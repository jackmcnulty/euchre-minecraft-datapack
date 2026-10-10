# As/at a table marker: show the up card lying face up in the middle of the table.
# Oriented to read upright for the first bidder (left of the dealer).
scoreboard players operation #first euchre.tmp = @s euchre.dealer
scoreboard players add #first euchre.tmp 1
scoreboard players operation #first euchre.tmp %= #4 euchre.g
execute as @e[type=minecraft:interaction,tag=euchre.spot] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #first euchre.tmp run tag @s add euchre.facing_from
execute positioned ~ ~0.02 ~ facing entity @e[type=minecraft:interaction,tag=euchre.facing_from,limit=1] feet rotated ~180 0 summon minecraft:item_display run function euchre:card/init_shown
tag @e[type=minecraft:interaction,tag=euchre.facing_from] remove euchre.facing_from
execute store result storage euchre:tmp gc.id int 1 run scoreboard players get @s euchre.upcard
execute store result storage euchre:tmp gc.tid int 1 run scoreboard players get @s euchre.tid
execute store result storage euchre:tmp gc.nonce int 1 run scoreboard players get @s euchre.nonce
function euchre:card/lookup with storage euchre:tmp gc
execute as @e[type=minecraft:item_display,tag=euchre.card_new] run function euchre:gen/card_to_contents with storage euchre:tmp gc
tag @e[type=minecraft:item_display,tag=euchre.card_new] remove euchre.card_new
