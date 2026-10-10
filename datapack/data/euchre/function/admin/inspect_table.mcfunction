# As a table marker.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:admin/inspect_table_q with storage euchre:tmp q
