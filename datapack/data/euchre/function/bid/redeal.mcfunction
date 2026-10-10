# As/at the table marker: everyone passed twice (stick_dealer off). The deal
# passes to the next player and the cards are dealt again.
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Everyone passed twice. Redeal!",color:"yellow"}]
scoreboard players add @s euchre.dealer 1
scoreboard players operation @s euchre.dealer %= #4 euchre.g
function euchre:game/new_hand
