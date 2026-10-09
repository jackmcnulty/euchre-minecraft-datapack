# As/at a table marker mid-hand: make every seated player's card items match
# their hand in storage exactly.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get @s euchre.tid
function euchre:game/load with storage euchre:tmp q
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:card/reconcile_player
