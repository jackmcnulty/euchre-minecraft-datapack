# As/at the table marker after a pass.
scoreboard players add @s euchre.bids 1
execute if score @s euchre.bids matches 4.. if score @s euchre.phase matches 3 run return run function euchre:bid/begin_round2
execute if score @s euchre.bids matches 4.. if score @s euchre.phase matches 5 run return run function euchre:bid/redeal
function euchre:play/next_turn
function euchre:table/display/update
function euchre:bid/prompt
