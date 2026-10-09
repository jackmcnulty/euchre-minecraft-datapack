# As a candidate cushion during a failed setup: append {seat, pos} to the report.
data modify storage euchre:tmp cushion_report append value {seat:-1}
execute store result storage euchre:tmp cushion_report[-1].seat int 1 run scoreboard players get @s euchre.seat
data modify storage euchre:tmp cushion_report[-1].pos set from entity @s Pos
