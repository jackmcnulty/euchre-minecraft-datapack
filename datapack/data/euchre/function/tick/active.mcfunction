# Per-tick work while any table has someone seated.
execute as @e[type=minecraft:marker,tag=euchre.table,scores={euchre.seated=1..}] at @s run function euchre:table/tick
