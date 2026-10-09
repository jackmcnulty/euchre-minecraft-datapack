# As a freshly summoned item_display: a card lying flat on the table.
# left_rotation is -90 degrees about X (a quaternion), which lays the item flat.
data merge entity @s {item_display:"none",transformation:{left_rotation:[-0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.5f,0.5f,0.5f]},Tags:["euchre.entity","euchre.card_shown","euchre.card_new"]}
scoreboard players operation @s euchre.tid = #tid euchre.tmp
