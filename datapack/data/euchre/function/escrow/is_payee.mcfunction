# As a player: succeeds if their UUID is euchre:tmp pay.uuid. (Overwriting a copy
# with their UUID changes nothing exactly when the two are equal.)
data modify storage euchre:tmp u set from storage euchre:tmp pay.uuid
execute store success score #diff euchre.tmp run data modify storage euchre:tmp u set from entity @s UUID
execute if score #diff euchre.tmp matches 0 run return 1
return fail
