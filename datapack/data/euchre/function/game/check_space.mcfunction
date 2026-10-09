# As a seated player before a deal. Leftover cards are ours, so clear those first.
function euchre:gen/clear_cards
execute store result score #n euchre.tmp run function euchre:gen/count_empty_hotbar_slots
execute if score #n euchre.tmp matches 5.. run return 0
scoreboard players set #short euchre.tmp 1
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Please free up 5 hotbar slots so your cards can be dealt.",color:"yellow"}]
