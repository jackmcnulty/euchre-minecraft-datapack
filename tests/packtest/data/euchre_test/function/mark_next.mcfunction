execute unless data storage euchre_test:t l[0] run return 0
data modify storage euchre_test:t m.v set from storage euchre_test:t l[0]
function euchre_test:mark with storage euchre_test:t m
data remove storage euchre_test:t l[0]
function euchre_test:mark_next
