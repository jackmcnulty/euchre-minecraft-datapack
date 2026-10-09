# As a table marker: redraw the board and the seat labels from storage.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
data modify storage euchre:tmp disp set value {info:""}
execute store result storage euchre:tmp disp.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp disp.seated int 1 run scoreboard players get @s euchre.seated
execute store result storage euchre:tmp disp.phase int 1 run scoreboard players get @s euchre.phase
execute store result storage euchre:tmp disp.dealer int 1 run scoreboard players get @s euchre.dealer
execute store result storage euchre:tmp disp.up int 1 run scoreboard players get @s euchre.upcard
function euchre:table/display/phase with storage euchre:tmp disp
execute if score @s euchre.phase matches 0 if score @s euchre.seated matches 4 run data modify storage euchre:tmp disp.state set value "Table full"
# While bidding, show who dealt and which card is turned up.
execute if score @s euchre.phase matches 3..5 run function euchre:table/display/bid_info with storage euchre:tmp disp
function euchre:table/display/board with storage euchre:tmp disp
execute as @e[type=minecraft:text_display,tag=euchre.seat_label] if score @s euchre.tid = #tid euchre.tmp run function euchre:table/display/label
