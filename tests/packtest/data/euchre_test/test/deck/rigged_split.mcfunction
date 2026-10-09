# @timeout 1200
# A rigged deck splits predictably: seat s gets cards 5s..5s+4, the kitty 20-23.
# Shares euchre:debug rig with the table tests, so take the same lock.
await not data storage euchre_test:lock {held:1b}
function euchre_test:lock
data modify storage euchre:debug rig set value [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
function euchre:deck/shuffle
assert not data storage euchre:debug rig
function euchre:gen/deal_split
assert data storage euchre:tmp game{hands:[[0,1,2,3,4],[5,6,7,8,9],[10,11,12,13,14],[15,16,17,18,19]],kitty:[20,21,22,23]}
function euchre_test:unlock
