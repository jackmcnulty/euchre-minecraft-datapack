# As/at the table marker. #seat: the maker; #alone_bid: 1 if going alone.
scoreboard players operation @s euchre.trump = #up_suit euchre.tmp
scoreboard players operation @s euchre.maker = #seat euchre.tmp
execute if score #alone_bid euchre.tmp matches 1 run function euchre:bid/go_alone
# A dealer who sits out a lone hand doesn't pick up: the up card is turned down
# and play starts straight away.
execute if score @s euchre.alone = @s euchre.dealer run return run function euchre:bid/turn_down_and_play
function euchre:bid/dealer_pickup
