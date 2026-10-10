# As/at a table marker: if seat $(seat)'s player is offline, they've left.
# Seats already held for an absent player are skipped.
$execute unless data storage euchre:tables list[{id:$(tid)}].seats[$(seat)].pid run return 0
$execute if data storage euchre:tables list[{id:$(tid)}].seats[$(seat)].away run return 0
$execute store result score #pid euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].seats[$(seat)].pid
scoreboard players set #found euchre.tmp 0
execute as @a[tag=euchre.seated] if score @s euchre.pid = #pid euchre.tmp run scoreboard players set #found euchre.tmp 1
execute if score #found euchre.tmp matches 1 run return 0
$function euchre:seat/vacate {tid:$(tid),seat:$(seat)}
