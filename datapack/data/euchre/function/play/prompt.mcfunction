# As/at a table marker: tell the player whose turn it is.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #turn euchre.tmp = @s euchre.turn
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #turn euchre.tmp run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Your turn: hold a card and right-click your spot.",color:"aqua"}]
