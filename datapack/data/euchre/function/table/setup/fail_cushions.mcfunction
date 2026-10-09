# Undo a half-finished setup and explain the expected layout.
data modify storage euchre:tmp last_error set value "cushions"
kill @e[type=minecraft:marker,tag=euchre.new]
scoreboard players reset @e[type=minecraft:cushion,tag=euchre.candidate] euchre.seat
tag @e[type=minecraft:cushion,tag=euchre.candidate] remove euchre.candidate
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Setup needs exactly 4 cushions within 3 blocks of you, one on each side of the table. Stand on the centre of the tabletop:",color:"red"}]
tellraw @s {text:"         [N]\n  [W]  table  [E]\n         [S]",color:"gray"}
return fail
