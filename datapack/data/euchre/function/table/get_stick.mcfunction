# As a table marker: returns its stick_dealer setting (1 or 0).
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
return run function euchre:table/get_stick_q with storage euchre:tmp q
