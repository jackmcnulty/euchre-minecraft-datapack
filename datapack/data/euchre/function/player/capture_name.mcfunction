# As a player: store their name as a string in euchre:tmp name.
# No command returns a player's name as a string, so we roll a player_head loot
# table (whose fill_player_head modifier copies "this" player's profile) into a
# temporary item_display and read the profile name from it. The player's own
# inventory is never touched. Only the name is kept; the profile also carries a
# large skin signature we don't want in storage.
data modify storage euchre:tmp name set value "?"
execute at @s run summon minecraft:item_display ~ ~ ~ {Tags:["euchre.name_probe"]}
loot replace entity @e[type=minecraft:item_display,tag=euchre.name_probe,limit=1] contents loot euchre:player_head
data modify storage euchre:tmp name set from entity @e[type=minecraft:item_display,tag=euchre.name_probe,limit=1] item.components."minecraft:profile".name
kill @e[type=minecraft:item_display,tag=euchre.name_probe]
