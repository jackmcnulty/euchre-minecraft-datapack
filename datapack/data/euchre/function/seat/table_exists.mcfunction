# Succeeds if a table marker with id #tid is loaded.
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp run return 1
return fail
