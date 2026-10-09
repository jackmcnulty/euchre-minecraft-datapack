# Succeeds if euchre:tmp shuffled holds each card id 0-23 exactly once.
execute store result score #n euchre.tmp run data get storage euchre:tmp shuffled
execute unless score #n euchre.tmp matches 24 run return fail
scoreboard players set #seen0 euchre.tmp 0
scoreboard players set #seen1 euchre.tmp 0
scoreboard players set #seen2 euchre.tmp 0
scoreboard players set #seen3 euchre.tmp 0
scoreboard players set #seen4 euchre.tmp 0
scoreboard players set #seen5 euchre.tmp 0
scoreboard players set #seen6 euchre.tmp 0
scoreboard players set #seen7 euchre.tmp 0
scoreboard players set #seen8 euchre.tmp 0
scoreboard players set #seen9 euchre.tmp 0
scoreboard players set #seen10 euchre.tmp 0
scoreboard players set #seen11 euchre.tmp 0
scoreboard players set #seen12 euchre.tmp 0
scoreboard players set #seen13 euchre.tmp 0
scoreboard players set #seen14 euchre.tmp 0
scoreboard players set #seen15 euchre.tmp 0
scoreboard players set #seen16 euchre.tmp 0
scoreboard players set #seen17 euchre.tmp 0
scoreboard players set #seen18 euchre.tmp 0
scoreboard players set #seen19 euchre.tmp 0
scoreboard players set #seen20 euchre.tmp 0
scoreboard players set #seen21 euchre.tmp 0
scoreboard players set #seen22 euchre.tmp 0
scoreboard players set #seen23 euchre.tmp 0
data modify storage euchre_test:t l set from storage euchre:tmp shuffled
function euchre_test:mark_next
execute unless score #seen0 euchre.tmp matches 1 run return fail
execute unless score #seen1 euchre.tmp matches 1 run return fail
execute unless score #seen2 euchre.tmp matches 1 run return fail
execute unless score #seen3 euchre.tmp matches 1 run return fail
execute unless score #seen4 euchre.tmp matches 1 run return fail
execute unless score #seen5 euchre.tmp matches 1 run return fail
execute unless score #seen6 euchre.tmp matches 1 run return fail
execute unless score #seen7 euchre.tmp matches 1 run return fail
execute unless score #seen8 euchre.tmp matches 1 run return fail
execute unless score #seen9 euchre.tmp matches 1 run return fail
execute unless score #seen10 euchre.tmp matches 1 run return fail
execute unless score #seen11 euchre.tmp matches 1 run return fail
execute unless score #seen12 euchre.tmp matches 1 run return fail
execute unless score #seen13 euchre.tmp matches 1 run return fail
execute unless score #seen14 euchre.tmp matches 1 run return fail
execute unless score #seen15 euchre.tmp matches 1 run return fail
execute unless score #seen16 euchre.tmp matches 1 run return fail
execute unless score #seen17 euchre.tmp matches 1 run return fail
execute unless score #seen18 euchre.tmp matches 1 run return fail
execute unless score #seen19 euchre.tmp matches 1 run return fail
execute unless score #seen20 euchre.tmp matches 1 run return fail
execute unless score #seen21 euchre.tmp matches 1 run return fail
execute unless score #seen22 euchre.tmp matches 1 run return fail
execute unless score #seen23 euchre.tmp matches 1 run return fail
return 1
