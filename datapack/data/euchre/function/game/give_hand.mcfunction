# As a seated player during a deal (euchre:tmp game is current): deal their hand.
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get @s euchre.seat
function euchre:card/load_hand with storage euchre:tmp q
function euchre:card/give_hand_list
