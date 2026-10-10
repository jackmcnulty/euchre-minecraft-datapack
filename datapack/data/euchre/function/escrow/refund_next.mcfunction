execute unless data storage euchre:tmp el[0] run return 0
data modify storage euchre:tmp pay set from storage euchre:tmp el[0]
data modify storage euchre:tmp pay.reason set value "refund"
function euchre:escrow/pay
data remove storage euchre:tmp el[0]
function euchre:escrow/refund_next
