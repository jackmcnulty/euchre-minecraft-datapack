# Check this player again in a second, once the table has loaded.
tag @s add euchre.sit_check
schedule function euchre:seat/deferred_check 20t
return fail
