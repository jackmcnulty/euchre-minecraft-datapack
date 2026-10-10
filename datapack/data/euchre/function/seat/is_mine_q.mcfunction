# Compare UUIDs by trying to overwrite one with the other: no change means equal.
$execute unless data storage euchre:tables list[{id:$(tid)}].seats[$(seat)].uuid run return fail
$data modify storage euchre:tmp u set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].uuid
execute store success score #diff euchre.tmp run data modify storage euchre:tmp u set from entity @s UUID
execute if score #diff euchre.tmp matches 0 run return 1
return fail
