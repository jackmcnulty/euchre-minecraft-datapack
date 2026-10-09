# As/at the table marker right after a deal. Until bidding exists (M5), trump is
# simply the up card's suit and the up card is turned down.
scoreboard players operation @s euchre.trump = @s euchre.upcard
scoreboard players operation @s euchre.trump /= #6 euchre.g
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
function euchre:play/begin
