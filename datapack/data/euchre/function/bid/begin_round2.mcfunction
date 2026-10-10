# As/at the table marker: everyone passed the up card. Turn it down and bid again,
# starting left of the dealer.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Everyone passed; the up card is turned down. Second round: name trump.",color:"yellow"}]
scoreboard players set @s euchre.phase 5
scoreboard players set @s euchre.bids 0
scoreboard players operation @s euchre.turn = @s euchre.dealer
function euchre:play/next_turn
function euchre:table/display/update
function euchre:bid/prompt
