# Shuffle a fresh 24-card deck into euchre:tmp shuffled.
data modify storage euchre:tmp deck set value [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
data modify storage euchre:tmp shuffled set value []
# Test hook: a deck order placed in euchre:debug rig is used once instead of
# shuffling. Only commands (operators, tests) can write storage, not players.
execute if data storage euchre:debug rig run return run function euchre:deck/use_rig
scoreboard players set #n euchre.tmp 24
function euchre:deck/shuffle_step
