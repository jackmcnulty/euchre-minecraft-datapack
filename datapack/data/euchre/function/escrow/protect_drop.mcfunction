# As a diamond item next to the payee: if it's theirs (overflow from /give),
# stop it despawning. Compare its Owner with the payee's UUID.
execute unless data entity @s Owner run return 0
data modify storage euchre:tmp u set from entity @s Owner
execute store success score #diff euchre.tmp run data modify storage euchre:tmp u set from entity @a[tag=euchre.payee,limit=1] UUID
execute if score #diff euchre.tmp matches 0 run data merge entity @s {Age:-32768s}
