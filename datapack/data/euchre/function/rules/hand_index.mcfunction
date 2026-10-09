# Position of card #card in the list euchre:tmp gh, or -1. Consumes gh.
#   out: #idx
scoreboard players set #idx euchre.tmp -1
scoreboard players set #i euchre.tmp 0
function euchre:rules/hand_index_next
