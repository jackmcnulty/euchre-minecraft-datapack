# As/at the table marker: the maker plays alone, so their partner (opposite
# seat) sits this hand out. Their cards go back to the table: the stored hand is
# emptied first, so the reconciler agrees they should hold nothing.
scoreboard players operation @s euchre.alone = @s euchre.maker
scoreboard players add @s euchre.alone 2
scoreboard players operation @s euchre.alone %= #4 euchre.g
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #out euchre.tmp = @s euchre.alone
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #out euchre.tmp
function euchre:game/load with storage euchre:tmp q
function euchre:bid/empty_hand with storage euchre:tmp q
function euchre:game/save with storage euchre:tmp q
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #out euchre.tmp run function euchre:bid/sit_out
