# (e) Capture the player's name via a player_head loot table into storage.
loot replace entity @s weapon.offhand loot euchre_spike:player_head
data modify storage euchre_spike:tmp head set from entity @s equipment.offhand
tellraw @s [{text:"[spike e] offhand head data: ",color:"green"},{storage:"euchre_spike:tmp",nbt:"head"}]
