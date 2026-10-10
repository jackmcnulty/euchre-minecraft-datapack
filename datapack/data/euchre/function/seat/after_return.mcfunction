# As/at the table marker after a player came back to their held seat.
execute if score #was_away euchre.tmp matches 1 run scoreboard players add @s euchre.seated 1
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" is back.",color:"green"}]
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
execute if score @s euchre.phase matches 10 unless function euchre:seat/any_away run return run function euchre:leave/resume
function euchre:recount_active
function euchre:table/display/update
