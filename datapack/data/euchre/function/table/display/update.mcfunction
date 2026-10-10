# As a table marker: redraw the board and the seat labels from storage.
# lint: phase-chain-ok (display helpers only read state)
scoreboard players operation #tid euchre.tmp = @s euchre.tid
data modify storage euchre:tmp disp set value {info:"",score:""}
execute store result storage euchre:tmp disp.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp disp.seated int 1 run scoreboard players get @s euchre.seated
execute store result storage euchre:tmp disp.phase int 1 run scoreboard players get @s euchre.phase
execute store result storage euchre:tmp disp.dealer int 1 run scoreboard players get @s euchre.dealer
execute store result storage euchre:tmp disp.up int 1 run scoreboard players get @s euchre.upcard
execute store result storage euchre:tmp disp.trump int 1 run scoreboard players get @s euchre.trump
execute store result storage euchre:tmp disp.turn int 1 run scoreboard players get @s euchre.turn
execute store result storage euchre:tmp disp.t0 int 1 run scoreboard players get @s euchre.tricks0
execute store result storage euchre:tmp disp.t1 int 1 run scoreboard players get @s euchre.tricks1
execute store result storage euchre:tmp disp.p0 int 1 run scoreboard players get @s euchre.pts0
execute store result storage euchre:tmp disp.p1 int 1 run scoreboard players get @s euchre.pts1
function euchre:table/display/phase with storage euchre:tmp disp
execute if score @s euchre.phase matches 2..10 run function euchre:table/display/score_text with storage euchre:tmp disp
execute if score @s euchre.phase matches 10 run data modify storage euchre:tmp disp.info set value "\nWaiting for a player to sit back down"
execute if score @s euchre.phase matches 0 if score @s euchre.seated matches 4 run data modify storage euchre:tmp disp.state set value "Table full"
# While bidding, show who dealt and which card is turned up.
data modify storage euchre:tmp disp.up_label set value "Up card"
execute if score @s euchre.phase matches 5 run data modify storage euchre:tmp disp.up_label set value "Turned down"
execute if score @s euchre.phase matches 3..5 run function euchre:table/display/bid_info with storage euchre:tmp disp
# While playing, show trump, whose turn it is, and the tricks so far.
data modify storage euchre:tmp disp.alone_note set value ""
execute if score @s euchre.alone matches 0.. run data modify storage euchre:tmp disp.alone_note set value " · lone hand"
execute if score @s euchre.phase matches 6..8 run function euchre:table/display/play_info with storage euchre:tmp disp
function euchre:table/display/board with storage euchre:tmp disp
execute as @e[type=minecraft:text_display,tag=euchre.seat_label] if score @s euchre.tid = #tid euchre.tmp run function euchre:table/display/label
