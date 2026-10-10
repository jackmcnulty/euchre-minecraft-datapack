# Sort the card ids in euchre:tmp gh into display order (see rules/sort_key).
#   in: euchre:tmp gh, #sorttrump. out: euchre:tmp gh, sorted.
# Selection sort: a hand holds at most 6 cards. #trump and #led are restored.
scoreboard players operation #strump euchre.tmp = #trump euchre.tmp
scoreboard players operation #sled euchre.tmp = #led euchre.tmp
data modify storage euchre:tmp sorted set value []
function euchre:rules/sort_pass
data modify storage euchre:tmp gh set from storage euchre:tmp sorted
scoreboard players operation #trump euchre.tmp = #strump euchre.tmp
scoreboard players operation #led euchre.tmp = #sled euchre.tmp
