# As a player who clicked a bidding button (ran /trigger euchre.act set N).
# Vanilla disables the trigger again after one use.
scoreboard players operation #act euchre.tmp = @s euchre.act
scoreboard players set @s euchre.act 0
data modify storage euchre:tmp b set value {}
execute store result storage euchre:tmp b.value int 1 run scoreboard players get #act euchre.tmp
function euchre:bid/act with storage euchre:tmp b
