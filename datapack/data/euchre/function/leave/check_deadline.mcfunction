# As/at a paused table marker, every tick.
execute store result score #now euchre.tmp run time query gametime
execute if score #now euchre.tmp >= @s euchre.deadline run function euchre:leave/timeout
