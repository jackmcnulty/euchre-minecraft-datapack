# As/at a table marker: free seat $(seat) if its player is offline.
# (Mid-game this becomes the grace-period pause; while waiting for players we
# just free the seat.)
$execute unless data storage euchre:tables list[{id:$(tid)}].seats[$(seat)].pid run return 0
$execute store result score #pid euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].seats[$(seat)].pid
scoreboard players set #found euchre.tmp 0
execute as @a if score @s euchre.pid = #pid euchre.tmp run scoreboard players set #found euchre.tmp 1
execute if score #found euchre.tmp matches 1 run return 0
$function euchre:seat/release {tid:$(tid),seat:$(seat)}
function euchre:seat/after_stand
