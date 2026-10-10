# Put seat #seat's player name (table #tid) into euchre:tmp name.
data modify storage euchre:tmp name set value "?"
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
function euchre:play/seat_name with storage euchre:tmp q
