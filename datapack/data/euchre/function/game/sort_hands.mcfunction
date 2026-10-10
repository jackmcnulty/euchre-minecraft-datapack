# Sort all four hands of the working game (euchre:tmp game) for display.
#   in: #sorttrump (-1 before trump is known)
data modify storage euchre:tmp q.seat set value 0
function euchre:game/sort_one_hand with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 1
function euchre:game/sort_one_hand with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 2
function euchre:game/sort_one_hand with storage euchre:tmp q
data modify storage euchre:tmp q.seat set value 3
function euchre:game/sort_one_hand with storage euchre:tmp q
