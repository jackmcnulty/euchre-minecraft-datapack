# As a seated player who got up or was knocked off their cushion.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #seat euchre.tmp = @s euchre.seat
function euchre:player/clear_seat
# Their cards belong to the table; they come back if the player does.
function euchre:gen/clear_cards
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:seat/vacate with storage euchre:tmp q
