# As/at the table marker when the hand is decided before the fifth trick. The
# stored hands are emptied first, so the reconciler agrees nobody holds cards,
# then the leftover card items go and the hand is scored as usual.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
data modify storage euchre:tmp game.hands set value [[],[],[],[]]
function euchre:game/save with storage euchre:tmp q
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:gen/clear_cards
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"The hand is decided: no need to play the rest.",color:"gray"}]
function euchre:play/end_hand
