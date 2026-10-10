# Follow-suit edge cases around the left bower, written out by hand.
# Card ids: suit*6 + rank; suits clubs 0, spades 1, diamonds 2, hearts 3; J = rank 2.

# Hearts trump: the left bower is J-diamonds (14).
scoreboard players set #trump euchre.tmp 3

# Trump led, holding only the left bower as trump: it must be played.
scoreboard players set #led euchre.tmp 3
data modify storage euchre:tmp gh set value [14,7]
scoreboard players set #card euchre.tmp 7
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 0
scoreboard players set #card euchre.tmp 14
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1

# Diamonds led: the left bower is not a diamond, so it doesn't follow...
scoreboard players set #led euchre.tmp 2
data modify storage euchre:tmp gh set value [14,7]
scoreboard players set #card euchre.tmp 7
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1
# ...and holding a real diamond, you can't throw the left bower instead.
data modify storage euchre:tmp gh set value [14,13]
scoreboard players set #card euchre.tmp 14
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 0
scoreboard players set #card euchre.tmp 13
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1

# Leading: anything goes.
scoreboard players set #led euchre.tmp -1
scoreboard players set #card euchre.tmp 14
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1

# Clubs trump: the left bower is J-spades (8), which becomes a club.
scoreboard players set #trump euchre.tmp 0
scoreboard players set #led euchre.tmp 1
data modify storage euchre:tmp gh set value [8,3]
scoreboard players set #card euchre.tmp 3
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1
scoreboard players set #card euchre.tmp 8
execute store success score #ok euchre.tmp run function euchre:rules/is_legal
assert score #ok euchre.tmp matches 1
# The card being judged is preserved for the caller.
assert score #card euchre.tmp matches 8
