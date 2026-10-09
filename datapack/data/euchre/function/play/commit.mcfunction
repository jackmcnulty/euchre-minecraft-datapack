# As the player, after validation (#card, #seat, #idx, #tid set; euchre:tmp game loaded).
# Storage and the item change in the same tick, so the reconciler never sees a mismatch.
execute store result storage euchre:tmp q.idx int 1 run scoreboard players get #idx euchre.tmp
function euchre:play/remove_from_hand with storage euchre:tmp q
data modify storage euchre:tmp game.trick append value {seat:0,card:0}
execute store result storage euchre:tmp game.trick[-1].seat int 1 run scoreboard players get #seat euchre.tmp
execute store result storage euchre:tmp game.trick[-1].card int 1 run scoreboard players get #card euchre.tmp
function euchre:game/save with storage euchre:tmp q

data modify storage euchre:tmp gk set value {}
execute store result storage euchre:tmp gk.id int 1 run scoreboard players get #card euchre.tmp
data modify storage euchre:tmp gk.nonce set from storage euchre:tmp game.nonce
function euchre:gen/clear_card with storage euchre:tmp gk

data modify storage euchre:tmp name set value "?"
function euchre:play/seat_name with storage euchre:tmp q
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp at @s run function euchre:play/after_play
