# Polls (each tick) until every chunk the table fixture touches is loaded, then
# sets #loaded euchre.tmp to 1. Runs at the fixture's origin marker.
execute as @e[type=minecraft:marker,tag=euchre_test.origin] at @s unless loaded ~-2 ~ ~-2 run return run schedule function euchre_test:area_loaded 1t
execute as @e[type=minecraft:marker,tag=euchre_test.origin] at @s unless loaded ~2 ~ ~-2 run return run schedule function euchre_test:area_loaded 1t
execute as @e[type=minecraft:marker,tag=euchre_test.origin] at @s unless loaded ~-2 ~ ~2 run return run schedule function euchre_test:area_loaded 1t
execute as @e[type=minecraft:marker,tag=euchre_test.origin] at @s unless loaded ~2 ~ ~2 run return run schedule function euchre_test:area_loaded 1t
kill @e[type=minecraft:marker,tag=euchre_test.origin]
scoreboard players set #loaded euchre.tmp 1
