# Undo a half-finished setup and explain the expected layout.
# Record what we found (per-side counts and positions) for the message and for tests.
data modify storage euchre:tmp last_error set value "cushions"
data modify storage euchre:tmp cushion_report set value []
execute as @e[type=minecraft:cushion,tag=euchre.candidate] run function euchre:table/setup/report_cushion

kill @e[type=minecraft:marker,tag=euchre.new]
scoreboard players reset @e[type=minecraft:cushion,tag=euchre.candidate] euchre.seat
tag @e[type=minecraft:cushion,tag=euchre.candidate] remove euchre.candidate
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Setup needs exactly 4 cushions within 3 blocks of you, one on each side of the table. Stand on the centre of the tabletop:",color:"red"}]
tellraw @s {text:"         [N]\n  [W]  table  [E]\n         [S]",color:"gray"}
tellraw @s [{text:"Found (seat 0=N 1=E 2=S 3=W): ",color:"gray"},{storage:"euchre:tmp",nbt:"cushion_report",color:"white"}]
return fail
