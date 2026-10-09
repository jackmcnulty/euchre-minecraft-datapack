# (n) Give one of each diamond variant: 3 plain + 4 "tainted" ones.
give @s minecraft:diamond 3
give @s minecraft:diamond[custom_name={text:"Renamed"}] 1
give @s minecraft:diamond[custom_data={x:1}] 1
give @s minecraft:diamond[enchantment_glint_override=true] 1
give @s minecraft:diamond[lore=[{text:"lore"}]] 1
tellraw @s {text:"[spike n] gave 3 plain + 4 non-plain diamonds. Now run: /function euchre_spike:count_plain",color:"green"}
