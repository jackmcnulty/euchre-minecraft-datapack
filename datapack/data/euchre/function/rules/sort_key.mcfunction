# Display order of a card in a hand. Pure: scoreboard registers in euchre.tmp.
#   in:  #card, #sorttrump (trump suit, or -1 before trump is known)
#   out: #key (lower sorts first)
# Suits alternate colours (clubs, diamonds, spades, hearts: order = 2*(suit%2) +
# suit/2), high to low within a suit. Once trump is known, trump (by effective
# suit, so the left bower too) comes first, ordered by power: right bower,
# left bower, A, K, Q, 10, 9.
scoreboard players operation #suit euchre.tmp = #card euchre.tmp
scoreboard players operation #suit euchre.tmp /= #6 euchre.g
scoreboard players operation #rank euchre.tmp = #card euchre.tmp
scoreboard players operation #rank euchre.tmp %= #6 euchre.g
scoreboard players operation #key euchre.tmp = #suit euchre.tmp
scoreboard players operation #key euchre.tmp %= #2 euchre.g
scoreboard players operation #key euchre.tmp *= #2 euchre.g
scoreboard players operation #half euchre.tmp = #suit euchre.tmp
scoreboard players operation #half euchre.tmp /= #2 euchre.g
scoreboard players operation #key euchre.tmp += #half euchre.tmp
scoreboard players operation #key euchre.tmp *= #10 euchre.g
scoreboard players add #key euchre.tmp 105
scoreboard players operation #key euchre.tmp -= #rank euchre.tmp
execute if score #sorttrump euchre.tmp matches 0.. run function euchre:rules/sort_key_trump
