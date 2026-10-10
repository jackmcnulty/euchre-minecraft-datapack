# As/at the table marker once trump is known: re-sort every hand with trump
# first and reissue the cards in that order. Card items are only a view of
# storage, so clearing and giving them again is safe.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
scoreboard players operation #sorttrump euchre.tmp = @s euchre.trump
function euchre:game/sort_hands
function euchre:game/save with storage euchre:tmp q
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:card/reissue_hand
