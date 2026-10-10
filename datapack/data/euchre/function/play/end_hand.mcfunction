# As/at the table marker after the fifth trick: score the hand, then end the
# game or deal the next hand (the deal passes clockwise).
scoreboard players operation #mteam euchre.tmp = @s euchre.maker
scoreboard players operation #mteam euchre.tmp %= #2 euchre.g
execute if score #mteam euchre.tmp matches 0 run scoreboard players operation #mtricks euchre.tmp = @s euchre.tricks0
execute if score #mteam euchre.tmp matches 1 run scoreboard players operation #mtricks euchre.tmp = @s euchre.tricks1
scoreboard players set #alone euchre.tmp 0
execute if score @s euchre.alone matches 0.. run scoreboard players set #alone euchre.tmp 1
function euchre:rules/score_hand
execute if score #pteam euchre.tmp matches 0 run scoreboard players operation @s euchre.pts0 += #pts euchre.tmp
execute if score #pteam euchre.tmp matches 1 run scoreboard players operation @s euchre.pts1 += #pts euchre.tmp
function euchre:play/announce_hand

# Game over when the scoring team reaches the table's target.
execute store result score #target euchre.tmp run function euchre:table/get_target
execute if score #pteam euchre.tmp matches 0 if score @s euchre.pts0 >= #target euchre.tmp run return run function euchre:game/win {team:0}
execute if score #pteam euchre.tmp matches 1 if score @s euchre.pts1 >= #target euchre.tmp run return run function euchre:game/win {team:1}
scoreboard players add @s euchre.dealer 1
scoreboard players operation @s euchre.dealer %= #4 euchre.g
function euchre:game/new_hand
