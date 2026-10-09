# Scheduled one tick after a cushion click (runs as the server).
execute as @a[tag=euchre.sit_check] at @s run function euchre:seat/check_sit_tagged
