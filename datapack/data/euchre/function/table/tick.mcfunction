# As/at an active table marker, every tick.
scoreboard players operation #tid euchre.tmp = @s euchre.tid

# Seated players who got up (sneaking) or were knocked off: free their seat.
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp unless function euchre:seat/still_seated run function euchre:seat/stand
scoreboard players operation #tid euchre.tmp = @s euchre.tid

# Seated players who disconnected aren't in @a any more. If fewer seated players
# are online than the table expects, find which seats are empty-handed.
scoreboard players set #on euchre.tmp 0
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run scoreboard players add #on euchre.tmp 1
execute if score #on euchre.tmp < @s euchre.seated run function euchre:table/find_absent

# Phase timer (-1 = off): counts down, and the phase decides what happens at zero.
# It stands still while the game is paused for a missing player.
execute unless score @s euchre.phase matches 10 if score @s euchre.timer matches 1.. run scoreboard players remove @s euchre.timer 1
execute unless score @s euchre.phase matches 10 if score @s euchre.timer matches 0 run function euchre:game/on_timer
execute if score @s euchre.phase matches 10 run function euchre:leave/check_deadline

# Keep every hand in step with storage (twice a second, only mid-hand).
execute if score #t10 euchre.g matches 0 if score @s euchre.phase matches 3..9 run function euchre:game/reconcile
