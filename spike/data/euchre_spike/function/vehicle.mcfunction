# (j) Run while seated on a cushion. Reports whether `execute on vehicle` finds it.
execute on vehicle if entity @s[type=minecraft:cushion] run tellraw @a {text:"[spike j] on vehicle -> cushion ✔",color:"green"}
execute on vehicle unless entity @s[type=minecraft:cushion] run tellraw @a [{text:"[spike j] vehicle is NOT a cushion: ",color:"red"},{selector:"@s"}]
execute unless function euchre_spike:has_vehicle run tellraw @a {text:"[spike j] no vehicle found",color:"red"}
