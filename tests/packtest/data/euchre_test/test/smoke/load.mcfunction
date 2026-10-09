# The datapack loads, initialises its state, and passes its own selftest.
assert data storage euchre:meta {schema:1}
execute unless function euchre:selftest run fail "euchre:selftest failed"
assert data storage euchre:defaults setup{wager:0,target:5}
