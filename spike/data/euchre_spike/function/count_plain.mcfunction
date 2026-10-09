# (n) Count plain diamonds without removing them (clear ... 0). Expect 3.
scoreboard objectives add euchre_spike dummy
execute store result score #n euchre_spike run clear @s minecraft:diamond[!custom_data,!custom_name,!item_name,!lore,!enchantments,!item_model,!enchantment_glint_override] 0
execute store result score #all euchre_spike run clear @s minecraft:diamond 0
tellraw @s [{text:"[spike n] plain = ",color:"green"},{score:{name:"#n",objective:"euchre_spike"}},{text:" (expect 3)   all diamonds = "},{score:{name:"#all",objective:"euchre_spike"}},{text:" (expect 7)"}]
