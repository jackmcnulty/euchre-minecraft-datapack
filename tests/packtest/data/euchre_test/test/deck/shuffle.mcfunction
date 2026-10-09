# Shuffling yields a permutation of all 24 cards, and not a fixed order.
function euchre:deck/shuffle
execute unless function euchre_test:check_permutation run fail "shuffle 1 is not a permutation of 0-23"
data modify storage euchre_test:t first set from storage euchre:tmp shuffled
function euchre:deck/shuffle
execute unless function euchre_test:check_permutation run fail "shuffle 2 is not a permutation of 0-23"
function euchre:deck/shuffle
execute unless function euchre_test:check_permutation run fail "shuffle 3 is not a permutation of 0-23"
# Identical first and third orders would mean the shuffle is not random
# (by luck: 1 in 24!, about 1 in 6e23).
data modify storage euchre_test:t third set from storage euchre:tmp shuffled
execute store success score #diff euchre.tmp run data modify storage euchre_test:t third set from storage euchre_test:t first
assert score #diff euchre.tmp matches 1
