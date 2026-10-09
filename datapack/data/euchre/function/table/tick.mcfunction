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
