# As a table marker: returns its grace period in seconds.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
return run function euchre:table/get_grace_q with storage euchre:tmp q
