# As/at a table marker: begin a new game with a random first dealer.
scoreboard players set @s euchre.pts0 0
scoreboard players set @s euchre.pts1 0
execute store result score @s euchre.dealer run random value 0..3
function euchre:game/new_hand
