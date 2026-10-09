# Winner of a trick. Pure apart from scratch storage.
#   in:  #trump, euchre:tmp game.trick = [{seat,card}, ...] in play order
#   out: #winner (seat), #led (effective suit of the first card)
data modify storage euchre:tmp tl set from storage euchre:tmp game.trick
execute store result score #card euchre.tmp run data get storage euchre:tmp tl[0].card
function euchre:rules/eff_suit
scoreboard players operation #led euchre.tmp = #eff euchre.tmp
scoreboard players set #best euchre.tmp -1
scoreboard players set #winner euchre.tmp -1
function euchre:rules/trick_winner_next
