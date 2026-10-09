# As/at a table marker: free every seat whose player is no longer online.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
data modify storage euchre:tmp q.seat set value 0
function euchre:table/check_seat_present with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 1
function euchre:table/check_seat_present with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 2
function euchre:table/check_seat_present with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 3
function euchre:table/check_seat_present with storage euchre:tmp q
