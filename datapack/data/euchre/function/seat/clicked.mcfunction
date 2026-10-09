# Advancement reward (euchre:seat_click): the player right-clicked a cushion.
# Vanilla does the actual sitting, so check one tick later once they're riding it.
advancement revoke @s only euchre:seat_click
tag @s add euchre.sit_check
schedule function euchre:seat/deferred_check 1t
