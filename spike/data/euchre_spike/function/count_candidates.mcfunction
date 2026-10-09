# (n, round 2) Count diamonds with several candidate "plain diamond" predicates.
# Run after: /clear  then  /function euchre_spike:diamonds
# Inventory = 3 plain + 1 renamed + 1 custom_data + 1 glint + 1 lore (7 total).
scoreboard objectives add euchre_spike dummy
execute store result score #c0 euchre_spike run clear @s minecraft:diamond[!item_model] 0
execute store result score #c1 euchre_spike run clear @s minecraft:diamond[!custom_data] 0
execute store result score #c2 euchre_spike run clear @s minecraft:diamond[!custom_data,!custom_name] 0
execute store result score #c3 euchre_spike run clear @s minecraft:diamond[!custom_data,!custom_name,!enchantment_glint_override] 0
execute store result score #c4 euchre_spike run clear @s minecraft:diamond[!custom_data,!custom_name,!enchantment_glint_override,lore=[]] 0
execute store result score #c5 euchre_spike run clear @s minecraft:diamond[!custom_data,!custom_name,!enchantment_glint_override,lore=[],enchantments={}] 0
tellraw @s [{text:"[spike n2] ",color:"green"},{text:"c0="},{score:{name:"#c0",objective:"euchre_spike"}},{text:" (expect 0)  c1="},{score:{name:"#c1",objective:"euchre_spike"}},{text:" (6)  c2="},{score:{name:"#c2",objective:"euchre_spike"}},{text:" (5)  c3="},{score:{name:"#c3",objective:"euchre_spike"}},{text:" (4)  c4="},{score:{name:"#c4",objective:"euchre_spike"}},{text:" (3)  c5="},{score:{name:"#c5",objective:"euchre_spike"}},{text:" (3)"}]
