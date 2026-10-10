# #active = number of tables that need per-tick work. The tick function does no
# per-table work while this is 0.
scoreboard players set #active euchre.g 0
execute as @e[type=minecraft:marker,tag=euchre.table] if function euchre:table/is_active run scoreboard players add #active euchre.g 1
