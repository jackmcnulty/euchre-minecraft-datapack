# As/at the table marker when the trick pause ends: clear the table, then the
# next trick, or the end of the hand (early if its result is decided).
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @e[type=minecraft:item_display,tag=euchre.trick_card] if score @s euchre.tid = #tid euchre.tmp run kill @s
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
data modify storage euchre:tmp game.trick set value []
function euchre:game/save with storage euchre:tmp q
scoreboard players add @s euchre.trickno 1
execute if score @s euchre.trickno matches 5.. run return run function euchre:play/end_hand
# Stop early once the remaining tricks can't change the score.
scoreboard players operation #mteam euchre.tmp = @s euchre.maker
scoreboard players operation #mteam euchre.tmp %= #2 euchre.g
execute if score #mteam euchre.tmp matches 0 run scoreboard players operation #mtricks euchre.tmp = @s euchre.tricks0
execute if score #mteam euchre.tmp matches 0 run scoreboard players operation #dtricks euchre.tmp = @s euchre.tricks1
execute if score #mteam euchre.tmp matches 1 run scoreboard players operation #mtricks euchre.tmp = @s euchre.tricks1
execute if score #mteam euchre.tmp matches 1 run scoreboard players operation #dtricks euchre.tmp = @s euchre.tricks0
execute if function euchre:rules/hand_decided run return run function euchre:play/end_early
scoreboard players set @s euchre.phase 6
function euchre:table/display/update
function euchre:play/prompt
