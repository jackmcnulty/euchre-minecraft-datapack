# The datapack loads, initialises its state, and passes its own selftest.
execute unless function euchre:selftest run fail "euchre:selftest failed"
assert score #active euchre.g matches 0
assert data storage euchre:defaults setup{wager:0,target:5}
