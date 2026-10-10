# As a table marker: does it need per-tick work? (Someone seated, or a game on,
# including a paused one with nobody left at the table.)
execute if score @s euchre.seated matches 1.. run return 1
execute if score @s euchre.phase matches 1.. run return 1
return fail
