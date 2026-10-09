# Sanity check that the pack loaded and initialised correctly.
# Returns 1 on success and fails otherwise, so it can be used as
# `execute if function euchre:selftest ...` in tests and CI.

execute unless data storage euchre:meta {schema:1} run return fail
execute unless score #active euchre.g matches 0.. run return fail

# The card table must hold exactly 24 cards. (`data get` on a list returns its length.)
execute store result score #n euchre.tmp run data get storage euchre:cards table
execute unless score #n euchre.tmp matches 24 run return fail

# Spot-check the id scheme: card 17 = suit 2 (diamonds), rank 5 (ace).
execute unless data storage euchre:cards table[17]{suit:2,rank:5} run return fail

tellraw @a[tag=euchre.notify] {text:"[Euchre] selftest ok",color:"green"}
return 1
