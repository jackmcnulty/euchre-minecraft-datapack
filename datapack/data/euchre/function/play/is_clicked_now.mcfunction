# As a card spot: succeeds if the player tagged euchre.clicking clicked it this tick.
execute store result score #ts euchre.tmp run data get entity @s interaction.timestamp
execute unless score #ts euchre.tmp = #now euchre.tmp run return fail
execute on target if entity @s[tag=euchre.clicking] run return 1
return fail
