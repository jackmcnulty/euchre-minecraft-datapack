# As a seated player: give up the seat (they got up, or the table is going away).
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #seat euchre.tmp = @s euchre.seat
function euchre:player/clear_seat
# Their cards belong to the table, not to them.
function euchre:gen/clear_cards
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
function euchre:seat/release with storage euchre:tmp q
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:seat/after_stand
