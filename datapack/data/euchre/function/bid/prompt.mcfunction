# As/at the table marker: enable the trigger for the player whose turn it is and
# send them their clickable choices. Everyone else's trigger stays disabled.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #turn euchre.tmp = @s euchre.turn
scoreboard players operation #up_suit euchre.tmp = @s euchre.upcard
scoreboard players operation #up_suit euchre.tmp /= #6 euchre.g
scoreboard players operation #down euchre.tmp = #up_suit euchre.tmp
# Stick the dealer: in round 2 the dealer may not pass.
scoreboard players set #canpass euchre.tmp 1
execute store result score #stick euchre.tmp run function euchre:table/get_stick
execute if score @s euchre.phase matches 5 if score #stick euchre.tmp matches 1 if score @s euchre.turn = @s euchre.dealer run scoreboard players set #canpass euchre.tmp 0
scoreboard players operation #phase euchre.tmp = @s euchre.phase
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #turn euchre.tmp run function euchre:bid/prompt_player
