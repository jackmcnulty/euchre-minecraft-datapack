# As a table marker: pass the turn clockwise, skipping a partner who sits out.
scoreboard players add @s euchre.turn 1
scoreboard players operation @s euchre.turn %= #4 euchre.g
execute if score @s euchre.turn = @s euchre.alone run function euchre:play/next_turn
