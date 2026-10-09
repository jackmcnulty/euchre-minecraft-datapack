# As a table marker: copy the state a play needs into registers.
scoreboard players operation #phase euchre.tmp = @s euchre.phase
scoreboard players operation #turn euchre.tmp = @s euchre.turn
scoreboard players operation #trump euchre.tmp = @s euchre.trump
