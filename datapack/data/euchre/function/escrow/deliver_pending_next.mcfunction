# Walk the old pending list: pay this player's entries, keep everyone else's.
execute unless data storage euchre:tmp pl[0] run return 0
data modify storage euchre:tmp pay set from storage euchre:tmp pl[0]
execute if function euchre:escrow/is_payee run function euchre:escrow/deliver_one_pending
execute unless function euchre:escrow/is_payee run data modify storage euchre:pending list append from storage euchre:tmp pay
data remove storage euchre:tmp pl[0]
function euchre:escrow/deliver_pending_next
