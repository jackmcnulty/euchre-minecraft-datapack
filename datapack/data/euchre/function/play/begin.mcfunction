# As/at the table marker once trump is settled: the player left of the dealer
# leads the first trick.
scoreboard players operation @s euchre.leader = @s euchre.dealer
scoreboard players add @s euchre.leader 1
scoreboard players operation @s euchre.leader %= #4 euchre.g
execute if score @s euchre.leader = @s euchre.alone run function euchre:play/skip_leader
scoreboard players operation @s euchre.turn = @s euchre.leader
scoreboard players set @s euchre.trickno 0
scoreboard players set @s euchre.tricks0 0
scoreboard players set @s euchre.tricks1 0
scoreboard players set @s euchre.led -1
scoreboard players set @s euchre.phase 6
# Trump is known: re-sort hands with trump first and the bowers on top.
function euchre:card/refresh_hands
function euchre:table/display/update
function euchre:play/prompt
