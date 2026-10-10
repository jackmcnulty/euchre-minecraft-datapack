# As/at the table marker. #seat: the maker, #named: trump.
scoreboard players operation @s euchre.trump = #named euchre.tmp
scoreboard players operation @s euchre.maker = #seat euchre.tmp
function euchre:play/begin
