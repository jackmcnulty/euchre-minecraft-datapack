# As/at the table marker. #seat: the maker.
scoreboard players operation @s euchre.trump = #up_suit euchre.tmp
scoreboard players operation @s euchre.maker = #seat euchre.tmp
function euchre:bid/dealer_pickup
