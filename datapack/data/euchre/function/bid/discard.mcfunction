# As the dealer in the DISCARD phase (#card, #seat, #tid set; called from play/try).
execute unless score #turn euchre.tmp = #seat euchre.tmp run return run function euchre:util/fail {msg:"Wait for the dealer to discard."}
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
function euchre:card/load_hand with storage euchre:tmp q
function euchre:rules/hand_index
execute if score #idx euchre.tmp matches -1 run return run function euchre:util/fail {msg:"That card isn't in your hand."}

# Out of the hand (face down, so it isn't shown), then out of the inventory.
execute store result storage euchre:tmp q.idx int 1 run scoreboard players get #idx euchre.tmp
function euchre:play/remove_from_hand with storage euchre:tmp q
function euchre:game/save with storage euchre:tmp q
data modify storage euchre:tmp gk set value {}
execute store result storage euchre:tmp gk.id int 1 run scoreboard players get #card euchre.tmp
data modify storage euchre:tmp gk.nonce set from storage euchre:tmp game.nonce
function euchre:gen/clear_card with storage euchre:tmp gk

function euchre:bid/announce_name
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" discards a card.",color:"gray"}]
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:play/begin
return 1
