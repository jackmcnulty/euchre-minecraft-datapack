# As a table marker: the state bidding needs, in registers.
scoreboard players operation #phase euchre.tmp = @s euchre.phase
scoreboard players operation #turn euchre.tmp = @s euchre.turn
scoreboard players operation #dealer euchre.tmp = @s euchre.dealer
scoreboard players operation #up_suit euchre.tmp = @s euchre.upcard
scoreboard players operation #up_suit euchre.tmp /= #6 euchre.g
execute store result score #stick euchre.tmp run function euchre:table/get_stick
