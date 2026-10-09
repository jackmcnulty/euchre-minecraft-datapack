# As/at a table marker: begin a new game with a random first dealer.
scoreboard players set @s euchre.pts0 0
scoreboard players set @s euchre.pts1 0
execute store result score @s euchre.dealer run random value 0..3
# Test hook: a fixed first dealer (used once).
execute if data storage euchre:debug dealer store result score @s euchre.dealer run data get storage euchre:debug dealer
data remove storage euchre:debug dealer
function euchre:game/new_hand
