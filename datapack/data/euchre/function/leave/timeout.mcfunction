# As/at a paused table marker whose grace period ran out. If one team has players
# away, it forfeits; if both do, the game is cancelled.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:leave/count_away with storage euchre:tmp q
execute if score #away0 euchre.tmp matches 1 if score #away1 euchre.tmp matches 1 run data modify storage euchre:tmp reason set value "Players from both teams left and didn't return. The game is cancelled."
execute if score #away0 euchre.tmp matches 1 if score #away1 euchre.tmp matches 1 run return run function euchre:game/abort
execute if score #away0 euchre.tmp matches 1 run return run function euchre:leave/forfeit {team:0,winner:1}
execute if score #away1 euchre.tmp matches 1 run return run function euchre:leave/forfeit {team:1,winner:0}
# Nobody is away any more (shouldn't happen: returning resumes the game).
function euchre:leave/resume
