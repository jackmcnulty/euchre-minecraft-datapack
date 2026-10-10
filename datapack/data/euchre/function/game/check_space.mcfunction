# As a seated player before a deal. Leftover cards are ours, so clear those first.
function euchre:gen/clear_cards
# The dealer may pick up the up card, so needs a 6th free slot.
execute store result score #n euchre.tmp run function euchre:gen/count_empty_hotbar_slots
execute unless score @s euchre.seat = #dealer euchre.tmp if score #n euchre.tmp matches 5.. run return 0
execute if score @s euchre.seat = #dealer euchre.tmp if score #n euchre.tmp matches 6.. run return 0
scoreboard players set #short euchre.tmp 1
execute unless score @s euchre.seat = #dealer euchre.tmp run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Please free up 5 hotbar slots so your cards can be dealt.",color:"yellow"}]
execute if score @s euchre.seat = #dealer euchre.tmp run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"You're dealing: please free up 6 hotbar slots (5 cards plus the up card).",color:"yellow"}]
