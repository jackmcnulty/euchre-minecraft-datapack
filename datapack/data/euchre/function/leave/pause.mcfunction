# As a table marker: freeze the game. The phase timer stops counting while paused.
scoreboard players operation @s euchre.resume = @s euchre.phase
scoreboard players set @s euchre.phase 10
execute store result score #gr euchre.tmp run function euchre:table/get_grace
scoreboard players operation #gr euchre.tmp *= #20 euchre.g
execute store result score @s euchre.deadline run time query gametime
scoreboard players operation @s euchre.deadline += #gr euchre.tmp
