# As/at the table marker when the game-over pause ends: back to waiting, and a
# new game starts at once if all four players are still seated.
scoreboard players set @s euchre.phase 0
scoreboard players set @s euchre.timer -1
function euchre:recount_active
function euchre:table/display/update
execute if score @s euchre.seated matches 4 run function euchre:table/on_full
