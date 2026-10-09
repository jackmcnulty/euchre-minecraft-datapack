# (a) Try to read the held card's id from player NBT, two candidate paths.
scoreboard objectives add euchre_spike dummy
scoreboard players set #a1 euchre_spike -1
scoreboard players set #a2 euchre_spike -1
execute store result score #a1 euchre_spike run data get entity @s SelectedItem.components."minecraft:custom_data".euchre.card
execute store result score #a2 euchre_spike run data get entity @s equipment.mainhand.components."minecraft:custom_data".euchre.card
tellraw @s [{text:"[spike a] SelectedItem path -> ",color:"green"},{score:{name:"#a1",objective:"euchre_spike"}},{text:"   equipment.mainhand path -> "},{score:{name:"#a2",objective:"euchre_spike"}},{text:"   (expect 5; -1 or 0 = path not readable)",color:"gray"}]
