# As/at the table marker. #seat: the maker, #named: trump, #alone_bid: going alone.
scoreboard players operation @s euchre.trump = #named euchre.tmp
scoreboard players operation @s euchre.maker = #seat euchre.tmp
execute if score #alone_bid euchre.tmp matches 1 run function euchre:bid/go_alone
function euchre:play/begin
