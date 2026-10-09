# As a freshly summoned interaction entity: a clickable card spot on the tabletop.
data merge entity @s {width:0.5f,height:0.25f,response:1b,Tags:["euchre.entity","euchre.spot"]}
scoreboard players operation @s euchre.tid = #tid euchre.tmp
scoreboard players operation @s euchre.seat = #seat euchre.tmp
