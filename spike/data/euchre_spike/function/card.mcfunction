# (a) and (h) Give a card-styled debug stick, exactly as the datapack will.
give @s minecraft:debug_stick[custom_data={euchre:{card:5,tid:1,nonce:1}},custom_name={text:"A♣",color:"gray",italic:false},enchantment_glint_override=false,max_stack_size=1]
tellraw @s {text:"[spike a/h] gave a card (A♣, card:5)",color:"green"}
