# As/at the table marker: the up card joins the dealer's hand (6 cards), and the
# dealer must discard one.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get @s euchre.dealer
execute store result storage euchre:tmp q.card int 1 run scoreboard players get @s euchre.upcard
function euchre:bid/add_to_hand with storage euchre:tmp q
function euchre:game/save with storage euchre:tmp q

# Hand the card to the dealer (a slot was kept free for it at the deal).
scoreboard players operation #dealer euchre.tmp = @s euchre.dealer
data modify storage euchre:tmp gh set value []
data modify storage euchre:tmp gh append from storage euchre:tmp q.card
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #dealer euchre.tmp run function euchre:bid/give_pickup

scoreboard players set @s euchre.phase 4
scoreboard players operation @s euchre.turn = @s euchre.dealer
function euchre:table/display/update
