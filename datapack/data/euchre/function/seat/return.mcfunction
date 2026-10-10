# As a player sitting back down in the seat held for them.
function euchre:player/identify
scoreboard players operation @s euchre.tid = #tid euchre.tmp
scoreboard players operation @s euchre.seat = #seat euchre.tmp
tag @s add euchre.seated
execute store result storage euchre:tmp q.pid int 1 run scoreboard players get @s euchre.pid
data modify storage euchre:tmp q.name set from storage euchre:tmp name
# Was the seat marked away? If not, the table never noticed them leave (the
# server stopped first, e.g. quitting single player): they're still counted
# as seated, so don't count them twice.
scoreboard players set #was_away euchre.tmp 0
execute if function euchre:seat/was_away run scoreboard players set #was_away euchre.tmp 1
# Rewriting the seat clears its away flag (and refreshes pid/name).
function euchre:seat/claim with storage euchre:tmp q
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:seat/after_return
return 1
