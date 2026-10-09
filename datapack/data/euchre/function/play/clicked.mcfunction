# Advancement reward (euchre:spot_click): the player right-clicked an interaction
# entity. Find which card spot they clicked: the one whose last interaction is
# this tick and whose `execute on target` (last clicker) is this player.
advancement revoke @s only euchre:spot_click
execute store result score #now euchre.tmp run time query gametime
tag @s add euchre.clicking
scoreboard players set #spot euchre.tmp -1
execute as @e[type=minecraft:interaction,tag=euchre.spot,distance=..8] if function euchre:play/is_clicked_now run function euchre:play/note_spot
tag @s remove euchre.clicking
execute if score #spot euchre.tmp matches -1 run return 0
function euchre:play/from_click
