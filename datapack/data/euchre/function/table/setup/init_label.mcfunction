# As a freshly summoned text_display: the small label above a seat's cushion.
data merge entity @s {billboard:"center",shadow:1b,background:0,line_width:120,alignment:"center",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.5f,0.5f,0.5f]},Tags:["euchre.entity","euchre.display","euchre.seat_label"]}
scoreboard players operation @s euchre.tid = #tid euchre.tmp
scoreboard players operation @s euchre.seat = #seat euchre.tmp
