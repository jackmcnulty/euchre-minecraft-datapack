# Fisher-Yates: move a uniformly random remaining card onto the shuffled pile,
# #n times. /random needs a range of at least 2 values, so when one card is
# left it moves without a roll.
execute if score #n euchre.tmp matches ..1 run return run data modify storage euchre:tmp shuffled append from storage euchre:tmp deck[0]
scoreboard players remove #n euchre.tmp 1
execute store result storage euchre:tmp pick.max int 1 run scoreboard players get #n euchre.tmp
function euchre:deck/pick with storage euchre:tmp pick
function euchre:deck/shuffle_step
